--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function PlayBlockSound()

	local RndSoundNumber = math.random(1,4)
	playSound("sfx/Block"..RndSoundNumber..".mp3")

end

function PlayFuse()
	playSound("sfx/Fuse.mp3")
end

function PlayFuse3D(x,y,z)
	playSound3D("sfx/Fuse.mp3", x, y, z)
end

function PlayExplosion()
	playSound("sfx/Explosion.mp3")
end

function PlayExplosion3D(x,y,z)
	playSound3D("sfx/Explosion.mp3", x, y, z)
end