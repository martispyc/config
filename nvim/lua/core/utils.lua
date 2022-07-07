local M = {}

local cmd = vim.cmd
M.test = function(arg)
    return arg
end
M.label_plugins = function(plugins)
   local plugins_labeled = {}
   for _, plugin in ipairs(plugins) do
      plugins_labeled[plugin[1]] = plugin
   end
   return plugins_labeled
end
return M
