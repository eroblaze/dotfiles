local function safe_dofile(path, fallback)
  local file = io.open(path, "r")
  if file then
    file:close()
    return dofile(path)
  else
    return fallback
  end
end

local home = os.getenv("HOME")
local theme_path = home .. "/.config/omarchy/current/theme/neovim.lua"

local fallback_theme = {
  "Shatur/neovim-ayu",
  name = "Ayu",
  lazy = false,
  config = function()
    vim.cmd("colorscheme ayu")
  end,
}

-- Load config or fallback to your theme
local config = safe_dofile(theme_path, fallback_theme)

return config
