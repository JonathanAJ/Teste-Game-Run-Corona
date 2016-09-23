local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local shape = { -5, -10, 32, -10, 32, 62, -5, 62 }

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
		time = 1000
	},
	{
		name = "escorregando",
    	frames= { 14, 15, 16},
		time = 1000
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

	fisica.addBody(player, "dynamic", {shape = shape, bounce = 0, density = 2});
	player.name = "player";
	player.isFixedRotation = true;
end

local noChao = true;

function pula(event)

	if(event.phase == "began" and
		noChao == true and
		player.y <= alturaTela - 30) then
		
		print("pula")
		noChao = false;
		player:applyForce(0, -1500);

		timer.performWithDelay(250, quedaPlayer, 1);
	end
end

function quedaPlayer()
	player:applyForce(0, 1400);
end

Runtime:addEventListener("touch", pula);

function colisaoPlataforma(event)
	if(event.phase == "began") then
        if(event.object1.name == "plataforma" and
		   event.object2.name == "player") then
			noChao = true;
		end
	end

end

Runtime:addEventListener("collision", colisaoPlataforma);

return Player;