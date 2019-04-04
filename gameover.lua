--gameover.lua
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
local function retry( event )
	composer.removeScene("gameover")
	local menu = composer.gotoScene("ambiente",{ effect="crossFade", time=300 , params={level = scene.difficolta}})
	return true
end

--funzione di chiusura
local function chiudi( event )
	composer.removeScene("gameover")
	local menu = composer.gotoScene("menu", {effect="crossFade", time = 300})
end

--creazione scena
function scene:create(event)
  --Musica
  audio.setVolume( 0.3, { channel=3 } ) -- set the volume on channel 3
  local musicgameover = audio.loadSound( "gameover.wav")
  local musicChannelOver=audio.play(musicgameover,{
    channel = 3,
    loops = -1,
	})
   self.musicgameover=musicgameover
   self.musicChannelOver=musicChannelOver
	local scenegroup=self.view
self.difficolta = event.params.level

--animazione sfondo menu
	
local sheetOptions =
        {
        width = 300,
        height = 177,
        numFrames = 8
        }
local sheet_gameover = graphics.newImageSheet( "grafichette/die2.png", sheetOptions )

local sequences_gameover = {
    {
        name = "normalRun",
        start = 1,
        count = 6,
        time = 1200,
        loopCount = 0,
    } }
local gameover = display.newSprite( sheet_gameover, sequences_gameover ) self.gameover=gameover
gameover.x = display.contentCenterX
gameover.y = display.contentCenterX*6/10
gameover:scale(0.6,0.6)
gameover:play()
gameover.alpha=0.7


	--inserimento e posizionamento immagine di testo del pulsante
	local testoGameOver= display.newImage("gameover.png") self.testoGameOver=testoGameOver
	testoGameOver.x=display.contentCenterX
	testoGameOver.y=display.contentCenterY-90
	testoGameOver:scale(0.8,0.8)


--creazione bottone indietro
	local restart = widget.newButton(
		{
		width = 230,
		height = 40,
		id = "restart",
	    defaultFile = "bottone.png",
    	overFile = "trasparente.png",
		x = display.contentCenterX,
		y = display.contentCenterY+70,
    	label= "Restart",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
	restart:addEventListener("tap", retry)


	local exit = widget.newButton(
		{		
		id= "exit",
		width = 180,
        height = 45,
        defaultFile = "bottone.png",
        overFile = "trasparente.png",
        x = display.contentCenterX, 
		y = display.contentHeight/1.5+75,
		label= "Go Back",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
	exit:addEventListener("tap",chiudi)
--creazione table per parametri
	local items ={restart,testoGameOver,exit,animazione}
	self:setupSceneGroup(items)

end

function scene:destroy(event)
  --elima musica

  audio.stop( self.musicChannelOver )
  self.musicChannelOver = nil
  audio.dispose( self.musicgameover)
  self.musicgameover = nil  --prevents the handle from being used again
	display.remove(self.restart) self.restart=nil
	display.remove(self.animazione) self.animazione=nil
    display.remove(self.exit) self.exit=nil
    display.remove(self.testoGameOver) self.testoGameOver=nil

    display.remove(self.gameover) self.gameover=nil
end

scene:addEventListener("create",scene)
scene:addEventListener("destroy",scene)

return scene