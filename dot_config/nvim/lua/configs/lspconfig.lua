local nvlsp = require "nvchad.configs.lspconfig"

-- 1. Setup your standard servers using the new built-in API
local servers = { "html", "ts_ls" }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
  vim.lsp.enable(lsp) -- This physically activates the language server
end

-- 2. Setup your custom GTK-ignoring cssls server using the new API
vim.lsp.config("cssls", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    css = {
      lint = {
        unknownAtRules = "ignore" -- Keeps silencing your @define-color errors!
      }
    }
  }
})
vim.lsp.enable("cssls") -- Spawns cssls natively
-- read :h vim.lsp.config for changing options of lsp servers 
