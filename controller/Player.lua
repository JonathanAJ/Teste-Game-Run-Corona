local Player = {}

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
	local personagem = display.newSprite(spritesPersonagem, animacoesPersonagem);

	personagem.x = 10;
	personagem.y = display.contentHeight/2;

	personagem:setSequence("correndo");
	personagem:play();
end

return Player;