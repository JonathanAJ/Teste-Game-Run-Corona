local fisica = require("physics")

local alturaTela = display.contentHeight
local larguraTela = display.contentWidth

local Inimigo = {}

function Inimigo.load(sceneGroup)

	options = {
	    width = 125,
	    height = 128,
	    numFrames = 2
	}

	spritesPersonagem = graphics.newImageSheet("assets/pterosheet.png", options )

	animacaoPersonagem = {
	    {
	        name = "voando",
	        frames = { 1, 2},
	        time = 300,
	        loopCount = 0
	    }
	}
	initPtero(sceneGroup, 3000, 300)
	initPtero(sceneGroup, 6000, 300)
	initPtero(sceneGroup, 9000, 300)
end

function initPtero(sceneGroup, time, distance)
	local ptero = display.newSprite(sceneGroup, spritesPersonagem, animacaoPersonagem )
	ptero.myName = "inimigoPtero"
	ptero:setSequence("voando")
	ptero:play()

	ptero.x = display.contentWidth + distance
	ptero.y = display.contentCenterY + 50

	fisica.addBody(ptero, "dynamic", {chain = {-64, -5, 22, -64, 64, 0, 22, 64, -20, 38, -20, -5},
        connectFirstAndLastChainVertex = true})
	ptero.gravityScale = 0
	ptero.isFixedRotation = true;

	ptero.collision = colisao
	ptero:addEventListener( "collision" )

	transition.to( ptero, { time = time, x = -250, onComplete = clear })
end

function colisao( self, event )
 	if ( event.phase == "began" ) then
 		if(event.other.myName == "tiroBasic") then
 			print("acertou o tiro > MORREU")
 			clear(event.other)
 			self.bodyType = "kinematic"
 			transition.to( self, { time = 200, alpha = 0, rotation = 180, x = display.contentWidth, onComplete = clear })
 		elseif(event.other.myName == "cabeca") then
 			print("GAME OVER")
 			event.other.bodyType = "kinematic"
 			self.bodyType = "kinematic"
 			transition.to( event.other, { time = 500, rotation = 180, onComplete = clear })
 			transition.to( self, { time = 200, alpha = 0, rotation = 180, x = display.contentWidth, onComplete = clear })
 		end
    end
end

function clear(object)
	display.remove(object)
	object = nil
end

return Inimigo