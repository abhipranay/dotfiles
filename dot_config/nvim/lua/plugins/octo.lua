return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      use_local_fs = true, -- RIGHT side uses real files (LSP works)
      mappings = {
        pull_request = {
          checkout_pr = { lhs = "<C-x>", desc = "checkout PR branch" },
          list_commits = { lhs = "<leader>Gc", desc = "list PR commits" },
          show_pr_diff = { lhs = "<leader>Gd", desc = "show PR diff" },
        },
        review_thread = {
          add_comment = { lhs = "<leader>ca", desc = "add comment" },
          next_comment = { lhs = "]c", desc = "next comment" },
          prev_comment = { lhs = "[c", desc = "prev comment" },
          select_next_entry = { lhs = "]q", desc = "next file" },
          select_prev_entry = { lhs = "[q", desc = "prev file" },
        },
        submit_win = {
          approve_review = { lhs = "<C-a>", desc = "approve" },
          comment_review = { lhs = "<C-m>", desc = "comment" },
          request_changes = { lhs = "<C-r>", desc = "request changes" },
        },
        review_diff = {
          toggle_viewed = { lhs = "<leader>v", desc = "toggle viewed" },
          focus_files = { lhs = "<leader>f", desc = "focus files panel" },
        },
      },
    },
    keys = {
      { "<leader>Gp", "<cmd>Octo pr list<cr>", desc = "Octo PR List" },
      { "<leader>Gs", "<cmd>Octo search<cr>", desc = "Octo Search" },
      { "<leader>Gr", "<cmd>Octo review start<cr>", desc = "Octo Start Review" },
      { "<leader>GR", "<cmd>Octo review resume<cr>", desc = "Octo Resume Review" },
      { "<leader>Gx", "<cmd>Octo review discard<cr>", desc = "Octo Discard Review" },
      { "<leader>Ga", "<cmd>Octo comment add<cr>", desc = "Octo Add Comment" },
    },
  },
}
