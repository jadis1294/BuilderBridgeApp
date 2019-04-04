--AMBIENTE.LUA
local ponte = require("ponte")
local giocatore = require("giocatore")
local worldGenerator = require("worldGenerator")
local timer = require("timer")
local composer = require("composer")
local physics = require("physics")
local MusicGenerator = require("MusicGenerator")
local HeaderScene = require("HeaderScene")
local BackgroundCarousel = require("BackgroundCarousel")
local widget = require("widget")
local istruzioni=require("istruzioni")
local scene = composer.newScene()
physics.start()
physics.setGravity(0,9.8)

--creazione composer per tasto indietro
local function menu( event )
	composer.removeScene("ambiente")
	local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
	return true
end

--creazioe composer per gameover 
local function gameover()
  local menu = composer.gotoScene("gameover",{ effect="crossFade", time=2000, params={level = scene.difficolta}})
  --local menu = composer.gotoScene("menu",{ effect="crossFade", time=300 })
	transition.dissolve()
	if(scene.newFine ~= nil) then
	display.remove(scene.newFine.item) scene.newFine.item = nil
display.remove(scene.newFine) scene.newFine = nil
end
 composer.removeScene("ambiente")
	return true
end

--funzione che attiva l'oggetto mazza
local function tapClava(event)
	if(scene.headerScene.clava==0)then 
		return true
	end
	local renderPonte = scene.ponte
	local rendergiocatore = scene.giocatore.renderplayer
    local vx,vy = rendergiocatore:getLinearVelocity()
    if(vx~=0)then 
      return 
      end          		
      renderPonte:destroyByItem(scene)
    return true
end

--settaggi per i movimenti dell'ambiente
function scene:moveCamera()
	local renderplayer = self.giocatore.renderplayer
	local spazioGiocatore = (renderplayer.x - self.inizio.x)
	local bgCarousel = self.backgroundCarousel
	scene.newFine = worldGenerator:getPlatform(spazioGiocatore)
	bgCarousel.gioco:insert(scene.newFine)
	transition.to(self.newFine, {time=1500, delay = 500, x = self.newFine.x - spazioGiocatore})
    transition.to(self.newFine.item, {time=1500, delay = 500, x = self.newFine.x -     spazioGiocatore})
	transition.to( self.fine, { time=1500, delay=500, x=(self.inizio.x),y=(self.inizio.y)})
	transition.to( renderplayer, {time = 1500, delay= 500, x = self.inizio.x})
	transition.to( self.inizio, {time = 1500, delay=500, x = self.inizio.x - spazioGiocatore, onComplete = manageCarousel })
	transition.to( self.ponte.dino, {time=500, y = self.ponte.dino.y + self.ponte.dino.height, x = self.inizio.x})
	bgCarousel:moveBgObjects(spazioGiocatore)
	scene.timerID = timer.performWithDelay(2000, 
		function() scene.ponte = ponte:new(scene.era,scene.inizio)
					scene.view:insert(scene.ponte.render.testa)
					scene.view:insert(scene.ponte.render.collo)
					scene.view:insert(scene.ponte.render.testaponte)
          if(scene.fine.item~=nil)then
          if(scene.istruzioni.isfirstitem==true) then
            scene.istruzioni.Instructcounter=5
            scene.istruzioni:creaSfondo()
            scene.istruzioni.skipbutton:toFront()
            scene.istruzioni.skipbutton.alpha=1
            scene.istruzioni.istructObj01.alpha=1
            scene.istruzioni.istritem=true
            scene.istruzioni.isfirstitem=false
          end
          end
	 end)
end

function manageCarousel()
	local bgCarousel = scene.backgroundCarousel
bgCarousel:manageCarousel()
bgCarousel:showBgObjectsRuntime()
bgCarousel:cleanObjectsOutScene()

end

--Ascoltatore per collisioni giocatore - destinazione, ponte-destinazione
function onLocalCollision(self,event)
	local ponte = scene.ponte
	local inizio = event.target.param
	local header = scene.headerScene
  if(event.other.nome~="ponte")then
     if(event.other.nome=="testaponte") then 
	     if(ponte.render.testaponte.x<=scene.fine.x and ponte.render.testaponte.x>scene.fine.x-(scene.fine.contentWidth*0.4))then
    	scene.okText.alpha=1
    timer.performWithDelay(700, function() scene.okText.alpha=0 end)
     header.perfectcounter=1
    end
  end
  end

	if(event.other.name == "giocatore") then
		local renderplayer = scene.giocatore.renderplayer
		scene.floor:removeEventListener("collision", wallCollision)
		timer.performWithDelay(100, function() return giocatore:stop() end)
		physics.pause()
		timer.performWithDelay(1, function() ponte:destroyRender() end)

    	if(scene.fine.item~=nil)then
	    	display.remove(scene.fine.item) scene.fine.item=nil
	    	header:updateScoreItem()
	    scene.music:fireItemSound(2)
    	end
      header:Xscore()
    	scene:moveCamera()
		header:updateScore()
		return 
	end 
	timer.performWithDelay(50, function() return giocatore:move() end)
