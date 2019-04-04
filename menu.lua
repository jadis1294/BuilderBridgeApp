--menu_iniziale.lua
local composer = require( "composer" )
local widget = require( "widget" )
local os = require ("os")
local scene = composer.newScene()

function scene:setupSceneGroup(items)
	local scenegroup=self.view
	for i=1,#items,1 do
		scenegroup:insert(items[i])
	end
end

--creazione composer per "ambiente"
local function partita( event )
	composer.removeScene("menu")
	local difficolta=composer.gotoScene("difficolta",{ effect="crossFade", time=300 })
	return true
end

--funzione di chiusura
local function chiudi( event )
	os.exit()
end

--creazione composer per "opzioni"
local function crediti( event )
	composer.removeScene("menu")
	local crediti=composer.gotoScene("crediti",{ effect="crossFade", time=300 })
	return true
end

--creazione scena
function scene:create(event)
	local scenegroup=self.view

--animazione sfondo menu
	local sheet = graphics.newImageSheet( "manpro2.png", { width=200, height=200, numFrames=20} )
	local animazione = display.newSprite( sheet, { name="fall", start=18, count=1} )
	animazione.x = display.contentCenterX-200
	animazione:scale(0.4, 0.4)
	animazione:play() 
	self.animazione=animazione

	local function loopAnime()
			animazione.alpha=1.3
			animazione.y = display.contentHeight-353
			animazione.x = display.contentCenterX-(math.random(-100, 250))
			transition.to(animazione,{ time=1000, delay=300, alpha=0.7, x=x, y=animazione.y+(display.contentHeight-60), onComplete=loopAnime})
	end

	loopAnime()

--inserimento e posizionamento sfondo menu
	local sfondo=display.newImage("bridge.jpg",700,900) self.sfondo=sfondo
	sfondo.x = display.contentCenterX-50; 
	sfondo.y = display.contentCenterY-60
	sfondo:scale(0.7,0.7)


--inserimento e posizionamento sfondo menu
	local rock1=display.newImage("grafichette/rockmenu.png") self.rock1=rock1
	rock1.x = display.contentCenterX-230 
	rock1.y = display.contentCenterY+118
	rock1:scale(0.28,0.28)

	local palme=display.newImage("grafichette/palmemenu.png") self.palme=palme
	palme.x = display.contentCenterX-230 
	palme.y = display.contentCenterY+10
	palme:scale(-0.2,0.2)

	local rocce=display.newImage("grafichette/rocktowermenu.png") self.rocce=rocce
	rocce.x = display.contentCenterX+230 
	rocce.y = display.contentCenterY+100
	rocce:scale(0.3,0.3)

--inserimento e posizionamento titolo
	local titolo=display.newImage("titolo2.png") self.titolo=titolo
	
	titolo.x = display.contentCenterX+120; 
	titolo.y = display.contentCenterY-80
  
--creazione bottoni
	local start = widget.newButton(
		{
		id="start",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        --overFile = "trasparente.png",
        x = display.contentCenterX+120, 
		y = display.contentCenterY+30,
		label= "New Game",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
	
	local opzioni = widget.newButton(
		{		
		id= "opzioni",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX+120, 
		y = display.contentHeight/1.5+25,
		label= "Credits",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
	
	local exit = widget.newButton(
		{		
		id= "exit",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX+120,
		y = display.contentHeight/1.5+75,
		label= "Exit",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)

--creazione table per parametri
	local items ={sfondo,animazione,palme,rock1,rocce,titolo,
				opzioni,start,exit}
	self:setupSceneGroup(items)

--ascoltatori dei bottoni
	start:addEventListener("tap", partita)
	opzioni:addEventListener("tap",crediti)
	exit:addEventListener("tap",chiudi)
end

function scene:destroy(event)
	display.remove(self.sfondo) self.sfondo=nil
	display.remove(self.palme) self.palme=nil
	display.remove(self.rock1) self.rock1=nil
	display.remove(self.rocce) self.rocce=nil
	display.remove(self.titolo) self.titolo=nil
	display.remove(self.animazione) self.animazione=nil
	display.remove(self.opzioni) self.opzioni=nil
	display.remove(self.start) self.start=nil
	display.remove(self.exit) self.exit=nil	
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)
return scene