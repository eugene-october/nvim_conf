# Codebase Structure

**Analysis Date:** 2026-03-26

## Directory Layout

```
~/.config/nvim/
├── init.lua              # Entry point - loads config modules
├── lazy-lock.json        # Plugin version lock file
├── lua/
│   ├── config/           # Core configuration modules
│   │   ├── lazy.lua      # lazy.nvim setup and bootstrap
│   │   └── keybindings.lua# Global keymaps
│   └── plugins/          # Plugin specifications
│       ├── cmp.lua       # Autocompletion config
│       ├── colorscheme.lua# Theme (catppuccin)
│       ├── devicons.lua  # File icons
│       ├── gitsigns.lua  # Git integration
│       ├── lsp-config.lua# LSP configuration
│       ├── lualine.lua   # Status line
│       ├── nvim-tree.lua # File explorer
│       ├── plenary.lua   # Utility library
│       ├── telescope.lua # Fuzzy finder
│       └── treesitter.lua# Syntax highlighting
├── .gitignore
└── .planning/           # Planning documents (not runtime)
```

## Directory Purposes

**`lua/config/`:**
- Purpose: Core editor configuration modules
- Contains: Setup scripts for plugin manager and global settings
- Key files: `lazy.lua` (plugin manager), `keybindings.lua` (keymaps)- Loaded at: Startup, before plugins

**`lua/plugins/`:**
- Purpose: Individual plugin specification modules
- Contains: One file per plugin/plugin-group
- Key files: All `*.lua` files are plugin specs
- Loaded by: lazy.nvim via `{ import = "plugins" }`

**Root (`~/.config/nvim/`):**
- Purpose: Entry point and lock file
- Contains: `init.lua` entry, `lazy-lock.json` versioning
- Key files: `init.lua` is the only runtime file at root

## Key File Locations

**Entry Points:**
- `init.lua`: Main entry point, loads all configuration
- `lua/config/lazy.lua`: Plugin system bootstrap

**Configuration:**
- `lua/config/keybindings.lua`: Global keymaps (window splits, saving, etc.)
- `lua/config/lazy.lua`: Plugin manager setup, leader key config

**Core Logic:**
- `lua/plugins/*.lua`: All plugin specifications

**Plugin Specs (by function):**

| Category | File | Purpose |
|----------|------|---------|
| Editor | `nvim-tree.lua` | File explorer |
| Editor | `telescope.lua` | Fuzzy finder |
| Editor | `lualine.lua` | Status line |
| LSP | `lsp-config.lua` | Language server config |
| Completion | `cmp.lua` | Autocompletion |
| Git | `gitsigns.lua` | Git signs and hunks |
| Syntax | `treesitter.lua` | Syntax highlighting |
| UI | `colorscheme.lua` | Color scheme |
| UI | `devicons.lua` | File icons |
| Utils | `plenary.lua` | Utility functions |

## Naming Conventions

**Files:**
- Plugin specs: `{plugin-name}.lua` (kebab-case, matches plugin repository name)
- Config modules: `{purpose}.lua` (kebab-case, describes function)
- Entry point: `init.lua` (Neovim convention)

**Directories:**
- `lua/`: StandardNeovim runtime path
- `config/`: Configuration modules
- `plugins/`: Plugin specifications

**Module Exports:**
- Plugin specs: Return table directly
- Config modules: Side-effect only (no return value needed)

## Where to Add New Code

**New Plugin:**
- Create: `lua/plugins/{plugin-name}.lua`
- Pattern:
```lua
return {
    "author/plugin-name",
    dependencies = {},  -- optional
    config = function()
        require("plugin-name").setup({})
    end,
}
```

**New Keybinding:**
- Global keymaps: `lua/config/keybindings.lua`
- Plugin-specific keymaps: Inside plugin's `config` function

**New LSP Server:**
- File: `lua/plugins/lsp-config.lua`
- Add: `vim.lsp.enable('server_name')` in config function

**New Colorscheme:**
- Replace: `lua/plugins/colorscheme.lua`
- Update: Plugin name and `vim.cmd([[colorscheme name]])`

## Special Directories

**`.planning/`:**
- Purpose: Planning documents for AI-assisted development
- Generated: Yes (by GSD tools)
- Committed: Can be committed to version control

**`.git/`:**
- Purpose: Version control
- Generated: Yes
- Committed: N/A

**`lazy-lock.json`:**
- Purpose: Pin plugin versions for reproducibility
- Generated: Yes (by lazy.nvim)
- Committed: Yes (recommended for shared configs)

---

*Structure analysis: 2026-03-26*