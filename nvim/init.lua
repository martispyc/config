local present_impatient, impatient = pcall(require, "impatient")
if present_impatient then
   impatient.enable_profile()
end

-- local present_notify, notify = pcall(require, "notify")
-- if present_notify then
--     vim.notify = require("notify")
-- end
--
-- require("config")
--
local modules = {
   "core.options",
   "core.autocommands",
   "core.mappings",
   "core.commands",
   "core.colorscheme",

   "plugins.plugins",
   -- "plugins.lsp",
}

for _, module in ipairs(modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
   end
end


