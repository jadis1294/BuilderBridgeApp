

--[[SPRITE PTERODATTILO 
--------------------------------------
local sheetOptions =
		{
    	width = 80,
    	height = 68,
    	numFrames = 12
		}
local sheet_dinosaur = graphics.newImageSheet( "pterodattilo.png", sheetOptions )

local sequences_dinosaur = {
    {
        name = "normalRun",
        start = 1,
        count = 10,
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    } }
local dinosaur = display.newSprite( sheet_dinosaur, sequences_dinosaur )
dinosaur.x = display.contentCenterX
dinosaur.y = display.contentCenterX
dinosaur:play()

-------------------------------------------]]--