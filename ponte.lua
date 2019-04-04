local physics = require("physics")
local ponte = {}

function ponte:new(materiale,inizio)
	setmetatable({}, self)
	self.__index = self
	self.materiale = materiale
	self.Build=false
	if(self.dino == nil) then
	self.dino = self:creaDino(inizio.x, inizio.y, inizio.height,inizio.width) end
	self.render = self:renderPonte(inizio.x+inizio.contentWidth/2 +1,inizio.y - inizio.contentHeight/2)
	return self
end

function ponte:destroy()
	transition.cancel(self.render)
	self:destroyRender()
	self:destroyDino()
end

function ponte:renderPonte(Xancora,Yancora)
	local render = {} 
	local collo = display.newImageRect("collo.png",display.contentWidth/90, 0)
 -- Inserisco la testa base nel gruppo
	testegroup = display.newGroup()
	local testa = display.newImageRect( testegroup, "testa.png",100,100)
	print("debugging")
	print(testa.x)
	print(self.dino.x)
	testa.x = self.dino.x+38
	testa.y = display.contentHeight/1.09
	testa:scale(0.3, 0.22)
	testa.isVisible=true
	collo.x=self.dino.x + 28 
	collo.y=self.dino.y-3

	local testaponte=display.newImageRect(testegroup,"testa_ponte.png",100,100)
	testaponte.x = collo.x     testaponte.y = collo.y
	testaponte:scale(0.3, 0.22)
	testaponte.isVisible=false
	testaponte:toFront()
	testegroup:insert(testa)   testegroup:insert(testaponte)
	render.collo=collo 
	render.testa = testa   
	render.testaponte = testaponte

	render.collo.nome = "ponte"
	render.testaponte.nome="testaponte"
	return render
end
 
function ponte:creaDino(x,y,h,w)
local dino=display.newImage("corposano.png") 
	dino:scale(0.3, 0.3)
	dino.x = x + w/4
	dino.y = y - h/2

	return dino
end

function ponte:destroyDino()
local dino = self.dino
display.remove(dino) self.dino = nil
end

function ponte:destroyRender()
local render = self.render
if(render.collo ~=nil and render.testaponte ~= nil) then
physics.removeBody(render.collo)
physics.removeBody(render.testaponte)
display.remove(render.collo) render.collo = nil
display.remove(render.testa) render.testa = nil
display.remove(render.testaponte) render.testaponte = nil
end
end

function ponte:destroyByItem(scene)
    if(self.render.testaponte ~=nil and self.render.collo ~= nil) then
    	if(scene.clava~=0 and self.render.collo.height ~=0 and self.Build==false )then
 			self:destroyRender()
 			local x,y = self.dino.x, self.dino.y
 			display.remove(self.dino)
 			self.dino = display.newImage("corposano.png")
 			self.dino:scale(0.3,0.3)
 			self.dino.x = x
 			self.dino.y = y
    		scene.ponte = ponte:new(scene.era,scene.inizio)
    		scene.view:insert(scene.ponte.render.collo)
    		scene.view:insert(scene.ponte.render.testa)
    		scene.view:insert(scene.ponte.render.testaponte)
    		scene.tapFlag =true
    		scene.headerScene:useScoreItem()
    		else return true
    	end
    	else scene.tapFlag="wait"
    end 	
end

function ponte:terminaPonte(event,scene)
	local inizio = scene.inizio
	local render = self.render.collo
	local testaponte = self.render.testaponte
	if(self.ponteTransition) then
		transition.pause()
		physics.addBody(self.render.collo,"dinamic",{density=0.65, bounce=0, friction=0.3})
  		physics.addBody(testaponte,"dinamic",{shape={-2,-2,-2,2,8,8,0.5,-0.5}})
  		testaponte.isFixedRotation = true
  		testaponte.angularVelocity = 0
  		testaponte.rotation=0
  		testaponte.rotation=testaponte.rotation +150
		local joint = physics.newJoint("pivot",inizio,render,render.x-1,inizio.y- inizio.contentHeight/2 )
  		local jointb = physics.newJoint("pivot",testaponte,render,render.x,testaponte.y )
		render:applyLinearImpulse(1,0,0,0)
		self.Build=false
	end
	local x,y = self.dino.x, self.dino.y
	display.remove(self.dino)
	self.dino = display.newImage("corposano1.png")
	self.dino:scale(0.3,0.3)
	self.dino.x = x
	self.dino.y = y
end

local function allungaPonte()
	ponte:creaPonte()
end

local function accorciaCollo()
	local render = ponte.render.collo
	local testaponte = ponte.render.testaponte
	if(render ~= nil and testaponte ~=nil) then
	ponte.ponteTransition = transition.to(render, {time=2000, height=0, onComplete = allungaPonte})
	ponte.ponteTransition = transition.to(testaponte, {time=2000, y=render.height})
end
end

function ponte:creaPonte(event)
	local render = self.render.collo
	local testaponte = self.render.testaponte
	self.Build=true
	if(render ~= nil and testaponte ~= nil) then
	render.anchorY = display.contentHeight
	self.ponteTransition = transition.to(render, { time=2000, height = display.contentHeight, onComplete =accorciaCollo})
	  	self.ponteTransition = transition.to(testaponte, { time=2000,y=render.height})
end
end

return ponte