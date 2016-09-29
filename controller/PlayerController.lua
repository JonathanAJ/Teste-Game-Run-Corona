local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local shapePlayerChao = { -32, 55, 32, 55, 32, 62, -32, 62 }

local shapeCorrendo = { -5, -10, 32, -10, 32, 62, -5, 62 }

local shapePulando = { -5, -60, 32, -60, 32, 62, -5, 62 }

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
		time = 250
	}
}

local spritesPersonagem = graphics.newImageSheet("assets/sprite_sheet.png", confSprites);
local player = display.newSprite(spritesPersonagem, animacoesPersonagem);

local playerCollisionFront

function Player.load()

	player.anchorX = 0;
	player.anchorY = 1;

	player.y = alturaTela - 32;

	player:setSequence("correndo");
	player:play();

	fisica.addBody(player, "dynamic", {shape = shapePlayerChao, bounce = 0, density = 10});
	player.name = "player";
	player.isFixedRotation = true;

	playerCollisionFront = display.newLine(player.x + 110, player.y, player.x + 110, player.y - 75);
end

function mudaPosicaoCollision()
	print("muda")
	playerCollisionFront.x = player.x + 110;
	playerCollisionFront.y = player.y;
	playerCollisionFront.x2 = player.x + 110;
	playerCollisionFront.x2 = player.y - 75;
end

Runtime:addEventListener("enterFrame", mudaPosicaoCollision)

local noChao = true;

function quedaPlayer()
	player:setLinearVelocity(0, 100);
end

function pula(event)

	if(event.phase == "began" and
		noChao == true and
		player.y <= alturaTela - 30) then

		player:setSequence("pulando");
		player:play();

		noChao = false;
		player:setLinearVelocity(0, -250);

		timer.performWithDelay(300, quedaPlayer, 1);
		print("pula")
	end
end

local function spriteListener( event )
    print( event.name, event.target, event.phase, event.target.sequence )

    if(event.phase == "began") then
    	if(event.target.sequence == "correndo") then

			mudaBody("correndo");
    	elseif (event.target.sequence == "pulando") then

			mudaBody("pulando");
    	end
   	end

end

-- Add sprite listener
--player:addEventListener( "sprite", spriteListener )

function mudaBody(tipo)
	
	fisica.removeBody(player);
	
	local bRes

	if(tipo == "pulando") then
		bRes = fisica.addBody(player, "kinematic", {shape = shapePulando, bounce = 0, density = 10});
	
	elseif (tipo == "correndo") then
		bRes = fisica.addBody(player, "kinematic", {shape = shapeCorrendo, bounce = 0, density = 10});

	end

	print(bRes)

	player.name = "player";
	player.isFixedRotation = true;
end

Runtime:addEventListener("touch", pula);

function colisaoPlataforma(event)
	if(event.phase == "began") then
        if(event.object1.name == "plataforma" and
		   event.object2.name == "player" and noChao == false) then

			noChao = true;
			player:setSequence("correndo");
			player:play();
			print("encosta")
		end
	end

end

Runtime:addEventListener("collision", colisaoPlataforma);

return Player;