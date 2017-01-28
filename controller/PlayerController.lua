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

	sceneGroupGlobal = sceneGroup

	noChao = true;

	pernas = display.newSprite(sceneGroup, spritesPersonagem, animacaoPersonagem)
	pernas:setSequence( "correndo" )
	pernas:play()

	pernas.x = 130
	pernas.y = display.contentCenterY
	pernas.myName = "pernas"

	torax = display.newImage(sceneGroup, spritesPersonagem, 3)
	torax.x = 130
	torax.y = display.contentCenterY - 13
	torax.myName = "torax"

	bracos = display.newImage(sceneGroup, spritesPersonagem, 2)
	bracos.x = 135
	bracos.y = display.contentCenterY - 15
	bracos.myName = "bracos"

	cabeca = display.newImage(sceneGroup, spritesPersonagem, 1)
	cabeca.x = 130
	cabeca.y = display.contentCenterY - 40
	cabeca.myName = "cabeca"

	fisica.addBody(pernas, "dynamic", {bounce = 0.5});
	fisica.addBody(torax, "dynamic",  {bounce = 0.5});
	fisica.addBody(bracos, "dynamic", {bounce = 0.75});
	fisica.addBody(cabeca, "dynamic", {bounce = 0.5});
	pernas.isFixedRotation = true;

	joint = fisica.newJoint("piston", pernas, torax, pernas.x, pernas.y, 0, -1)
	joint2 = fisica.newJoint("piston", torax, bracos, torax.x, torax.y, 0, -1)
	joint3 = fisica.newJoint("piston", torax, cabeca, torax.x, torax.y, 0, -1)

	joint.isLimitEnabled = true
	joint:setLimits( -10, 5 )

	joint2.isLimitEnabled = true
	joint2:setLimits( 0, 0 )

	joint3.isLimitEnabled = true
	joint3:setLimits( -20, -2 )

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
	Runtime:addEventListener("touch", swipe)
	Runtime:addEventListener("collision", colisaoPlataforma)

	timerIdPosicao = timer.performWithDelay(1, mudaPosicaoCollision, 0)
end

function Player.pauseTimer()
	timer.pause(timerIdPosicao)
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

function quedaPlayer()
	-- if(pernas ~= nil) then
	-- 	pernas:applyForce( 0, 12, pernas.x, pernas.y )
	-- end
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
	if(noChao == true and
		pernas.y <= alturaTela - 30) then

		noChao = false;
    	
    	pernas:pause()

		pernas:applyForce( 0, -8, pernas.x, pernas.y )
		torax:applyForce( 0, -4, torax.x, torax.y )
		-- cabeca:applyForce( 0, -2, cabeca.x, cabeca.y )

		timerIdQueda = timer.performWithDelay(450, quedaPlayer, 1);
		print("pula!")
	end
end

-- Um décimo da tela
local medicaoReferencia = alturaTela * 0.1;
local yInicio, yFim, yRazao = 0;
local xSwipe = 0;

function swipe(event)

    if ( event.phase == "began" ) then
        
		yInicio = event.y
		xSwipe = event.x
        
    elseif ( event.phase == "moved" and xSwipe < display.contentCenterX ) then

        yFim = event.y
        yRazao = yInicio - yFim;

        if (math.abs(yRazao) > medicaoReferencia) then
	        if (yRazao > 0) then
	        	pula()
	        end
	    end
    end

    return true
end

function colisaoPlataforma(event)
	if(event.phase == "began") then
        if(event.object1.myName == "plataforma" and
		   event.object2.myName == "pernas" and noChao == false) then

			noChao = true;
		    		
			pernas:setSequence( "correndo" )
		    pernas:play()
    
			print("encosta")
		end
	end

end

function Player.removeListeners()
	Runtime:removeEventListener("tap", atirar )
	Runtime:removeEventListener("touch", swipe)
	Runtime:removeEventListener("collision", colisaoPlataforma);
end

return Player;