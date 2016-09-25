local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Plataforma = {}

local shape = { -128, 0, 0, 0, 0, 128, -128, 128 }

local plataformas = {}

function Plataforma.load()

--	criaColisor();

	local nChao = larguraTela/128;
	nChao = nChao * 10;

	for i = 0, nChao do
		plataformas[i] = display.newImage("assets/plataforma.png");
		plataformas[i].anchorX = 0;
		plataformas[i].anchorY = 1;

		plataformas[i].x = i * (128);
		--plataformas[i].x = i * (128 * math.random(2));
		plataformas[i].y = alturaTela + 96;

		plataformas[i]:scale(0.5, 0.5);

		fisica.addBody(plataformas[i], "static", {shape = shape, bounce = 0});
		plataformas[i].name = "plataforma";
	end

end

function move(event)
	local num = #plataformas;
	local metade = num * 0.5;
	for i = 0, num do

		local this = plataformas[i];
		this.x = this.x - 10;

	end
end

timer.performWithDelay(1, move, 0 )

return Plataforma;