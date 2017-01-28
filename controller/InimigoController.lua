display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local fisica = require("physics")

local Inimigo = {}

function Inimigo.load(sceneGroup)

	flagColisaoCabeca = false
	flagColisaoTorax = false
	flagColisaoBracos = false
	flagColisaoPernas = false

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

	updatePtero(sceneGroup)
end

function updatePtero(sceneGroup)
	timerPtero = timer.performWithDelay(1500, initPtero, 0)
	timerPtero.params = { myParamScene = sceneGroup}
end

function Inimigo.pauseTimer()
	timer.pause(timerPtero)
end

function initPtero(event)

	local params = event.source.params

	local ptero = display.newSprite(params.myParamScene, spritesPersonagem, animacaoPersonagem )
	ptero.myName = "inimigoPtero"
	ptero:setSequence("voando")
	ptero:play()

	local randomDistance = math.random(200, 2000)

	local randomTime = randomDistance * 10

	ptero.x = display.contentWidth + randomDistance
	ptero.y = display.contentCenterY + 50

	fisica.addBody(ptero, "dynamic", {chain = {-64, -5, 22, -64, 64, 0, 22, 64, -20, 38, -20, -5},
        connectFirstAndLastChainVertex = true})
	ptero.gravityScale = 0
	ptero.isFixedRotation = true;

	ptero.collision = colisao
	ptero:addEventListener( "collision" )

	transition.to( ptero, { time = randomTime, x = -250, onComplete = clear })
end

function colisao( self, event )
 	if ( event.phase == "began" ) then
 		if (event.other.myName == "tiroBasic") then
 			print("matou")
 			clear(event.other)
 			transition.to( self, { time = 200, alpha = 0, rotation = 180, x = display.contentWidth, onComplete = clear })
 		elseif (event.other.myName == "cabeca" and flagColisaoCabeca == false) then
			trueFlags()
			finish(self, event)
		elseif (event.other.myName == "bracos" and flagColisaoBracos == false) then
			trueFlags()
			finish(self, event)
		elseif (event.other.myName == "pernas" and flagColisaoPernas == false) then
			trueFlags()
			finish(self, event)
		elseif (event.other.myName == "torax" and flagColisaoTorax == false) then
			trueFlags()
			finish(self, event)
 		end
    end
end

function trueFlags()
	flagColisaoCabeca = true
	flagColisaoBracos = true
	flagColisaoPernas = true
	flagColisaoTorax = true
end

function finish(self, event)
	print("GAME OVER"..event.other.myName)
	transition.to( event.other, { time = 500, rotation = 180, onComplete = clear })
	transition.to( self, { time = 200, alpha = 0, rotation = 180, x = display.contentWidth, onComplete = gameOver })
end

function clear(object)
	display.remove(object)
	object = nil
end

function gameOver(object)
	display.remove(object)
	object = nil
	local composer = require("composer")
	composer.gotoScene( "scenes.menu", { time = 200, effect = "crossFade" } )
end

return Inimigo