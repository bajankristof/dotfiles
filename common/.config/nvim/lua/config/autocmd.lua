vim.api.nvim_create_autocmd("TermClose", {
  pattern = "*",
  callback = function(args)
    local bufnr = args.buf
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end)
  end,
})
