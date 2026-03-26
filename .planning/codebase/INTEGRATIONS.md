# External Integrations

**Analysis Date:** 2026-03-26

## Language Servers (LSP)

**Configured LSPs:**
- `csharp_ls` - C# language server
  - Location: `lua/plugins/lsp-config.lua` (line 6)
  - Setup: `vim.lsp.enable('csharp_ls')`
  - Status: Single LSP configured

**LSP Framework:**
- nvim-lspconfig plugin provides LSP client configuration
- Uses Neovim 0.11+ native `vim.lsp.enable()` API

## External Tools

**Git:**
- Required for lazy.nvim bootstrap (clone operation)
- Integrated via gitsigns.nvim plugin
  - File: `lua/plugins/gitsigns.lua`
  - Features: Hunk navigation, staging, reset, blame
  - Keymaps: `]c`/`[c` (hunk nav), `<leader>hs` (stage), `<leader>hr` (reset), `<leader>hp` (preview), `<leader>hb` (blame)

**File Finding (Telescope):**
- ripgrep (`rg`) - Required for `live_grep` functionality
  - Keymap: `<leader>fg` - Live grep search
- fd (`fdfind`) - Recommended for `find_files` performance
  - Keymap: `<leader>p` - Find files
- Location: `lua/plugins/telescope.lua`

**Tree-sitter Parsers:**
- Automatically installed/updated via `:TSUpdate`
- Location: `lua/plugins/treesitter.lua`
- Build command runs on plugin update

## File System

**File Explorer:**
- nvim-tree.lua - Side panel file browser
  - Location: `lua/plugins/nvim-tree.lua`
  - Disables netrw (`vim.g.loaded_netrw = 1`)
  - Width: 30 columns
  - Toggle: `<leader>e`

**Search/Navigation:**
- Telescope.nvim - Fuzzy finder
  - Find files: `<leader>p`
  - Live grep: `<leader>fg`
  - Buffers: `<leader>fb`
  - Help tags: `<leader>fh`

## Editor Components

**Autocompletion:**
- nvim-cmp engine
  - Location: `lua/plugins/cmp.lua`
  - Sources: path, buffer (keyword_length: 3)
  - Triggers: `InsertEnter`, `CmdlineEnter` events
  - Keymaps: `<C-Space>` (complete), `<CR>` (confirm), `<C-e>` (abort)

**Status Line:**
- lualine.nvim
  - Location: `lua/plugins/lualine.lua`
  - Theme: auto (adapts to colorscheme)
  - Global status enabled

**Icons:**
- nvim-web-devicons
  - Location: `lua/plugins/devicons.lua`
  - Used by: nvim-tree, lualine

**Color Scheme:**
- catppuccin/nvim
  - Location: `lua/plugins/colorscheme.lua`
  - Lazy loaded: false (immediate load)
  - Priority: 1000 (loads first)

## Authentication & Identity

**Auth Provider:**
- None - This is a local editor configuration

## Monitoring & Observability

**Error Tracking:**
- None configured

**Logs:**
- Neovim default logging (`~/.local/state/nvim/log`)

## CI/CD & Deployment

**Hosting:**
- Local configuration only
- Git repository for version control

**CI Pipeline:**
- None (personal configuration)

## Environment Configuration

**Required External Tools:**
- `git` - Plugin installation
- `rg` (ripgrep) - Telescope live grep
- `fd` (recommended) - Telescope file finding
- `csharp_ls` (optional) - C# development

**No Environment Variables:**
- Configuration is self-contained
- No `.env` files or secrets

## Webhooks & Callbacks

**Incoming:**
- None

**Outgoing:**
- None

---

*Integration audit: 2026-03-26*