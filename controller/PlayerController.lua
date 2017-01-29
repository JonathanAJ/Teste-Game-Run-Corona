display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local fisica = require("physics")

local alturaTela = display.contentHeight
local larguraTela = display.contentWidth

local pex = require( "ponywolf.pex" )
local tiroBasicData = pex.load( "particles/tiro_basic/particle.pex", "particles/tiro_basic/texture.png" )

local Player = {}

local options =
{
    frames =
    {
        {   -- cabeca
            x = 0,
            y = 0,
            width = 31,
            height = 31
        },
        {   -- bracos
            x = 32,
            y = 0,
            width = 62,
            height = 31
        },
        {   -- torax
            x = 94,
            y = 0,
            width = 40,
            height = 31
        },
        {   -- perna1
            x = 135,
            y = 0,
            width = 47,
            height = 29
        },
        {   -- perna2
            x = 182,
            y = 0,
            width = 52,
            height = 29
        },
        {   -- perna3
            x = 234,
            y = 0,
            width = 47,
            height = 29
        }
    }
}

local spritesPersonagem = graphics.newImageSheet( "assets/spritesheet.png", options )

local animacaoPersonagem = {
    {
        name = "correndo",
        frames = { 4, 5, 6},
        time = 200,
        loopCount = 0
    }
}

function Player.load(sceneGroup)

	fisica.setGravity( 0, 30 )

	sceneGroupGlobal = sceneGroup

	pernas = display.newSprite(sceneGroup, spritesPersonagem, animacaoPersonagem)
	pernas:setSequence( "correndo" )
	pernas:play()

	pernas.x = 130
	pernas.y = alturaTela - 50
	pernas.myName = "pernas"
	pernas.canJump = 0

	torax = display.newImage(sceneGroup, spritesPersonagem, 3)
	torax.x = 130
	torax.y = alturaTela - 70
	torax.myName = "torax"

	bracos = display.newImage(sceneGroup, spritesPersonagem, 2)
	bracos.x = 135
	bracos.y = alturaTela - 70
	bracos.myName = "bracos"

	cabeca = display.newImage(sceneGroup, spritesPersonagem, 1)
	cabeca.x = 130
	cabeca.y = alturaTela - 95
	cabeca.myName = "cabeca"

	fisica.addBody(pernas, "dynamic");
	fisica.addBody(torax, "dynamic");
	fisica.addBody(bracos, "dynamic");
	fisica.addBody(cabeca, "dynamic");
	pernas.isFixedRotation = true;
	torax.isFixedRotation = true;
	bracos.isFixedRotation = true;
	cabeca.isFixedRotation = true;

	joint = fisica.newJoint("piston", pernas, torax, pernas.x, pernas.y, 0, 1)
	joint2 = fisica.newJoint("piston", torax, bracos, torax.x, torax.y, 0, 1)
	joint3 = fisica.newJoint("piston", torax, cabeca, torax.x, torax.y, 0, 1)

	joint.isLimitEnabled = true
	joint:setLimits( -1, 3 )

	joint2.isLimitEnabled = true
	joint2:setLimits( -1, 1 )

	joint3.isLimitEnabled = true
	joint3:setLimits( -1, 0 )

	playerCollisionFront = display.newRect(sceneGroup, pernas.x + 90, pernas.y, 2, 30);
	playerCollisionFront.anchorX = 0
	playerCollisionFront.anchorY = 1
	playerCollisionFront.alpha = 0

	playerCollisionBack = display.newRect(sceneGroup, pernas.x - 30, pernas.y - 15, 2, 70);
	playerCollisionBack.anchorX = 0
	playerCollisionBack.anchorY = 1
	playerCollisionBack.alpha = 0

	fisica.addBody(playerCollisionFront, "kinematic")
	playerCollisionFront.myName = "playerCollisionFront"
	playerCollisionFront.isFixedRotation = true;

	fisica.addBody(playerCollisionBack, "kinematic")
	playerCollisionBack.myName = "playerCollisionBack"
	playerCollisionBack.isFixedRotation = true;

	-- EventListeners
	Runtime:addEventListener("tap", atirar)
	pernas.collision = colisaoPlataforma
	pernas:addEventListener("collision")

	timerIdPosicao = timer.performWithDelay(1, mudaPosicaoCollision, 0)

	local btPula = display.newCircle(sceneGroup, 50, alturaTela-25, 40)
	btPula:setFillColor(0,0,0)
	btPula.alpha = 0.6
	btPula:addEventListener("tap", pula)
end

function atirar(event)
	if(event.x > display.contentCenterX) then
		print("atirou");
		torax:applyForce( -8, 0, torax.x, torax.y )
		particula()
	end
end

function mudaPosicaoCollision()
	playerCollisionFront.y = pernas.y + 15;
	playerCollisionBack.y = pernas.y + 15;
end

function removeParticula(obj)
	display.remove(obj)
	obj = nil
end

function particula()
	local tiroBasic = display.newEmitter(tiroBasicData)
	sceneGroupGlobal:insert(tiroBasic)

	tiroBasic.x = bracos.x - 25
	tiroBasic.y = bracos.y
	fisica.addBody(tiroBasic, "kinematic", {shape = { 65, 5, 65, -5, 50, 0 }});
	tiroBasic.myName = "tiroBasic"
	tiroBasic.trans = transition.to(tiroBasic, { time = 3000, x = display.contentWidth + 10,
									transition = easing.linear, onComplete = removeParticula })
end

function pula()
	if(pernas.canJump > 0) then
    	pernas:pause()
		pernas:applyForce( 0, -25, pernas.x, pernas.y )
		print("pula!")
		timer.performWithDelay(500, playCorre, 1)
	end
end

function playCorre()
	pernas:setSequence( "correndo" )
    pernas:play()
end

function colisaoPlataforma(self, event)
	if(event.other.myName == "plataforma" ) then
      if (event.phase == "began" ) then
       	self.canJump = self.canJump+1
      elseif (event.phase == "ended" ) then
        self.canJump = self.canJump-1
		print("encosta")
      end
   end
end

function Player.removeListeners()
	Runtime:removeEventListener("tap", atirar )
	pernas:removeEventListener("collision");
end

function Player.pauseTimer()
	pernas:pause()
	timer.pause(timerIdPosicao)
end

return Player;