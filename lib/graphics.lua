
local graphics =
{
    colorswap =
    {
        foreground = 0xFFFFFF,
        background = 0x000000
    }
}

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

-- Swaps foreground and background colors into reserve
graphics.swap = function(self)
    local fore = self.colorswap.foreground
    self.colorswap.foreground = self.gpu.getForeground()
    self.gpu.setForeground(fore)

    local bgcol = self.colorswap.background
    self.colorswap.background = self.gpu.getBackground()
    self.gpu.setBackground(bgcol)
end


-- Sets foreground and background colors
graphics.setcol = function(self, fg, bg)
    self.colorswap.foreground = fg
    self.colorswap.background = bg
    self:swap()
end


-- Draws a rectangle on the screen
graphics.rect = function(self, x, y, width, height, color)
    local _gpu = self.gpu
    assert(_gpu)

    local _color = color or 0xFFFFFF
    self:setcol(_color, _color)
    _gpu.fill(x, y, width, height, " ")
    self:swap()
end

-- Clears screen
graphics.clear = function(self)
    local _w, _h = self.gpu.getResolution()
    self:rect(1, 1, _w, _h, 0x000000)
end

return graphics
