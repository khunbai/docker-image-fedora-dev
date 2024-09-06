return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    enable_git_status = true,
    sources = { "filesystem", "buffers", "git_status" },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          --"node_modules"
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
          "node_modules",
        },
      },
    },
    window = {
      position = "bottom", -- "float" | "left" | "right" | "split" | "bottom"
      width = "30%",  -- applicable when position is left or right
      height = "20%", -- applicable when position is top or bottom
      popup = { -- only applicable when position is "float"
        size = {
          width = "30%",
          height = "80%",
        },
        position = "5%", -- position of the floating window from the top.
      },
    },
    default_component_configs = {
      indent = {
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      git_status = {
        symbols = {
          -- Change type
          added     = "✚",
          modified  = "M",
          deleted   = "",
          -- Status type
          unstaged = "󰄱",
          staged = "󰱒",
          ignored   = "",
          conflict  = "",
        },
      },
    },
  },
}