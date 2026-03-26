# Testing Patterns

**Analysis Date:** 2026-03-26

## Project Type

**Nature:** Neovim configuration (dotfiles)

**Test Framework:** None - This is a configuration project, not a plugin orapplication

**Testing Approach:** Configuration verification through runtime testing

## Test Framework

**Runner:**
- Not applicable - No automated tests
- Configuration tested by running Neovim

**Assertion Library:**
- Not applicable

**Run Commands:**
```bash
nvim  # Start Neovim to verify configuration loads
nvim --headless +q  # Quick smoke test without UI
```

## Test File Organization

**Location:**
- None - No test files exist
- No `tests/`, `spec/`, or `test/` directories

**Naming:**
- Not applicable

**Structure:**
- Not applicable - No tests

## What Would Require Testing

If plugins were developed within this configuration:

**Plugin Specs:**
- Located in `lua/plugins/` directory
- Would use `plenary.nvim` for testing (common Neovim testing framework)
- Files would follow `*_spec.lua` naming convention

**Configuration Modules:**
- Located in `lua/config/` directory
- Would test keymaps are registered correctly
- Would test lazy.nvim setup completes without errors

## Verification Methods

**Manual Testing:**
```bash
# Verify configuration loads
nvim

# Check plugin installation
nvim +Lazy

# Verify specific plugin
nvim +NvimTree
```

**Health Checks:**
```vim
:checkhealth
:checkhealth lsp
:checkhealth treesitter
```

**Common Validation Points:**
1. Leader key works (`<leader>` maps to `,`)
2. Plugins load without errors (`:Lazy`)
3. LSP attaches to buffers (`:LspInfo`)
4. Treesitter highlighting works (`:TSInstallInfo`)
5. Colorscheme loads correctly (`:colorscheme`)

## Current Testing Gaps

**No Automated Tests:**
- Files: Entire codebase
- Risk: Configuration changes may break silently
- Priority: Low - configuration projects typically rely on manual testing

**Bootstrap Verification:**
- The `lua/config/lazy.lua` bootstrap has minimal error handling
- No verification that plugins are properly cloned
- Check health with `:checkhealth lazy`

## Manual Test Checklist

For configuration changes:

**After modifying `lua/config/lazy.lua`:**
1. Start Neovim: `nvim`
2. Run `:Lazy` to check plugin status
3. Run `:checkhealth` for overall health

**After modifying `lua/config/keybindings.lua`:**
1. Test leader key: Press `,` then check commands
2. Test window splits: `<leader>sv`, `<leader>sh`
3. Test navigation: `<C-h/j/k/l>`

**After modifying `lua/plugins/*.lua`:**
1. Run `:Lazy sync` to apply changes
2. Run `:checkhealth` for plugin-specific checks
3. Test plugin-specific commands

**After adding new plugin:**
1. Add file to `lua/plugins/`
2. Run `nvim` - lazy.nvim will auto-install
3. Verify with `:Lazy` that plugin shows as installed

## If Tests Were Added

**Framework:**
- Would use `plenary.nvim` test harness (already a dependency)
- Would use `nvim-test` or similar for structured testing

**Test Structure:**
```
lua/
├── config/
│   ├── lazy_spec.lua    # Tests for lazy setup
│   └── keybindings_spec.lua
├── plugins/
│   └── [no tests - plugin specs are declarative]
└── tests/
    └── minimal_init.lua  # Minimal config for testing
```

**Test Files:**
```lua
-- Example: lua/config/lazy_spec.lua
describe("lazy.nvim setup", function()
    it("sets leader key correctly", function()
        assert.are.equal(",", vim.g.mapleader)
    end)
    
    it("sets local leader key correctly", function()
        assert.are.equal("\\", vim.g.maplocalleader)
    end)
end)
```

**Run Commands (if tests existed):**
```bash
nvim --headless -c "PlenaryBustedDirectory lua/tests"
```

## Mocking

**Not applicable:**
- No automated tests
- No mocking framework in use

**If tests were added:**
- Would mock `vim.fn.system()` for bootstrap tests
- Would mock `vim.keymap.set()` to verify keybindings
- Would use `vim.schedule_wrap()` for async test handling

## Coverage

**Requirements:** None enforced

**Current Coverage:** Not applicable - configuration project

## Plugin Development Testing

For developing plugins within this config:

**Local Development:**
```lua
-- Add to lazy.nvim spec for local plugin development
return {
    name = "my-plugin",
    dev = true,  -- Use local version
    dir = "~/projects/my-plugin",
}
```

**Testing File:**
```lua
-- In plugin repository, not config
describe("my-plugin", function()
    before_each(function()
        -- Setup plugin state
    end)
    
    after_each(function()
        -- Cleanup
    end)
end)
```

## Common Testing Patterns (Reference)

For future test development:

**Async Testing:**
```lua
-- Not currently used
it("handles async operations", function()
    local done = false
    some_async_function(function()
        done = true
    end)
    vim.wait(1000, function() return done end)
    assert.is_true(done)
end)
```

**Buffer Testing:**
```lua
-- Not currently used
it("operates on buffer", function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {"test line"})
    assert.are.same({"test line"}, vim.api.nvim_buf_get_lines(bufnr, 0, -1, false))
end)
```

---

*Testing analysis: 2026-03-26*