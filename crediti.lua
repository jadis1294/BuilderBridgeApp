--CREDITI.LUA--
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
	composer.removeScene("crediti")
	local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
	return true
end

--creazione scena
function scene:create(event)
	local scenegroup=self.view

	local sfondo=display.newImage("sfondo_crediti.jpg",700,900) self.sfondo=sfondo
	sfondo.x = display.contentCenterX; 
	sfondo.y = display.contentCenterY
	sfondo:scale(0.6,0.6)

--inserimento e posizionamento titolo
	local titolo=display.newImage("titolo1.png") self.titolo=titolo
	local baseline = 10
	titolo:scale(0.8,0.8)
	titolo.x = display.contentCenterX-130; 
	titolo.y = display.contentCenterY-80

--creazione bottone indietro
	local indietro = widget.newButton(
		{
		width = 200,
		height = 40,
		id = "indietro",
	    defaultFile = "bottone.png",
    	overFile = "trasparente.png",
		x = display.contentCenterX-130,
		y = display.contentCenterY+130,
		label= "Go Back",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
	indietro:addEventListener("tap", menu)


local testo = display.newText("Powered by",display.contentCenterX/100*20,display.contentCenterY+10,"towerruins.ttf", nil) self.testo=testo
local lorenzo = display.newText("Lorenzo 'Tocco' Tocco",display.contentCenterX/100*40,display.contentCenterY+30,"towerruins.ttf", nil) self.lorenzo=lorenzo
local luca = display.newText("Luca 'Jadis' De Silvestris",display.contentCenterX/100*46,display.contentCenterY+50,"towerruins.ttf", nil) self.luca=luca
local bob = display.newText("Roberto 'Bob' Boschi",display.contentCenterX/100*38.5,display.contentCenterY+70,"towerruins.ttf", nil) self.bob=bob
local marta = display.newText("Marta 'Koalino' Curci",display.contentCenterX/100*40.5,display.contentCenterY+90,"towerruins.ttf", nil) self.marta=marta
--creazione table 
	local items ={sfondo,titolo,indietro,lorenzo,luca,bob,marta,testo}
	self:setupSceneGroup(items)
end

function scene:destroy(event)
	display.remove(self.indietro) self.indietro=nil
	display.remove(self.titolo) self.titolo=nil
	display.remove(self.sfondo) self.sfondo=nil
    display.remove(self.lorenzo) self.lorenzo=nil
    display.remove(self.luca) self.luca=nil
    display.remove(self.bob) self.bob=nil
    display.remove(self.marta) self.marta=nil
    display.remove(self.testo) self.testo=nil
    display.remove(self.computer) self.computer=nil
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)

return scene