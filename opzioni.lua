
--opzioni.LUA--
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
	composer.removeScene("opzioni")
	local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
	return true
end

local function crediti( event )
	composer.removeScene("opzioni")
	local menu = composer.gotoScene("crediti",{ effect="crossFade", time=300 })
	return true
end


--creazione scena
function scene:create(event)
	local scenegroup=self.view

--animazione sfondo menu
	local sheet = graphics.newImageSheet( "manpro2.png", { width=200, height=200, numFrames=20} )
	local animazione = display.newSprite( sheet, { name="fall", start=13, count=7, time=1200,loopCount=0,loopDirection="forward" } )
	animazione.x = display.contentCenterX-200
	animazione.y = display.contentHeight-100
	animazione:scale(0.4, 0.4)
	animazione:play() 
	self.animazione=animazione

	local function loopAnime()
			animazione.y = display.contentHeight-355
			transition.to(animazione,{ time=1200, delay=1000, alpha=0.9, x=x, y=animazione.y+(display.contentHeight-45), onComplete=loopAnime})
	end

	loopAnime()
--inserimento e posizionamento sfondo menu
	local sfondo=display.newImage("bridge.jpg",700,900) self.sfondo=sfondo
	sfondo.x = display.contentCenterX-100; 
	sfondo.y = display.contentCenterY-50
	sfondo:scale(0.7,0.7)

--inserimento e posizionamento titolo
	local titolo=display.newImage("titolo.png") self.titolo=titolo
	titolo:scale(0.9,0.7)
	titolo.x = display.contentCenterX+130; 
	titolo.y = display.contentCenterY-80

--inserimento testi dei bottoni
	local testoSound= display.newImage("bottonesound.png") self.testoSound=testoSound
	testoSound.x=display.contentCenterX+130
	testoSound.y=display.contentCenterY+30
	testoSound:scale(0.3,0.4)

	local testoCredits= display.newImage("testoCredits.png") self.testoCredits=testoCredits
	testoCredits.x=display.contentCenterX+130
	testoCredits.y=display.contentCenterY+79
	testoCredits:scale(0.3,0.4)

	local testoIndietro= display.newImage("buttindietro.png") self.testoIndietro=testoIndietro
	testoIndietro.x=display.contentCenterX+130
	testoIndietro.y=display.contentCenterY+128
	testoIndietro:scale(0.4,0.36)


--creazione bottoni
	local sound = widget.newButton(
		{
		id="start",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX+130; 
		y = display.contentCenterY+30,
		}
	)

	local bottonecrediti = widget.newButton(
		{		
		id= "opzioni",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX+130; 
		y = display.contentHeight/1.5+25
		}
	)

	local indietro = widget.newButton(
		{		
		id= "exit",
		width = 210,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX+130; 
		y = display.contentHeight/1.5+75
		}
	)

--creazione table per parametri
	local items ={sfondo,titolo,indietro,bottonecrediti,sound,animazione,testoSound,testoIndietro,testoCredits}
	self:setupSceneGroup(items)

	--ascoltatori dei bottoni
	--sound:addEventListener("tap", partita)
	bottonecrediti:addEventListener("tap",crediti)
	indietro:addEventListener("tap",menu)
end

function scene:destroy(event)
	display.remove(self.indietro) self.indietro=nil
	display.remove(self.titolo) self.titolo=nil
	display.remove(self.sfondo) self.sfondo=nil
    display.remove(self.bottoneindietro) self.bottoneindietro=nil
    display.remove(self.testoSound) self.testoSound=nil
   	display.remove(self.testoCredits) self.testoCredits=nil
   	display.remove(self.testoIndietro) self.testoIndietro=nil
   	display.remove(self.animazione) self.animazione=nil
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)

return scene