end 

--funzione per il "tap" della partita
function scene:tap(event)
  print(scene.istruzioni.sfondoistruct)
  if(scene.istruzioni.sfondoistruct~=nil)then
   scene.istruzioni:InstructionOn()
  else
    if(scene.istruzioni.sfondoistruct2~=nil)then
     scene.istruzioni:InstructionObjOn()
   else  
	local header = self.headerScene
  header.perfectcounter=false
	local renderPonte = self.ponte.render
	if(self.tapFlag == "wait") then
		return
	end
	if(self.tapFlag == true) then
		if(renderPonte.testa==nil) then
			return
		end
		renderPonte.testa.isVisible = false
 		if(renderPonte.testaponte) then
   			renderPonte.testaponte.isVisible=true
   		end
		ponte:creaPonte(event)
		self.tapFlag = false
		else
		self.ponte.dino:toFront()
		ponte:terminaPonte(event, self)
		self.tapFlag = "wait"
	end
end
end
end

--Ascoltatore per collsioni ponte - bordi dello schermo, giocatore - bordi dello schermo
function wallCollision(self,event)
	local renderPonte = scene.ponte.render
	local header = scene.headerScene
   if(event.other.nome~="ponte")then
  if(event.other.nome == "testaponte") then 
    if(renderPonte.testaponte.x<=scene.fine.x-(scene.fine.contentWidth*0.4) and renderPonte.testaponte.x>=scene.fine.x-(scene.fine.contentWidth*0.7))then
    scene.perfectText.alpha=1
    timer.performWithDelay(700, function() scene.perfectText.alpha=0 end)
    header.perfectcounter=true
  end
end
end
	if(event.target.isSensor ~= true) then
		if(event.other.nome == "ponte" or event.other.nome == "testaponte") then
      timer.performWithDelay(2000, function() end)
			wall:removeEventListener("collision", wallCollision)
			floor:removeEventListener("collision",wallCollision)
			timer.performWithDelay(100, function() return giocatore:move() end)
		else
			if(scene.fine ~= nil) then
          scene.headerScene:Xscore()
			scene.fine.collision = nil
			scene.fine:removeEventListener("collision", onLocalCollision)
     
		end
			physics.setGravity(0,0)
			timer.performWithDelay(20, function() giocatore:fall() end)	 
			timer.performWithDelay(1500,function() gameover() end)	 
		end
		if(event.phase == "ended") then
			physics.start()
		end
	end
end

function scene:enterFrame(event)
	local rendergiocatore = self.giocatore.renderplayer
	local bgCarousel = self.backgroundCarousel
	if(rendergiocatore ~= nil) then
	local vx, vy = rendergiocatore:getLinearVelocity()

	if(vx < 50 and vx >1) then
		self.giocatore:move()
	end
	end
	if(rendergiocatore.rotation ~= 0) then
		rendergiocatore.rotation = 0
	end
	if(self.inizio ~= nil) then
		if(self.inizio.x < -self.inizio.width/2) then
			display.remove(self.inizio)
			self.inizio = self.fine
			self.inizio.collision = nil
			self.fine = nil
		end
	end
	if(self.fine == nil) then
		local sceneGroup = self.view
		physics.start()
		self.fine = self.newFine
		local  nwsx,nwdx = self.fine.width*1/3, self.fine.width/2
		local hsu, hgiu = self.fine.height/2, self.fine.height*4/10
		physics.addBody(self.fine,"static", {bounce=0, friction = 12, shape={-nwsx,-hgiu,-nwsx,-hsu,nwdx,-hsu,nwdx,-hgiu}})
		sceneGroup:insert(self.fine)
		if(self.fine.item ~= nil) then
		sceneGroup:insert(self.fine.item)
	end
		if(self.floor.isSensor) then
			physics.setGravity(0,9.8)
			self.floor.isSensor = false
		end
		local x = self.ponte.dino.x
		local y = self.ponte.dino.y
		display.remove(self.ponte.dino)
		self.ponte.dino = display.newImage("corposano.png")
		self.ponte.dino.x = x
		self.ponte.dino.y = y
		self.ponte.dino:scale(0.3,0.3)
		transition.to(self.ponte.dino, {time = 500, y = self.ponte.dino.y - self.ponte.dino.height})

		self:setListeners()
	end	
end	
	
function scene:setListeners()
	local floor = self.floor
	local wall = self.wall
	local fine = self.fine
	local background = self.background
	local header = self.headerScene
	floor.collision = wallCollision
	floor:addEventListener("collision")
	wall.collision = wallCollision
	wall:addEventListener("collision")
	self.tapFlag = true
	fine.param = self.inizio
	fine.collision = onLocalCollision
	fine:addEventListener("collision")
	header.clavabutton:addEventListener( "tap", tapClava )
	header.indietro:addEventListener("tap", menu)
