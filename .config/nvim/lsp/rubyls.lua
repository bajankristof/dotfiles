-- gem install ruby-lsp ruby-lsp-rails ruby-lsp-rspec

return {
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', 'Gemfile.lock' },
  init_options = { formatter = 'auto' },
}

