-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.undofile = true

vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

local undo_dir = vim.fn.stdpath("data") .. "/undodir"

if not vim.fn.isdirectory(undo_dir) then
  vim.fn.mkdir(undo_dir, "p", 0700)
end


local rocks_config = {
    rocks_path = vim.env.HOME .. "/.local/share/nvim/rocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
    vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    -- Remove the dylib and dll paths if you do not need macos or windows support
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
    vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
