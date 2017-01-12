local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

-- local confSprites = {
-- 	width = 128,
-- 	height = 128,
-- 	numFrames = 4
-- }

-- local spritesPersonagem = graphics.newImageSheet("assets/spritesheet.png", confSprites);

-- local shapePernas = {
-- 					  -20, 35, -- left-top
-- 					   25, 35, -- rigth-top
-- 					   25, 65, -- rigth-bottom
-- 					  -20, 65  -- left-bottom
-- 					}

-- local shapeTorax = {
-- 					  -5, 15, -- left-top
-- 					   35, 15, -- rigth-top
-- 					   35, 45, -- rigth-bottom
-- 					  -5, 45  -- left-bottom
-- 					}

-- local shapeBracos = {
-- 					  -10, 15, -- left-top
-- 					   40, 15, -- rigth-top
-- 					   40, 25, -- rigth-bottom
-- 					  -10, 25  -- left-bottom
-- 					}

-- local shapeCabeca = {
-- 					  -10, -20, -- left-top
-- 					   20, -20, -- rigth-top
-- 					   20, 10, -- rigth-bottom
-- 					  -10, 10  -- left-bottom
-- 					}

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
        time = 400,
        loopCount = 0
    }
}

local pernas
local torax
local cabeca
local bracos
local playerCollisionFront

local function atirar(event)

	if(event.x > display.contentCenterX) then
		print("atirou");
		torax:applyForce( 2, 0, torax.x, torax.y )
	end

end

function Player.load(sceneGroup)

	pernas = display.newSprite(sceneGroup, spritesPersonagem, animacaoPersonagem)
	pernas:setSequence( "correndo" )
	pernas:play()

	pernas.x = 130
	pernas.y = display.contentCenterY
	pernas.name = "pernas"

	torax = display.newImage(sceneGroup, spritesPersonagem, 3)
	torax.x = 130
	torax.y = display.contentCenterY - 13

	bracos = display.newImage(sceneGroup, spritesPersonagem, 2)
	bracos.x = 135
	bracos.y = display.contentCenterY - 15

	cabeca = display.newImage(sceneGroup, spritesPersonagem, 1)
	cabeca.x = 130
	cabeca.y = display.contentCenterY - 40

	fisica.addBody(pernas, "dynamic", {bounce = 0.5});
	fisica.addBody(torax, "dynamic",  {bounce = 0.5});
	fisica.addBody(bracos, "dynamic", {bounce = 0.75});
	fisica.addBody(cabeca, "dynamic", {bounce = 0.5});
	pernas.isFixedRotation = true;

	local joint = fisica.newJoint("piston", pernas, torax, pernas.x, pernas.y, 0, -1)
	local joint2 = fisica.newJoint("piston", torax, bracos, torax.x, torax.y, 0, -1)
	local joint3 = fisica.newJoint("piston", torax, cabeca, torax.x, torax.y, 0, -1)

	joint.isLimitEnabled = true
	joint:setLimits( -10, 5 )

	joint2.isLimitEnabled = true
	joint2:setLimits( -20, 0 )

	joint3.isLimitEnabled = true
	joint3:setLimits( -20, -2 )

	playerCollisionFront = display.newRect(sceneGroup, pernas.x + 90, pernas.y - 15, 2, 70);
	playerCollisionFront.anchorX = 0
	playerCollisionFront.anchorY = 1
	playerCollisionFront.alpha = 0

	fisica.addBody(playerCollisionFront, "kinematic")
	playerCollisionFront.name = "playerCollisionFront"
	playerCollisionFront.isFixedRotation = true;


	Runtime:addEventListener("tap", atirar)

end

-- Variáveis das funções

local noChao = true;
local escorregando = false;

function mudaPosicaoCollision()
	playerCollisionFront.y = pernas.y - 15;
end

timer.performWithDelay(1, mudaPosicaoCollision, 0)

function quedaPlayer()
	pernas:applyForce( 0, 12, pernas.x, pernas.y )
end

function escorrega()
	if(noChao == true and escorregando == false) then
		escorregando = true;
		changeSizeColission(45)
		timer.performWithDelay(800, corre, 1);
		print("escorrega!")
	end
end

function corre()
	escorregando = false;

	-- if( player.sequence == "escorregando" ) then
	-- 	player:setSequence("correndo");
	-- 	player:play();
	-- 	print("corre!")
	-- else
	-- 	print("pulo-escorrega")
	-- end
end

function pula()

	if(noChao == true and
		pernas.y <= alturaTela - 30) then

		noChao = false;
    	
    	pernas:pause()

		pernas:applyForce( 0, -8, pernas.x, pernas.y )
		torax:applyForce( 0, -4, torax.x, torax.y )
		cabeca:applyForce( 0, -2, cabeca.x, cabeca.y )

		timer.performWithDelay(450, quedaPlayer, 1);
		print("pula!")
	end
end

--Runtime:addEventListener("touch", pula);

-- local function spriteListener( event )

--     if(event.phase == "began") then
--     	if(event.target.sequence == "correndo") then

-- 			changeSizeColission(65)

--     	elseif (event.target.sequence == "pulando") then

-- 			changeSizeColission(100)
			
--     	end
--    	end
-- end

-- player:addEventListener("sprite", spriteListener)

-- Um décimo da tela
local medicaoReferencia = alturaTela * 0.1;
local yInicio, yFim, yRazao;
local xSwipe;

local function swipe(event)

    if ( event.phase == "began" ) then
        
		yInicio = event.y
		xSwipe = event.x
        
    elseif ( event.phase == "moved" and xSwipe < display.contentCenterX ) then

        yFim = event.y
        yRazao = yInicio - yFim;

        if (math.abs(yRazao) > medicaoReferencia) then
	        if (yRazao < 0) then
	        	escorrega()
	        else
	        	pula()
	        end
	    end
    end

    return true
end

Runtime:addEventListener("touch", swipe)

function colisaoPlataforma(event)
	if(event.phase == "began") then
        if(event.object1.parent.name == "plataforma" and
		   event.object2.name == "pernas" and noChao == false) then

			noChao = true;
		    		
			pernas:setSequence( "correndo" )
		    pernas:play()
    
			print("encosta")
		end
	end

end

Runtime:addEventListener("collision", colisaoPlataforma);

function colisaoObstaculo(event)
	if(event.phase == "began") then
        if(event.object1.parent.name == "obstaculo" and
		   event.object2.name == "playerCollisionFront") then
			print("colidiu com obstaculo")
		end
	end
end

Runtime:addEventListener("collision", colisaoObstaculo);

function changeSizeColission(size)
	fisica.removeBody(playerCollisionFront)
	playerCollisionFront.height = size
	fisica.addBody(playerCollisionFront, "kinematic")
end

function Player.removeListeners()
	Runtime:removeEventListener( "tap", atirar )
end

return Player;