return {
  cmd = {
    "clangd",
  },
  capabilities = {
    textDocument = {
      inactiveRegionsCapabilities = {
        inactiveRegions = true,
      },
    },
  },
  filetypes = {
    "c",
    "cpp",
  },
}
