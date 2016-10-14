local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local shapePlayerChao = { -32, 55, 25, 55, 25, 62, -32, 62 }

local confSprites = {
	width = 128,
	height = 128,
	numFrames = 16
}



local animacoesPersonagem = {
	{
		name = "correndo",
    	frames= { 1, 2, 3, 4, 5, 6, 7, 8, 9},
		time = 500
	},
	{
		name = "pulando",
    	frames= { 10, 11, 12, 13},
        loopCount = 1,
		time = 250
	},
	{
		name = "escorregando",
    	frames= { 14, 15, 16},
        loopCount = 1,
		time = 800
	}
}

local spritesPersonagem = graphics.newImageSheet("assets/sprite_sheet.png", confSprites);
local player = display.newSprite(spritesPersonagem, animacoesPersonagem);

local playerCollisionFront;

function Player.load()

	player.anchorX = 0;
	player.anchorY = 1;

	player.y = alturaTela - 32;

	player:setSequence("correndo");
	player:play();

	fisica.addBody(player, "dynamic", {shape = shapePlayerChao, bounce = 0, density = 10});
	player.name = "player";
	player.isFixedRotation = true;

	playerCollisionFront = display.newRect(player.x + 90, player.y - 15, 2, 70);
	playerCollisionFront.anchorX = 0
	playerCollisionFront.anchorY = 1
	playerCollisionFront.alpha = 0

	fisica.addBody(playerCollisionFront, "kinematic")

end

-- Variáveis das funções

local noChao = true;
local escorregando = false;

function mudaPosicaoCollision()
	playerCollisionFront.y = player.y - 15;
end

timer.performWithDelay(1, mudaPosicaoCollision, 0)

function quedaPlayer()
	player:setLinearVelocity(0, 180);
end

function escorrega()
	if(noChao == true and escorregando == false) then
		escorregando = true;
		changeSizeColission(45)
		player:setSequence("escorregando");
		player:play();
		timer.performWithDelay(800, corre, 1);
		print("escorrega!")
	end
end

function corre()
	escorregando = false;

	if( player.sequence == "escorregando" ) then
		player:setSequence("correndo");
		player:play();
		print("corre!")
	else
		print("pulo-escorrega")
	end
end

function pula()

	if(noChao == true and
		player.y <= alturaTela - 30) then

		player:setSequence("pulando");
		player:play();

		noChao = false;
		player:setLinearVelocity(0, -380);

		timer.performWithDelay(380, quedaPlayer, 1);
		print("pula!")
	end
end

--Runtime:addEventListener("touch", pula);

local function spriteListener( event )

    if(event.phase == "began") then
    	if(event.target.sequence == "correndo") then

			changeSizeColission(65)

    	elseif (event.target.sequence == "pulando") then

			changeSizeColission(100)
			
    	end
   	end
end

player:addEventListener("sprite", spriteListener)

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
		   event.object2.name == "player" and noChao == false) then

			noChao = true;

			player:setSequence("correndo");
			player:play();
			print("encosta")
		end
	end

end

Runtime:addEventListener("collision", colisaoPlataforma);

function changeSizeColission(size)
	fisica.removeBody(playerCollisionFront)
	playerCollisionFront.height = size
	fisica.addBody(playerCollisionFront, "kinematic")
end

return Player;