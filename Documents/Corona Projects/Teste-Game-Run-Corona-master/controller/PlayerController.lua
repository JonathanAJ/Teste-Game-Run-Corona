local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local confSprites = {
	width = 128,
	height = 128,
	numFrames = 4
}

local spritesPersonagem = graphics.newImageSheet("assets/spritesheet.png", confSprites);

local shapePernas = {
					  -20, 35, -- left-top
					   25, 35, -- rigth-top
					   25, 65, -- rigth-bottom
					  -20, 65  -- left-bottom
					}

local shapeTorax = {
					  -5, 15, -- left-top
					   35, 15, -- rigth-top
					   35, 45, -- rigth-bottom
					  -5, 45  -- left-bottom
					}

local shapeBracos = {
					  -10, 15, -- left-top
					   40, 15, -- rigth-top
					   40, 25, -- rigth-bottom
					  -10, 25  -- left-bottom
					}

local shapeCabeca = {
					  -10, -20, -- left-top
					   20, -20, -- rigth-top
					   20, 10, -- rigth-bottom
					  -10, 10  -- left-bottom
					}
local pernas
local torax
local cabeca
local bracos
local playerCollisionFront

function Player.load(sceneGroup)

	pernas = display.newImageRect(sceneGroup, spritesPersonagem, 3, 128, 128)
	pernas.x = display.contentCenterX
	pernas.y = display.contentCenterY
	pernas.name = "pernas"

	torax = display.newImageRect(sceneGroup, spritesPersonagem, 4, 128, 128)
	torax.x = display.contentCenterX - 10
	torax.y = display.contentCenterY - 10

	cabeca = display.newImageRect(sceneGroup, spritesPersonagem, 1, 128, 128)
	cabeca.x = display.contentCenterX 
	cabeca.y = display.contentCenterY - 5

	bracos = display.newImageRect(sceneGroup, spritesPersonagem, 2, 128, 128)
	bracos.x = display.contentCenterX - 10
	bracos.y = display.contentCenterY - 10

	fisica.addBody(pernas, "dynamic", {shape = shapePernas, bounce = 0.5});
	fisica.addBody(torax, "dynamic", {shape = shapeTorax, bounce = 0.5});
	fisica.addBody(bracos, "dynamic", {shape = shapeBracos, bounce = 0.75});
	fisica.addBody(cabeca, "dynamic", {shape = shapeCabeca, bounce = 0.5});
	pernas.isFixedRotation = true;

	local joint = fisica.newJoint("piston", pernas, torax, pernas.x, pernas.y, 0, -1)
	local joint2 = fisica.newJoint("piston", torax, bracos, torax.x, torax.y, 0, -1)
	local joint3 = fisica.newJoint("piston", torax, cabeca, torax.x, torax.y, 0, -1)

	joint.isLimitEnabled = true
	joint:setLimits( -10, -5 )

	joint2.isLimitEnabled = true
	joint2:setLimits( -15, -5 )

	joint3.isLimitEnabled = true
	joint3:setLimits( -5, -2 )

	playerCollisionFront = display.newRect(sceneGroup, pernas.x + 90, pernas.y - 15, 2, 70);
	playerCollisionFront.anchorX = 0
	playerCollisionFront.anchorY = 1
	playerCollisionFront.alpha = 0

	fisica.addBody(playerCollisionFront, "kinematic")
	playerCollisionFront.name = "playerCollisionFront"
	playerCollisionFront.isFixedRotation = true;

end

-- Variáveis das funções

local noChao = true;
local escorregando = false;

function mudaPosicaoCollision()
	playerCollisionFront.y = pernas.y - 15;
end

timer.performWithDelay(1, mudaPosicaoCollision, 0)

function quedaPlayer()
	-- pernas:setLinearVelocity(0, 180);
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

		pernas:applyForce( 0, -6, pernas.x, pernas.y )
		torax:applyForce( 0, -4, torax.x, torax.y )
		cabeca:applyForce( 0, -2, cabeca.x, cabeca.y )

		timer.performWithDelay(380, quedaPlayer, 1);
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

local function swipe(event)

    if ( event.phase == "began" ) then
        
		yInicio = event.y
        
    elseif ( event.phase == "moved" ) then

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

return Player;