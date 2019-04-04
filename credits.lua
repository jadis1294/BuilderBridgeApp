--CREDITS.LUA--
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

function scene:setupSceneGroup(items)
	local scenegroup=self.view
	for i=1,#items,1 do
		scenegroup:insert(items[i])
	end
end

--creazione composer per indietro
local function menu( event )
	composer.removeScene("credits")
	local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
	return true
end

--creazione scena
function scene:create(event)
	local scenegroup=self.view
	local bottoneindietro=display.newImage("buttindietro.png") self.bottoneindietro=bottoneindietro
	bottoneindietro.x=display.contentCenterX;
	bottoneindietro.y=display.contentCenterY+130
	bottoneindietro:scale(0.45,0.45)
	local sfondo=display.newImage("bridge.jpg",700,900) self.sfondo=sfondo
	sfondo.x = display.contentCenterX-100; 
	sfondo.y = display.contentCenterY-50
	sfondo:scale(0.7,0.7)

--inserimento e posizionamento titolo
	local titolo=display.newImage("titolo.png") self.titolo=titolo
	local baseline = 10
	titolo:scale(0.8,0.7)
	titolo.x = display.contentCenterX+130; 
	titolo.y = display.contentCenterY-80

--creazione bottone indietro
	local indietro = widget.newButton(
		{
		width = 200,
		height = 40,
		id = "indietro",
	    defaultFile = "bottone.png",
    	overFile = "trasparente.png",
		x = display.contentCenterX,
		y = display.contentCenterY+130,
    	cornerRadius = 1,
		}
	)
	indietro:addEventListener("tap", menu)

--creazione table per parametri
	local items ={sfondo,titolo,indietro,bottoneindietro}
	self:setupSceneGroup(items)
end

function scene:destroy(event)
	display.remove(self.indietro) self.indietro=nil
	display.remove(self.titolo) self.titolo=nil
	display.remove(self.sfondo) self.sfondo=nil
    display.remove(self.bottoneindietro) self.bottoneindietro=nil
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)

return scene