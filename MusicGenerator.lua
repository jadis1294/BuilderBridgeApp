 local audio = require("audio")
 local media = require("media")

local mGenerator = {}

function mGenerator:new(era)
	local music
	local itemSound
if(era == 1) then
 music ="prehistoric.wav"
itemSound = "getItem.mp3"
end
setmetatable({}, self)
	self.__index = self
  self.music=music
  self.itemSound = itemSound
	return self
end

function mGenerator:fireItemSound(ch)
	self.handleItemSound = audio.loadSound(self.itemSound)
	audio.play(self.handleItemSound,{
        channel = ch,
        loops = 0,
        onComplete = (function() audio.stop( self.itemsound )
        self.handleItemSound = nil end)
        })
end

function mGenerator:playMusic()
	self.handleMusic = audio.loadStream(self.music)
	self.musicChannel = audio.play(	self.handleMusic,{
    channel = 1,
    loops = -1,
})
end

function mGenerator:setVolume(vol,ch)
  audio.setVolume( vol, { channel=ch} ) -- set the volume on channel 1
	end

function mGenerator:playSong()
self:setVolume(0.3,1)
self:playMusic()
end

function mGenerator:stop()
	audio.stop(1)
	audio.dispose(self.handleMusic)
	self.handle = nil
end

function mGenerator:destroy()
audio.dispose(self.handleMusic)
audio.dispose(self.handleItemSound)
self.music = nil
self.itemSound = nil
self.handleItemSound = nil
self.handleMusic = nil
end

return mGenerator
