# Codebase Concerns

**Analysis Date:** 2026-03-26

## Tech Debt

**Minimal LSP Configuration:**
- Issue: Only `csharp_ls` is enabled with no actual LSP setup configuration
- Files: `lua/plugins/lsp-config.lua`
- Impact: No LSP features for other languages; no keybindings for LSP actions (go-to-definition, hover, rename, etc.)
- Fix approach: Add complete LSP setup with `lspconfig` capabilities, keybindings, and language server configurations

**Treesitter Missing Configuration:**
- Issue: Plugin imported but no `config` function to set up parsers
- Files: `lua/plugins/treesitter.lua`
- Impact: Syntax highlighting and textobjects may not work correctly; no parser installation control
- Fix approach: Add `config` function with `ensure_installed` for common languages and `highlight`/`indent` enable settings

**Missing Global Editor Options:**
- Issue: No `vim.opt` settings for basic editor behavior (encoding, tab width, line numbers, etc.)
- Files: `lua/config/lazy.lua` (line 16 is only vim.opt usage)
- Impact: Inconsistent editing experience across files; may conflict with plugin expectations
- Fix approach: Create `lua/config/options.lua` with standard settings (encoding, expandtab, shiftwidth, number, relativenumber, etc.)

**Incomplete Completion Setup:**
- Issue: `nvim-cmp` only configured with `path` and `buffer` sources; no LSP completion
- Files: `lua/plugins/cmp.lua`
- Impact: No intelligent code completion; manual completion only
- Fix approach: Add `nvim_lsp` source and install `cmp-nvim-lsp` plugin; add snippet engine (`LuaSnip` or `vim-vsnip`)

## Known Bugs

**No documented bugs at this time.**
- The configuration is minimal and functional for what's configured
- No error-inducing patterns detected in existing code

## Security Considerations

**Plugin Bootstrap Security:**
- Risk: Lazy.nvim bootstraps from GitHub clone without signature verification
- Files: `lua/config/lazy.lua` (lines 4-15)
- Current mitigation: Uses `--branch=stable` to pin to stable release
- Recommendations: Consider pinning to a specific commit hash in lockfile; lazy-lock.json helps but bootstrap downloads dynamic code

**No Secrets Exposure:**
- `.env` files not present
- Hardcoded passwords/tokens not detected
- `.gitignore` properly excludes agent configuration directories

## Performance Bottlenecks

**Telescope Pinned to Old Tag:**
- Problem: Locked to tag `0.1.8` while `telescope.nvim` is actively developed
- Files: `lua/plugins/telescope.lua` (line 3)
- Cause: Explicit version pin prevents performance improvements and bug fixes
- Improvement path: Remove `tag` constraint or update to newer version; let lazy-lock.json handle versioning

**Plenary Lazy Loading:**
- Problem: Plenary is lazy-loaded but is a dependency of Telescope
- Files: `lua/plugins/plenary.lua`
- Cause: `lazy = true` may cause initial Telescope load to be slower due to dependency chain
- Improvement path: Remove explicit `lazy = true` since Telescope already triggers lazy loading of its dependencies

**Plugin Update Checker Overhead:**
- Problem: `checker = { enabled = true }` runs update checks on startup
- Files: `lua/config/lazy.lua` (line 34)
- Cause: Automatic checking adds startup time
- Improvement path: Consider disabling or making check asynchronous; use `notify = false` to reduce output noise

## Fragile Areas

**Plugin Keybinding Conflicts:**
- Files: `lua/config/keybindings.lua`
- Why fragile: Leader key `,` and multiple `<leader>` keybindings may conflict with plugin defaults (especially gitsigns `<leader>h*` mappings)
- Safe modification: Audit all plugin keymaps before adding new ones; use `which-key` for discovery
- Test coverage: No verification that keymaps don't shadow each other

