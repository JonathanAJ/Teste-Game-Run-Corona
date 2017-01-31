display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local fisica = require("physics")
local composer = require("composer")
local score = require ("controller.ScoreController")

-- Pega a cena atual
local scene = composer.getScene( composer.getSceneName( "current" ) )
local sounds = scene.sounds

-- var locais
local Inimigo = {}
local sceneGroupLocal
local flagColisaoCabeca
local flagColisaoTorax
local flagColisaoBracos
local flagColisaoPernas
local spritesPersonagem
local animacaoPersonagem

function Inimigo.load(sceneGroup)
	sceneGroupLocal = sceneGroup

	flagColisaoCabeca = false
	flagColisaoTorax = false
	flagColisaoBracos = false
	flagColisaoPernas = false

	local options = {
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
	timerPtero = timer.performWithDelay(1000, initPtero, 0)
end

function Inimigo.pauseTimer()
	timer.pause(timerPtero)
	transition.pause()
end

function initPtero(event)

	local dificuty
	local randomTime

	local ptero = createPtero()
	local level = score.getLevel()

	if(level < 80) then
		dificuty = level * 10
	else
		dificuty = 800
	end

	randomTime = math.random(1000 - dificuty, 2000 - dificuty)

	transition.to( ptero, { time = randomTime, x = -100, onComplete = clear })
end

function createPtero()
	local ptero = display.newSprite(sceneGroupLocal, spritesPersonagem, animacaoPersonagem )
	ptero.myName = "inimigoPtero"
	ptero:setSequence("voando")
	ptero:play()
	ptero.x = largura + 100
	ptero.y = centerY + 50
	fisica.addBody(ptero, "dynamic",
		{chain = {-64, -5, 22, -64, 64, 0, 22, 64, -20, 38, -20, -5},
    	 connectFirstAndLastChainVertex = true})
	ptero.gravityScale = 0
	ptero.isFixedRotation = true
	ptero.collision = colisao
	ptero:addEventListener( "collision" )
	return ptero
end

function colisao( self, event )
 	if ( event.phase == "began" ) then
 		if (event.other.myName == "tiroBasic") then
 			print("matou")
			audio.play(sounds.enemie)
 			clear(event.other)
 			transition.to( self, { time = 700, rotation = 180, x = display.contentWidth, onComplete = clear })
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
	print("GAME OVER "..event.other.myName)
	audio.play(sounds.hit)
	transition.to( event.other, { time = 200, rotation = math.random(-270, -90)})
	transition.to( self, { time = 200, rotation = math.random(-270, -90), onComplete = gameOver })
end

function clear(object)
	display.remove(object)
	object = nil
end

function gameOver(object)
	audio.play(sounds.gameover)
	score.show()
end

return Inimigo