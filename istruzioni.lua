local widget = require("widget")

local istruzioni ={}
--funzione per i menu istruzioni
function istruzioni:InstructionOn(event)
        physics.pause()
        print(self.Instructcounter)
         self.Instructcounter=self.Instructcounter+1
        print(istruzioni.Instructcounter)
       if(self.Instructcounter==1) then
      
         display.remove(self.istruct00)
        self.instruct00=nil
         self.istruct01.alpha=1
         return true
        end
         if(self.Instructcounter==2) then
       
         display.remove(self.istruct01)
         self.instruct01=nil
         self.istruct02.alpha=1
         return true
        end
         if(self.Instructcounter==3) then

         display.remove(self.istruct02)
        self.instruct02=nil
         self.istruct03.alpha=1
         return true
        end
         if(self.Instructcounter==4) then
 
         display.remove(self.istruct03)
         self.instruct03=nil
         self.istruct04.alpha=1
         return true
         end
         if(self.Instructcounter==5) then
         display.remove(self.istruct04)
         self.instruct04=nil
         display.remove(self.sfondoistruct)
         self.sfondoistruct=nil
         self.skipbutton.alpha=0
         physics.start()
        end
        return true
end
function istruzioni:InstructionObjOn(event)
        physics.pause()
        print(self.Instructcounter)
         self.Instructcounter=self.Instructcounter+1
        print(istruzioni.Instructcounter)
       if(self.Instructcounter==6) then
         display.remove(self.istructObj01)
        self.istructObj01=nil
         self.istructObj02.alpha=1
         return true
        end
         if(self.Instructcounter==7) then
         display.remove(self.istructObj02)
         self.istructObj02=nil
        display.remove(self.sfondoistruct2)
         self.sfondoistruct2=nil
         self.istritem=false
         self.fineistruzioni=true
         physics.start() 
         display.remove(self.skipbutton)
         self.skipbutton=nil
        end
        return true
end
function istruzioni:skip()
  istruzioni:erase()
  physics.start() 
  end

function istruzioni:creaSfondo()
  local sfondoistruct2=display.newImage("bottone.png",700,900) 
self.sfondoistruct2=sfondoistruct2
	sfondoistruct2.x = display.contentCenterX; 
	sfondoistruct2.y = display.contentCenterY;
	sfondoistruct2:scale(0.7,0.8)
  sfondoistruct2.alpha=1
   local istructObj01=display.newImage("istruzioni/InsObj01.png",700,900) 
self.istructObj01=istructObj01
	istructObj01.x = display.contentCenterX; 
	istructObj01.y = display.contentCenterY;
	istructObj01:scale(0.65,0.6)
  istructObj01.alpha=1
   local istructObj02=display.newImage("istruzioni/InsObj02.png",700,900) 
self.istructObj02=istructObj02
	istructObj02.x = display.contentCenterX; 
	istructObj02.y = display.contentCenterY;
	istructObj02:scale(0.65,0.6)
  istructObj02.alpha=0
  end
--set istruzioni
function istruzioni:new()
  setmetatable({}, self)
	self.__index = self
  local fineistruzioni=false
  self.fineistruzioni=fineistruzioni
  local isfirstitem=true
  self.isfirstitem=isfirstitem
  local istritem=false
  self.istritem=istritem
local Instructcounter =0
 self.Instructcounter=Instructcounter
local sfondoistruct=display.newImage("bottone.png",700,900) 
self.sfondoistruct=sfondoistruct
	sfondoistruct.x = display.contentCenterX; 
	sfondoistruct.y = display.contentCenterY;
	sfondoistruct:scale(0.7,0.8)
  sfondoistruct.alpha=1
local istruct00=display.newImage("istruzioni/Ins00.png",700,900) 
self.istruct00=istruct00
	istruct00.x = display.contentCenterX; 
	istruct00.y = display.contentCenterY;
	istruct00:scale(0.65,0.6)
  istruct00.alpha=1
  local istruct01=display.newImage("istruzioni/Ins01.png",700,900) 
self.istruct01=istruct01
	istruct01.x = display.contentCenterX; 
	istruct01.y = display.contentCenterY;
	istruct01:scale(0.65,0.6)
  istruct01.alpha=0
local istruct02=display.newImage("istruzioni/Ins02.png",700,900) 
self.istruct02=istruct02
	istruct02.x = display.contentCenterX; 
	istruct02.y = display.contentCenterY;
	istruct02:scale(0.65,0.6)
  istruct02.alpha=0
local istruct03=display.newImage("istruzioni/Ins03.png",700,900) 
self.istruct03=istruct03
	istruct03.x = display.contentCenterX; 
	istruct03.y = display.contentCenterY;
	istruct03:scale(0.65,0.6)
  istruct03.alpha=0
local istruct04=display.newImage("istruzioni/Ins04.png",700,900) 
self.istruct04=istruct04
	istruct04.x = display.contentCenterX; 
	istruct04.y = display.contentCenterY;
	istruct04:scale(0.65,0.6)
  istruct04.alpha=0
  local skipbutton = widget.newButton(
		{
		id="skip",
		width = 80,
        height = 35,
        defaultFile = "bottone.png",
        --overFile = "trasparente.png",
        x = display.contentCenterX*1.9, 
		y = display.contentCenterY*1.6,
		label= "Skip",
		font = "towerruins.ttf",
		labelColor = {default={ 0, 0, 0 }}
		}
	)
  self.skipbutton=skipbutton
  self.skipbutton:toFront()
  return self
 end 
 function istruzioni:erase()
   display.remove(self.sfondoistruct)
        self.sfondoistruct=nil
    display.remove(self.sfondoistruct2)
     self.sfondoistruct2=nil 
   display.remove(self.istruct00)
        self.instruct00=nil
         display.remove(self.istruct01)
        self.instruct01=nil
         display.remove(self.istruct02)
        self.instruct02=nil
         display.remove(self.istruct03)
        self.instruct03=nil
         display.remove(self.istruct04)
        self.instruct04=nil
         display.remove(self.istructObj01)
        self.istructObj01=nil
         display.remove(self.istructObj02)
        self.istructObj02=nil
        if(self.fineistruzioni==true)then
        display.remove(self.skipbutton)
        self.skipbutton=nil
    else
      self.skipbutton.alpha=0
     end
     end
  return istruzioni
