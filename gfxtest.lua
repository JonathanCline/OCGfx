local graphics = require("graphics")
local component = require("component")

graphics:set_gpu(component.list("gpu")())
graphics:clear()
graphics:rect(4, 4, 8, 8)

local event = require("event")
event.pull("touch")
