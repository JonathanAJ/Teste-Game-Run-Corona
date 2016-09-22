local fisica = require("physics");

local Player = {}

local shape = { -30, -10, 30, -10, 30, 62, -30, 62 }

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

function Player.load()
	local spritesPersonagem = graphics.newImageSheet("assets/sprite_sheet.png", confSprites);
	local player = display.newSprite(spritesPersonagem, animacoesPersonagem);

	player.anchorX = 0;
	player.anchorY = 0;

	player:setSequence("correndo");
	player:play();

	fisica.addBody(player, {shape = shape, bounce = 0});
end

return Player;