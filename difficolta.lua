--difficolta.lua
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

function scene:setupSceneGroup(items)
	local scenegroup=self.view
	for i=1,#items,1 do
		scenegroup:insert(items[i])
	end
end

--creazione composer per "menu", "ambiente facile" e "ambiente difficile"
local function menu( event )
	composer.removeScene("difficolta")
	local menu=composer.gotoScene("menu",{ effect="crossFade", time=300})
	return true
end

local function partitaDifficile( event )
	composer.removeScene("difficolta")
	local ambiente=composer.gotoScene("ambiente",{ effect="crossFade", time=300, params = {level="difficile"} })
	return true
end

local function partitaFacile( event )
	composer.removeScene("difficolta")
	local ambiente=composer.gotoScene("ambiente",{ effect="crossFade", time=300, params = {level="facile"} })
	return true
end

--creazione scena
function scene:create(event)
	local scenegroup=self.view

--inserimento scritta di selezione
	local optionset = 
	{
    text = "Select you difficult:",     
    x = 135,
    y = 150,
    width = -128, 
    font = "towerruins.ttf",
    fontSize = 19,
	}
	local sel = display.newText( optionset ) self.sel=sel
	sel:setFillColor( 0, 0, 0 )

--inserimento e posizionamento sfondo menu
	local sfondo=display.newImage("bridge.jpg",700,900) self.sfondo=sfondo
	sfondo.x = display.contentCenterX+70; 
	sfondo.y = display.contentCenterY-50
	sfondo:scale(0.7,0.7)
	sfondo:toBack()
	local palme=display.newImage("grafichette/palmemenu.png") self.palme=palme
	palme.x = display.contentCenterX-230 
	palme.y = display.contentCenterY+10
	palme:scale(-0.2,0.2)

--inserimento e posizionamento sfondo menu
	local rock1=display.newImage("grafichette/rockmenu.png") self.rock1=rock1
	rock1.x = display.contentCenterX-230 
	rock1.y = display.contentCenterY+118
	rock1:scale(0.28,0.28)
	rock1.alpha=0.8

--inserimento e posizionamento titolo
	local titolo=display.newImage("titolo2.png") self.titolo=titolo
	local baseline = 10
	titolo:scale(0.9,0.9)
	titolo.x = display.contentCenterX-100; 
	titolo.y = display.contentCenterY-90

--creazione bottoni
	local indietro = widget.newButton(
		{		
		id= "indietro",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
		x = display.contentCenterX-100, 
		y = display.contentHeight/1.5+75,
		label= "Go Back",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)

	local facile = widget.newButton(
		{		
		id= "facile",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
		x = display.contentCenterX-100, 
		y = display.contentHeight/1.5-20,
		label= "Easy",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)

	local difficile = widget.newButton(
		{		
		id= "difficile",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
		x = display.contentCenterX-100, 
		y = display.contentHeight/1.5+25,
		label= "Hard",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)

--creazione table per parametri
	local items ={sfondo,titolo,indietro,facile,difficile,palme,rock1,sel}
	self:setupSceneGroup(items)

--ascoltatori dei bottoni
	indietro:addEventListener("tap",menu)
	facile:addEventListener("tap",partitaFacile)
	difficile:addEventListener("tap",partitaDifficile)
end

--scena:destroy
function scene:destroy(event)
		display.remove(self.titolo) self.titolo=nil
		display.remove(self.sfondo) self.sfondo=nil
		display.remove(self.indietro) self.indietro=nil
		display.remove(self.facile) self.facile=nil
		display.remove(self.difficile) self.difficile=nil
		display.remove(self.rock1) self.rock1=nil
		display.remove(self.palme) self.palme=nil
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)
return scene