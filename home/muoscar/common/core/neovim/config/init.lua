local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Must map leader key before must set colorscheme after lazy setup!
require('muoscar.keymaps')
require('muoscar.sets')
require('lazy').setup('muoscar.plugins')

-- Colorscheme

vim.api.nvim_create_autocmd('ColorScheme', {
  desc = "Apply customization of the colorscheme for LaTeX files",
  pattern = '*',
  group = vim.api.nvim_create_augroup('init_vimtex', {}),
  callback = function()
    -- Or have them in some separate file that you load with something like
        require('muoscar.gruber-darker-vimtex-highlight-groups').set_highlights()
  end,
})
vim.cmd.colorscheme('gruber-darker')

local should_profile = os.getenv("NVIM_PROFILE")
if should_profile then
  require("profile").instrument_autocmds()
  if should_profile:lower():match("^start") then
    require("profile").start("*")
  else
    require("profile").instrument("*")
  end
end

local function toggle_profile()
  local prof = require("profile")
  if prof.is_recording() then
    prof.stop()
    vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
      if filename then
        prof.export(filename)
        vim.notify(string.format("Wrote %s", filename))
      end
    end)
  else
    prof.start("*")
  end
end
vim.keymap.set("", "<f1>", toggle_profile)
