local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Plataforma = {}

local shape = { -128, 0, 0, 0, 0, 128, -128, 128 }

local plataformas = {}

function Plataforma.load()

	criaColisor();

	local nChao = larguraTela/128;

	for i = 0, nChao do
		plataformas[i] = display.newImage("assets/plataforma.png");
		plataformas[i].anchorX = 0;
		plataformas[i].anchorY = 1;

		plataformas[i].x = i * 128;
		plataformas[i].y = alturaTela

		plataformas[i]:scale(0.5, 0.5);
	end

end

function criaColisor()
	local x = display.contentCenterX;
	local y = alturaTela - 123;
	local w = larguraTela;
	local h = 10;
	local colisorPlataforma = display.newRect(x, y, w, h);
	colisorPlataforma.alpha = 0;
	fisica.addBody(colisorPlataforma, "static", {bounde = 0});
end

function move(event)
	for i = 0, #plataformas do

		local this = plataformas[i];

		plataformas[i]:translate(this.x-10, 0);
	end
end

timer.performWithDelay( 500, move, 0 )

return Plataforma;