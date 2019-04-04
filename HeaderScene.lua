local widget = require("widget")
local headerScene = {}

function headerScene:new()
setmetatable({}, self)
	self.__index = self
  self.score= 0
  self.perfectcounter = false
  self.clava = 0
  self:drawHeader()
  self.oldScore = 0
  self.duration = 2000
  self.fps = 30
	return self
end

local function lerp( v0, v1, t )
    print(v0 + t * (v1 - v0))
    return v0 + t * (v1 - v0)
end
 
 function headerScene:UpdateOldScore(values)
   self.oldScore = values
   end
local function showScore( target, value, duration, fps, oldScore )
    --if value == 0 then
    --    return
    --end
    local newScore = oldScore
    local passes = duration / fps
    local increment = lerp( 0, value, 1/passes )
 
    local count = 0
    local function updateText()
        if newScore <= value then
            newScore = newScore + increment
            target.text = string.format( "%7d", newScore )
            count = count + 1
        else
            headerScene:UpdateOldScore(value)
            target.text = string.format( "%7d", value )
            Runtime:removeEventListener( "enterFrame", updateText )
            
        end
    end
    Runtime:addEventListener( "enterFrame", updateText )
end
 

--funzione di aggiornamento del punteggio
function headerScene:updateScore()
  --local scoreNumber= self.scoreNumber
  self.score = self.score +100 * self.xscoreNumberText.text
  showScore( self.scoreNumber, self.score, self.duration, self.fps, self.oldScore )
	--self.scoreNumber.text = self.score

end

--funzione di aggiornamento del moltiplicatore punteggio
function headerScene:Xscore()
  if(self.perfectcounter==false)then
    self.xscoreNumber=1
    self.xscoreNumberText.text=self.xscoreNumber
    return
end

  if(self.perfectcounter==true and self.xscoreNumber<4)then
    self.xscoreNumber=self.xscoreNumber+1 
    self.xscoreNumberText.text=self.xscoreNumber
  end
  
end

function headerScene:useScoreItem()
	local scoreNumberClava= self.scoreNumberClava
	self.clava = self.clava - 1
  print(self.clava)
  scoreNumberClava.text=self.clava
  if(self.clava~=9)then
    self.scoreTextMaxClava.alpha=0
    end
end

function headerScene:drawIndietroDisplay()
local indietro = widget.newButton(
		{
		id = "indietro",
		defaultFile = "bottoneexit.png",
		x = display.contentCenterX*1.9,
		y = display.contentHeight/10,
    	width = 38,
    	height = 37,
    	cornerRadius = 7,
		}
	)
	self.indietro = indietro
end

function headerScene:drawItemDisplay()
local clavabutton = widget.newButton(
		{
		id="clava",
		width = 45,
        height = 45,
        defaultFile = "button_clava.png",
     x=display.contentWidth/120, 
     y=display.contentHeight/4.5
		}
	)
  self.clavabutton=clavabutton

local scoreNumberClava = display.newText(self.clava, display.contentCenterX/100*20, display.contentHeight/4,"towerruins.ttf", nil) self.scoreNumberClava=scoreNumberClava
    scoreNumberClava.xScale = 1
	scoreNumberClava.yScale = 1
  	scoreNumberClava:setFillColor(0,0,0)
  self.scoreNumberClava = scoreNumberClava

local scoreTextClava = display.newText("x", display.contentCenterX/100*15, display.contentHeight/4,"towerruins.ttf", nil)
	scoreTextClava.xScale = 0.8
	scoreTextClava.yScale = 0.8
	scoreTextClava:setFillColor(0,0,0)

	self.scoreTextClava = scoreTextClava

  local scoreTextMaxClava=display.newText("max", display.contentCenterX/100*28, display.contentHeight/25*7,"towerruins.ttf", nil)
  scoreTextMaxClava.xScale = 0.6
	scoreTextMaxClava.yScale = 0.6
	scoreTextMaxClava:setFillColor(0,0,0)
  scoreTextMaxClava.alpha=0
  self.scoreTextMaxClava=scoreTextMaxClava
end

function headerScene:drawHeader()
self:drawScoreDisplay()
self:drawIndietroDisplay()
self:drawItemDisplay()
end

function headerScene:drawScoreDisplay()
local scoreNumber = display.newText(' ', display.contentWidth/100*37, display.contentHeight/10,"towerruins.ttf", nil)
	scoreNumber.xScale = 1.8
	scoreNumber.yScale = 1.8
	scoreNumber:setFillColor(0,0,0)
	self.scoreNumber = scoreNumber
local scoreText = display.newText(" Score :", display.contentWidth/25, display.contentHeight/10,"towerruins.ttf", nil)
	scoreText.xScale = 1.2
	scoreText.yScale = 1.2
	scoreText:setFillColor(0,0,0)
	self.scoreText = scoreText
local xscore =display.newImage("counterscore.png")
  xscore.x=display.contentWidth/100*55
  xscore.y=display.contentHeight/10
  xscore:scale(0.1,0.1)
  self.xscore=xscore
  
local xscoreNumber=1
  self.xscoreNumber=xscoreNumber
  
local xscoreNumberText=display.newText(xscoreNumber, display.contentWidth/100*55, display.contentHeight/10,"towerruins.ttf", nil)
  xscoreNumberText:setFillColor(0,0,0)
  self.xscoreNumberText=xscoreNumberText
local xscoreNumberX=display.newText("x", display.contentWidth/100*53.5, display.contentHeight/100*7, nil)
  xscoreNumberX:setFillColor(0,0,0)
  xscoreNumberX:scale(0.7,0.7)
  self.xscoreNumberX=xscoreNumberX

end

--funzione di aggiornamento del numero delle clave
function headerScene:updateScoreItem()
  if(self.clava==9)then
    return
    end
	local scoreNumberClava= self.scoreNumberClava
	self.clava = self.clava + 1
  scoreNumberClava.text=self.clava
  if(self.clava==9)then
    self.scoreTextMaxClava.alpha=1
    end
end
function headerScene:destroy()
display.remove(self.scoreNumber) self.scoreNumber = nil
display.remove(self.scoreText)	self.scoreText = nil
display.remove(self.scoreNumberClava)	self.scoreNumberClava = nil
display.remove(self.scoreTextClava)	self.scoreTextClava = nil
display.remove(self.scoreTextMaxClava) self.scoreTextMaxClava = nil
display.remove(self.xcounter3) self.xcounter3 = nil
display.remove(self.xcounter2)	self.xcounter2 = nil
display.remove(self.xcounter1)	self.xcounter1 = nil
display.remove(self.indietro)	self.indietro = nil
display.remove(self.clavabutton) self.clavabutton = nil
display.remove(self.xscoreNumberX) self.xscoreNumberX = nil
display.remove(self.xscoreNumberText)	self.xscoreNumberText = nil
display.remove(self.xscore)	self.xscore = nil
self.clava = nil
end

return headerScene