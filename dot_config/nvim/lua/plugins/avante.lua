return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  opts = {
    provider = "bedrock",
    providers = {
      bedrock = {
        model = "eu.anthropic.claude-opus-4-6-v1",
        aws_region = "eu-west-1",
        aws_profile = "sso-bedrock",
        extra_request_body = {
          max_tokens = 8192,
        },
      },
    },
  },
  config = function(_, opts)
    -- Check if SSO session is valid, login if not
    local function ensure_aws_sso()
      local result = vim.fn.system("aws sts get-caller-identity --profile sso-bedrock 2>&1")
      if vim.v.shell_error ~= 0 then
        vim.notify("AWS SSO session expired, logging in...", vim.log.levels.INFO)
        vim.fn.system("aws sso login --profile sso-bedrock")
      end
    end

    ensure_aws_sso()
    require("avante").setup(opts)
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-mini/mini.icons",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = { file_types = { "markdown", "Avante" } },
      ft = { "markdown", "Avante" },
    },
  },
}
