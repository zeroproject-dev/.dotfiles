local status, comment = pcall(require, "nvim_comment")
if not status then return end

comment.setup({
  comment_empty = false,
  line_mapping = "<leader>cl",
  operator_mapping = "<leader>c",
})
