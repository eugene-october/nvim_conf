# Technology Stack

**Analysis Date:** 2026-03-26

## Languages

**Primary:**
- Lua (LuaJIT 2.1) - All configuration files and plugin definitions
- Vimscript (minimal) - Only for colorscheme command in `lua/plugins/colorscheme.lua`

**Secondary:**
- JSON - Plugin lockfile (`lazy-lock.json`)

## Runtime

**Environment:**
- Neovim v0.11.6 (Build type: Release)
- LuaJIT 2.1.1772619647

**Plugin Manager:**
- lazy.nvim - Modern plugin manager with lazy loading
  - Bootstrap: `lua/config/lazy.lua` (lines 2-16)
  - Lockfile: `lazy-lock.json` present
  - Auto-update checking enabled

## Frameworks

**Core:**
- Neovim Lua API - Core configuration framework

**Plugin System:**
- lazy.nvim spec format - All plugins return Lua tables with `config`, `dependencies`, `build`, etc.

## Key Dependencies

**Plugin Ecosystem (from lazy-lock.json):**

| Plugin | Commit | Purpose |
|--------|--------|---------|
| lazy.nvim | 85c7ff37 | Plugin manager core |
| nvim-lspconfig | 1a6d6920 | LSP configuration framework |
| nvim-treesitter | 6620ae1c | Syntax highlighting via treesitter |
| nvim-cmp | a1d50489 | Autocompletion engine |
| telescope.nvim | a0bbec211 | Fuzzy finder and file picker |
| nvim-tree.lua | 6eaf74c9 | File explorer |
| lualine.nvim | 47f91c41 | Status line |
| gitsigns.nvim | b8034e2e | Git integration in signs column |
| plenary.nvim | b9fd5226 | Lua utility library |
| nvim-web-devicons | d7462543 | File icons |
| catppuccin/nvim | a7788416 | Color scheme |

**Dependency Graph:**
- `telescope.nvim` depends on `plenary.nvim`
- `nvim-tree.lua` depends on `nvim-web-devicons`
- `lualine.nvim` depends on `nvim-web-devicons`

## Configuration

**Entry Point:**
- `init.lua` - Minimal bootstrap that loads `config.lazy` and `config.keybindings`

**Structure:**
- `lua/config/` - Core configuration modules
- `lua/plugins/` - Plugin specifications (lazy.nvim imports all files in this directory)

**Key Configuration Files:**
- `lua/config/lazy.lua` - Plugin manager setup, leader key configuration
- `lua/config/keybindings.lua` - Core keybindings (window management, save/quit)
- `lua/plugins/*.lua` - Individual plugin configurations

**Leader Keys:**
- `<leader>` = `,` (comma)
- `<localleader>` = `\` (backslash)

## Platform Requirements

**Development:**
- Neovim v0.11+ (uses `vim.lsp.enable` API)
- Git (for plugin installation/bootstrap)
- ripgrep (required by telescope `live_grep`)
- fd (recommended for telescope file finding)

**Production:**
- Configuration is user-local, no deployment needed

---

*Stack analysis: 2026-03-26*