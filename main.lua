local composer = require("composer")
local menu=require("menu")
function systemEvents(event)
local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
return true
    end

Runtime:addEventListener("system", systemEvents)