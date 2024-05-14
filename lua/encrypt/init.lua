local setupBuffer = require("encrypt.setup-buffer")
local encrypt = require("encrypt.encrypt")
local decrypt = require("encrypt.decrypt")
local helpers = require("encrypt.helpers")

local function setup()
  vim.api.nvim_create_user_command("X", function()
    setupBuffer()
    encrypt()
  end, {})

  vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    callback = function()
      local first_line = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
      if first_line == helpers.ENCRYPTED_PREFIX then
        setupBuffer()
        decrypt()
      end
    end,
  })
end

return { setup = setup }
