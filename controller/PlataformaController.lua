local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Plataforma = {}

local shape = { -128, 0, 0, 0, 0, 128, -128, 128 }

local gpBlocos = display.newGroup()
gpBlocos.name = "plataforma"

-- Define a quantidade de plataformas para uma tela
local nChao = 6

function Plataforma.load()

	-- Cria e popula os colisores das plataformas

	for i = 0, nChao do
		local novoBloco = display.newImage(gpBlocos, "assets/plataforma.png");
		novoBloco.anchorX = 0;
		novoBloco.anchorY = 1;

		novoBloco.x = i * (128);
		novoBloco.y = alturaTela + 96;

		novoBloco:scale(0.5, 0.5);

		fisica.addBody(novoBloco, "static", {shape = shape});
		novoBloco.name = "plataforma"..i + 1;
		novoBloco.id = i + 1;
		gpBlocos:insert(novoBloco);
	end

	criaObstaculos()
end

function criaObstaculos()
	local gpObstaculos = display.newGroup()
	gpObstaculos.name = "obstaculo"
end

function update()
	movePlataforma()
end

function movePlataforma(event)
	local num = gpBlocos.numChildren;
	local novoX;

	local velocidade = 1

	for i = 1, num do

		if(i > 1) then
			novoX = (gpBlocos[i - 1]).x + 128
		else
			novoX = (gpBlocos[nChao + 1]).x + 118
		end

		if((gpBlocos[i]).x <= -128) then
			(gpBlocos[i]).x = novoX
		else
			(gpBlocos[i]):translate(-10, 0)
		end
	end
end

timer.performWithDelay(1, update, 0)

return Plataforma;