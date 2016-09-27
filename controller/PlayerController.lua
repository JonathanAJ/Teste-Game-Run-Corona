local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local shapeCorrendo = { -5, -10, 32, -10, 32, 62, -5, 62 }

local shapePulando = { -5, -30, 32, -30, 32, 62, -5, 62 }

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

function Player.load()

	player.anchorX = 0;
	player.anchorY = 1;

	player.y = alturaTela - 32;

	player:setSequence("correndo");
	player:play();

	fisica.addBody(player, "dynamic", {shape = shapeCorrendo, bounce = 0, density = 10});
	player.name = "player";
	player.isFixedRotation = true;
end

local noChao = true;

function quedaPlayer()
	mudaBody("correndo");
	player:applyForce(0, 5000);
end

function pula(event)

	if(event.phase == "began" and
		noChao == true and
		player.y <= alturaTela - 30) then

		player:setSequence("pulando");
		player:play();
		mudaBody("pulando");

		noChao = false;
		player:applyForce(0, -10000);

		timer.performWithDelay(100, quedaPlayer, 1);
		print("pula")
	end
end

function mudaBody(tipo)
	fisica.removeBody(player);
	if(tipo == "pulando") then
		fisica.addBody(player, "dynamic", {shape = shapePulando, bounce = 0, density = 10});
	
	elseif (tipo == "correndo") then
		fisica.addBody(player, "dynamic", {shape = shapeCorrendo, bounce = 0, density = 10});

	end
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