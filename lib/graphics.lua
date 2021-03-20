
local graphics = {}
local component = component or require("component")

-- Sets the graphics libraries gpu
graphics.set_gpu = function(self, gpu)
    
    local _gpuAddr = nil
    self.gpu = nil

    if type(gpu) == "string" then
        _gpuAddr = gpu
    elseif type(gpu) == "table" then
        _gpuAddr = gpu.address
    else
        _gpuAddr = component.list("gpu")()
    end

    if _gpuAddr then
        self.gpu = component.proxy(_gpuAddr)
    end

    return self.gpu

end

-- Draws a rectangle on the screen
graphics.rect = function(self, x, y, width, height, color)
    local _gpu = self.gpu
    assert(_gpu)

    local _oldForeground = _gpu.getForeground()

    local _col = color or 0xFFFFFF
    _gpu.setForeground(_col)
    _gpu.fill(x, y, width, height, " ")
    _gpu.setForeground(_oldForeground)
end

-- Clears screen
graphics.clear = function(self, color)
    local _w, _h = self.gpu.getResolution()
    local _col = color or 0x000000
    self:rect(1, 1, _w, _h, _col)
end

return graphics
