# Coding Conventions

**Analysis Date:** 2026-03-26

## Naming Patterns

**Files:**
- Configuration modules: lowercase, single word (`keybindings.lua`, `lazy.lua`)
- Plugin specs: lowercase, hyphen-separated for multi-word plugins (`lsp-config.lua`, `nvim-tree.lua`)
- Simple plugins: single word matching plugin name (`telescope.lua`, `cmp.lua`, `gitsigns.lua`)

**Variables:**
- Local variables: snake_case (`local lazypath`, `local builtin`, `local api`)
- Tables: snake_case or lowercase (`signs`, `options`)
- Functions: snake_case (`local function on_attach`, `local function opts`)

**Modules:**
- Require paths: dot-separated, lowercase (`require("config.lazy")`, `require("plugins")`)

## Code Style

**Formatting:**
- Indentation: Tabs
- Tables: Opening brace on same line, fields on new lines with indentation
- Multi-line tables: One field per line for readability
- Empty tables: Inline `{}` for simple cases

**Strings:**
- Double quotes for all strings (`"config.lazy"`, `"InsertEnter"`)
- Single quotes used for some char-like values (`'+', '~', '_'` in gitsigns)

**Comments:**
- Single-line comments use `--`
- Inline comments for important notes (`lazy = false -- make sure we load this during startup`)
- No docstrings or structured comment blocks

## Import Organization

**Order:**
1. Local variable declarations (paths, constants)
2. Conditional/bootstrap logic
3. Runtime modifications (`vim.opt.rtp:prepend`)
4. Module configuration setup
5. `require()` calls for modules

**Pattern:**
```lua
-- Variables first
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Bootstrap/conditional logic
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- setup code
end

-- Runtime modifications
vim.opt.rtp:prepend(lazypath)

-- Global settings
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Module setup
require("lazy").setup({ ... })
```

**Path Aliases:**
- None - uses standard Lua require paths
- Import via `{ import = "plugins" }` in lazy.nvim spec

## Plugin Specification Pattern

**Structure:**
```lua
return {
    "author/plugin-name",
    -- Optional: lazy loading triggers
    event = { "InsertEnter" },
    lazy = false,
    priority = 1000,
    -- Optional: dependencies
    dependencies = { "dep/plugin" },
    -- Required: configuration
    config = function()
        local plugin = require("plugin")
        plugin.setup({
            -- options
        })
    end,
}
```

**Lazy Loading:**
- `event = { "InsertEnter", "CmdlineEnter" }` - Load on events
- `lazy = false` - Load immediately (main colorscheme)
- `lazy = true` - Lazy load (dependencies only)
- `priority = 1000` - Load before other plugins

**Version Pinning:**
- Use `tag = "0.1.8"` for specific versions (`lua/plugins/telescope.lua`)
- Use `branch = "stable"` for branches (in bootstrap)

## Keymaps

**Pattern:**
```lua
-- Basic keymap
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })

-- With function
vim.keymap.set("n", "<leader>p", builtin.find_files, { desc = "Find files" })

-- Helper function for buffer-local keymaps
local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
end
```

**Options:**
- `desc`: Always include for discoverability
- `buffer`: For buffer-local keymaps (LSP, nvim-tree)
- `noremap = true, silent = true, nowait = true` - Common in plugin configs
- Leader: `,` (`vim.g.mapleader = ","`)
- Local leader: `\` (`vim.g.maplocalleader = "\\"`)

## Error Handling

**Patterns:**
- Minimal explicit error handling
- Bootstrap validation checks `vim.v.shell_error ~= 0`
- User feedback via `vim.api.nvim_echo()` with error highlighting
- Graceful exit on critical failures (`os.exit(1)`)

**Example from `lua/config/lazy.lua`:**
```lua
if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
end
```

## Tables and Configuration

**Setup Tables:**
```lua
require("plugin").setup({
    options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
    },
    signs = {
        add = { text = "+" },
        change = { text = "~" },
    },
})
```

**Nested Tables:**
- Flat when possible
- Grouped by logical concern (options, view, renderer, filters)
- Empty tables shown as `{}` or `override = {}`

## Function Design

**Local Helper Functions:**
```lua
local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
end
```

**Callbacks:**
- `on_attach` pattern for LSP/tree integrations
- Inline function definitions for simple keymaps
- Named functions for complex logic

## Module Design

**Exports:**
- Plugin files: Return table directly
- Config files: No return, use `require()` to execute

**Barrel Files:**
- `init.lua` imports all config modules
- Lazy.nvim auto-imports all plugins via `{ import = "plugins" }`

**File Organization:**
- One plugin per file
- Configuration in separate `lua/config/` directory
- Core setup in `lua/config/lazy.lua`

---

*Convention analysis: 2026-03-26*