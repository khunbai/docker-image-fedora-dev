-- Set the SatelliteBar highlight group
vim.api.nvim_set_hl(0, "SatelliteBar", { bg = "#FFC55A" })
vim.api.nvim_set_hl(0, "SatelliteBackground", { link = "None" })

return {
  "lewis6991/satellite.nvim",
  -- NOTE: This plugin is not compatible with "jake-stewart/multicursor.nvim"
  --       as it causes nvim unresponsive if cursors are actived and switch out
  --       to other apps. Disable it if you think it's not worth it.
  enabled = true,
  opts = {
    current_only = false,
    winblend = 50,
    zindex = 40,
    excluded_filetypes = {},
    width = 2,
    handlers = {
      cursor = {
        enable = true,
        -- Supports any number of symbols
        symbols = { '⎺', '⎻', '⎼', '⎽' }
        -- symbols = { '⎻', '⎼' }
        -- Highlights:
        -- - SatelliteCursor (default links to NonText
      },
      search = {
        enable = true,
        -- Highlights:
        -- - SatelliteSearch (default links to Search)
        -- - SatelliteSearchCurrent (default links to SearchCurrent)
      },
      diagnostic = {
        enable = true,
        signs = { '-', '=', '≡' },
        min_severity = vim.diagnostic.severity.HINT,
        -- Highlights:
        -- - SatelliteDiagnosticError (default links to DiagnosticError)
        -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
        -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
        -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
      },
      gitsigns = {
        enable = true,
        signs = { -- can only be a single character (multibyte is okay)
          add = "│",
          change = "│",
          delete = "-",
        },
        -- Highlights:
        -- SatelliteGitSignsAdd (default links to GitSignsAdd)
        -- SatelliteGitSignsChange (default links to GitSignsChange)
        -- SatelliteGitSignsDelete (default links to GitSignsDelete)
      },
      marks = {
        enable = true,
        show_builtins = false, -- shows the builtin marks like [ ] < >
        key = 'm'
        -- Highlights:
        -- SatelliteMark (default links to Normal)
      },
      quickfix = {
        signs = { '-', '=', '≡' },
        -- Highlights:
        -- SatelliteQuickfix (default links to WarningMsg)
      }
    },
  },
}
