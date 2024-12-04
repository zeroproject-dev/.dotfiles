return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      angularls = {
        on_new_config = function(new_config, _)
          local ok, mason_registry = pcall(require, "mason-registry")
          if not ok then
            vim.notify("mason-registry could not be loaded")
            return
          end
          local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()
          local cmd = {
            "ngserver",
            "--stdio",
            "--tsProbeLocations",
            table.concat({
              angularls_path,
              vim.uv.cwd(),
            }, ","),
            "--ngProbeLocations",
            table.concat({
              angularls_path .. "/node_modules/@angular/language-server",
              vim.uv.cwd(),
            }, ","),
          }

          new_config.cmd = cmd
        end,
      },
    },
  },
}
