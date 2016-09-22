local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Player = {}

local shape = { -5, -10, 30, -10, 30, 62, -5, 62 }

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

	player.y = alturaTela;


	player:setSequence("correndo");
	player:play();

	fisica.addBody(player, "dynamic", {shape = shape, bounce = 0});
	player.name = "player";
end

local noChao = false;

function pula(event)
	if(noChao == true) then
		print("recebe falso")
		noChao = false;
		player:setLinearVelocity(0, -320);
	end
end

Runtime:addEventListener("tap", pula);


function colisaoPlataforma(event)
	if(event.object1.name == "plataforma" and
	   event.object2.name == "player") then
		noChao = true;
		print("colide")
	end
end

Runtime:addEventListener("collision", colisaoPlataforma);

return Player;