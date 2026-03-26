# Architecture

**Analysis Date:** 2026-03-26

## Pattern Overview

**Overall:** Lazy.nvim Plugin Specification Pattern

**Key Characteristics:**
- Modular plugin architecture with declarative specifications
- Single-responsibility plugin modules
- Configuration separated from initialization
- Bootstrap-on-demand plugin management

## Layers

**Entry Layer:**
- Purpose: bootstrap configuration and load core modules
- Location: `init.lua`
- Contains:require statements for core config
- Depends on: `lua/config/` modules
- Used by: Neovim runtime on startup

**Configuration Layer:**
- Purpose: define editor settings and keybindings
- Location: `lua/config/`
- Contains: lazy.nvim setup, global keybindings, leader configuration
- Depends on: Neovim builtin APIs
- Used by: Entry layer

**Plugin Layer:**
- Purpose: define and configure editor plugins
- Location: `lua/plugins/`
- Contains:individual plugin specification modules
- Depends on: lazy.nvim,external plugin repositories
- Used by: lazy.nvim via `{ import = "plugins" }`

## Data Flow

**Startup Flow:**

1. Neovim loads `init.lua`
2. `init.lua` requires `config.lazy` (bootstraps lazy.nvim)
3. `config.lazy` sets `mapleader` and `maplocalleader`
4. lazy.nvim imports all specs from `plugins/` module
5. lazy.nvim installs missing plugins, loads configured plugins
6. `init.lua` requires `config.keybindings` (global keymaps)

**Plugin Loading Flow:**

1. lazy.nvim scans `lua/plugins/` directory
2. Each `*.lua` file returns a plugin spec table
3. Specs are merged and processed by lazy.nvim
4. Plugins load according to their `event`, `cmd`, or `lazy` settings
5. Plugin`config` functions execute when plugin loads

**State Management:**
- Global: `vim.g.mapleader`, `vim.g.maplocalleader`
- Plugin state: managed by individual plugins
- No centralized state management

## Key Abstractions

**Plugin Specification:**
- Purpose: Declaratively define plugin configuration
- Examples: `lua/plugins/telescope.lua`, `lua/plugins/cmp.lua`
- Pattern: Return table with `name`, `dependencies`, `config`, `event`, `build` keys

```lua
return {
    "author/plugin-name",
    dependencies = { "dep1", "dep2" },
    event = { "InsertEnter" },
    config = function()
        require("plugin").setup({ ... })
    end,
}
```

**Configuration Module:**
- Purpose: Encapsulate related settings in reusable modules
- Examples: `lua/config/lazy.lua`, `lua/config/keybindings.lua`
- Pattern: Side-effect modules that configure vim directly

**Lazy Import:**
- Purpose: Defer plugin loading for performance
- Examples: `plenary.lua` with `lazy = true`
- Pattern: Specify `event`, `cmd`, or `lazy = true` to control load timing

## Entry Points

**Main Entry (`init.lua`):**
- Location: `init.lua`
- Triggers: Neovim startup
- Responsibilities: Load config modules in correct order

**Plugin Bootstrap (`lua/config/lazy.lua`):**
- Location: `lua/config/lazy.lua`
- Triggers: Required by init.lua
- Responsibilities: Clone lazy.nvim if missing, setup plugin system, import plugin specs

## Error Handling

**Strategy:** Fail-fast with user notification

**Patterns:**
- Bootstrap errors display message and exit
- Plugin load errors shown inlazy.nvim UI
- No explicit error recovery in config modules

## Cross-Cutting Concerns

**Logging:** No custom logging; relies on vim notify and lazy.nvim messages

**Validation:** lazy.nvim validates plugin specs

**Modularity:** Each plugin is self-contained with its own configuration

---

*Architecture analysis: 2026-03-26*