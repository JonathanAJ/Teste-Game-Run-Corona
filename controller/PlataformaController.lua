local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Plataforma = {}

local confPlataformSheet = {
	width = 64,
	height = 64,
	numFrames = 48
}

local plataformaTilesSheet = graphics.newImageSheet("assets/tiles.png", confPlataformSheet)

local gpBlocos = display.newGroup()
gpBlocos.name = "plataforma"

local gpObstaculos = display.newGroup()
gpObstaculos.name = "obstaculo"

-- Define a quantidade de plataformas para uma tela
local nChao = 12

function Plataforma.load()
	-- Cria e popula os colisores das plataformas
	for i = 0, nChao do

		local novoBloco = display.newImage(gpBlocos, plataformaTilesSheet, 34);
		novoBloco.anchorX = 0;
		novoBloco.anchorY = 1;

		novoBloco.x = i * (novoBloco.contentWidth);
		novoBloco.y = alturaTela;

		fisica.addBody(novoBloco, "static", {bounce = 0});
		novoBloco.name = "plataforma"..i + 1;
		novoBloco.id = i + 1;
		gpBlocos:insert(novoBloco);
	end

	-- criaObstaculos()
end

function criaObstaculos()

	for i = 0, 3 do

		local obstaculo = display.newImage(gpObstaculos, plataformaTilesSheet, 2)
		
		obstaculo.anchorX = 0
		obstaculo.anchorY = 1

		obstaculo.x = (i * (64 * 5)) + larguraTela
		
		if math.random(2) == 1 then
			-- vem de baixo
			obstaculo.y = alturaTela - (obstaculo.contentHeight)
		else
			-- vem de cima
			obstaculo.y = alturaTela - (obstaculo.contentHeight * 2)
		end

		fisica.addBody(obstaculo, "dynamic")
		obstaculo.isFixedRotation = true;
		obstaculo.gravityScale = 0
	end
end

function update()
	movePlataforma()
	moveObstaculos()
end

function moveObstaculos()
	local num = gpObstaculos.numChildren
	local novoX;
	
	for i = 1, num do

		if(i > 1) then
			novoX = (gpObstaculos[i - 1]).x + (64 * 5)
		else
			novoX = (gpObstaculos[3 + 1]).x + (54 * 5)
		end

		if((gpObstaculos[i]).x <= -64) then
			(gpObstaculos[i]).x = novoX
		else
			(gpObstaculos[i]):translate(-10, 0)
		end
	end
end

function movePlataforma()
	local num = gpBlocos.numChildren;
	local novoX;

	for i = 1, num do

		if(i > 1) then
			novoX = (gpBlocos[i - 1]).x + 64
		else
			novoX = (gpBlocos[nChao + 1]).x + 54
		end

		if((gpBlocos[i]).x <= -64) then
			(gpBlocos[i]).x = novoX
		else
			(gpBlocos[i]):translate(-10, 0)
		end
	end
end

timer.performWithDelay(1, update, 0)

return Plataforma;