**Single-File Plugin Definitions:**
- Files: `lua/plugins/*.lua`
- Why fragile: Each plugin in isolated file with no shared configuration; difficult to coordinate inter-plugin dependencies
- Safe modification: When adding related plugins, ensure dependency declarations are consistent
- Test coverage: Changes to one plugin file won't surface errors in others

**Bootstrap Failure Handling:**
- Files: `lua/config/lazy.lua` (lines 6-14)
- Why fragile: On clone failure, exits Neovim entirely; no fallback or recovery mechanism
- Safe modification: Add retry logic or manual intervention prompt
- Test coverage: No way to test bootstrap failure paths

## Scaling Limits

**Single-Language LSP Support:**
- Current capacity: Only C# LSP configured
- Limit: No TypeScript, Python, Lua, or other common language support
- Scaling path: Add language-specific LSP servers to `lsp-config.lua` or create `lua/plugins/lsp/` directory for per-language configs

**No Formatters/Linters:**
- Current capacity: None configured
- Limit: Code quality tools must be run externally
- Scaling path: Add `conform.nvim` for formatting and `nvim-lint` for linting

**Missing Debug Adapter Protocol:**
- Current capacity: No debugging support
- Limit: Cannot debug code from within Neovim
- Scaling path: Add `nvim-dap` plugin with language adapters

## Dependencies at Risk

**Telescope Tag Pin:**
- Risk: Locked to `0.1.8`; may become incompatible with newer Neovim versions
- Impact: Live grep, find_files may break with future updates
- Migration plan: Monitor telescope releases; test newer tags; update to latest stable

**No LSP Capabilities Integration:**
- Risk: `nvim-lspconfig` installed but not connected to `nvim-cmp`
- Impact: No completion from LSP sources
- Migration plan: Add `cmp-nvim-lsp` and configure `capabilities` in LSP setup

## Missing Critical Features

**No Which-Key Integration:**
- Problem: No keybinding discovery interface
- Blocks: Cannot see available keybindings; poor UX for discovering <leader> mappings
- Recommendation: Add `folke/which-key.nvim` plugin

**No Filetype-Specific Settings:**
- Problem: No `ftplugin/` directory or autocmds for filetype handling
- Blocks: Cannot customize behavior per language without modifying main config
- Recommendation: Create `lua/config/ft/` for filetype-specific settings

**No Terminal Integration:**
- Problem: No `<leader>tf` type mappings for terminal
- Blocks: Cannot toggle terminal from Neovim
- Recommendation: Add `toggleterm.nvim` or `vim.ui.input` terminal mappings

**No Project Management:**
- Problem: No project root detection or project-switching
- Blocks: Cannot quickly switch between projects or set project-specific settings
- Recommendation: Add `project.nvim` for project management

## Test Coverage Gaps

**No Configuration Testing:**
- What's not tested: Plugin load order, keybinding conflicts, LSP attachments
- Files: All `lua/plugins/*.lua`
- Risk: Plugin updates may silently break configurations; no regression testing
- Priority: Medium

**No Startup Benchmarking:**
- What's not tested: Neovim startup time; plugin load timing
- Files: `init.lua`, `lua/config/lazy.lua`
- Risk: Performance regressions go undetected
- Priority: Low

## Configuration Gaps

**No Autopairs:**
- Problem: Auto-closing brackets, quotes, etc. not configured
- Files: N/A (missing plugin)
- Recommendation: Add `nvim-autopairs` plugin

**No Comment Keybinding:**
- Problem: No `gcc`/`gc` style commenting
- Files: `lua/config/keybindings.lua`
- Recommendation: Add `Comment.nvim` or `vim-commentary`

**No Git Integration Beyond Signs:**
- Problem: Gitsigns configured but no `vim-fugitive` or `neogit` for git commands
- Files: `lua/plugins/gitsigns.lua`
- Recommendation: Add comprehensive git UI plugin if git workflow is important

---

*Concerns audit: 2026-03-26*