end

function skip()
  scene.istruzioni:skip()
  return true
  end
function scene:create(event)
	--physics.setDrawMode("hybrid")
  	local era =1
	local sceneGroup = self.view
	local music = MusicGenerator:new(era)
	local headerScene = HeaderScene:new()
	local worldGenerator = worldGenerator:new(era)
  local istruzioni= istruzioni:new()
	self.era = era
	self.music = music
	self.headerScene = headerScene
	self.difficolta = event.params.level
  self.istruzioni=istruzioni
--Si creano piattaforme
	local inizio = worldGenerator:creaPiattaforma("inizio") self.inizio = inizio
	local wall = worldGenerator:creaPiattaforma("muro") self.wall = wall
	local floor = worldGenerator:creaPiattaforma("pavimento") self.floor = floor
	local fine = worldGenerator:creaPiattaforma("fine") self.fine = fine

--Si crea ponte
	local ponte = ponte:new("Legno",self.inizio)
	self.ponte = ponte 
  istruzioni.skipbutton:addEventListener( "tap", skip )
  
	self:setListeners()
  --scritte perfect,nice,ok
  local perfectText = display.newText("PERFECT!", display.contentWidth/2, display.contentHeight/2,"towerruins.ttf", nil)
	  perfectText.xScale = 3
	  perfectText.yScale = 3
	  perfectText:setFillColor(0,0,0)
    perfectText.alpha=0
    self.perfectText=perfectText
    
    
    local okText = display.newText("Ok!", display.contentWidth/2, display.contentHeight/2,"towerruins.ttf", nil)
	  okText.xScale = 3
	  okText.yScale = 3
	  okText:setFillColor(0,0,0)
    okText.alpha=0
    self.okText=okText
    local giocatore = giocatore:new("giocatore", event.params.level) 
	self.giocatore = giocatore
	local backgroundCarousel = BackgroundCarousel:new(self)
	self.backgroundCarousel = backgroundCarousel


	sceneGroup:insert(backgroundCarousel.background)
	sceneGroup:insert(backgroundCarousel.nuvole)
	sceneGroup:insert(backgroundCarousel.nuvoleItems)
	sceneGroup:insert(backgroundCarousel.vulcani)
	sceneGroup:insert(backgroundCarousel.terrain)
	sceneGroup:insert(backgroundCarousel.terrainItems)
	sceneGroup:insert(backgroundCarousel.gioco)
end



function scene:show( event )
	local music = self.music
	local header = self.headerScene
  local istruzioni=self.istruzioni
	local background = self.background
	local headerScene = self.headerScene
	local bgCarousel = self.backgroundCarousel
	if(event.phase == "will") then

	end
	if(event.phase == "did") then

		music:playSong()
		self.tapFlag = true
		bgCarousel.background:addEventListener("tap", scene)
   		Runtime:addEventListener("enterFrame", self)
	end
end

function scene:hide( event )
	local music = self.music
    local sceneGroup = self.view
    if event.phase == "will" then
    	composer.removeScene("ambiente")
    end
    if( event.phase == "did") then
        	composer.gotoScene("ambiente", {params={level=self.difficolta}})
end 
end

function scene:destroy( event )
  --elimina musica
  transition.cancel()
  	Runtime:removeEventListener("enterFrame", self)
  local music = self.music
  local headerScene = self.headerScene
  local renderplayer = self.giocatore
  local renderPonte = self.ponte
  local bgCarousel = self.backgroundCarousel
  local istruzioni= self.istruzioni
  timer.performWithDelay(1000,function() bgCarousel:destroy() end)
  self.bgCarousel = nil
   timer.performWithDelay(1400,function() istruzioni:erase() end)
  music:stop()
  timer.performWithDelay(1500,function() music:destroy()end)
  self.music = nil
   timer.performWithDelay(1700,function() headerScene:destroy() end)
  self.headerScene = nil
  renderPonte:destroy()
  self.ponte = nil
  renderplayer:destroy()
  self.giocatore = nil
if(self.fine.item ~= nil)then
	display.remove(self.fine.item)
	self.fine.item = nil
end
  if(self.timerID ~= nil) then
  	timer.cancel(self.timerID)
  end
	
	physics.removeBody(self.inizio)
	display.remove(self.inizio)	self.inizio = nil
	display.remove(self.fine) self.fine = nil
	if(self.floor ~= nil) then
		if(self.floor.isBodyActive) then
			physics.removeBody(self.floor)
		end
		display.remove(self.floor) self.floor = nil
	end
	physics.removeBody(self.wall)
	display.remove(self.wall) self.wall = nil
	display.remove(self.dino) self.dino = nil
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene