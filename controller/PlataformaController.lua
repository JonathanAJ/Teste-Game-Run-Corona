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

local gpPlataforma = display.newGroup()
gpPlataforma.name = "plataforma"

local gpObstaculos = display.newGroup()
gpObstaculos.name = "obstaculo"

local chao = display.newRect(gpPlataforma, 0, 0, larguraTela, 20);

function Plataforma.load(sceneGroup)

	sceneGroup:insert(gpPlataforma)
	sceneGroup:insert(gpObstaculos)

	chao.anchorX = 0
	chao.anchorY = 1
	chao.x = 0
	chao.y = alturaTela
	chao:setFillColor(0, 0, 0, 0)
	fisica.addBody(chao, "static", {bounce = 0});

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

timer.performWithDelay(1, update, 0)

return Plataforma;