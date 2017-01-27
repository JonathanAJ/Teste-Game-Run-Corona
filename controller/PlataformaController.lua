local fisica = require("physics");

local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Plataforma = {}

function Plataforma.load(sceneGroup)

	chao = display.newRect(sceneGroup, 0, 0, larguraTela, 20);
	chao.myName = "plataforma"
	chao.anchorX = 0
	chao.anchorY = 1
	chao.x = 0
	chao.y = alturaTela
	chao:setFillColor(0, 0, 0, 0)
	fisica.addBody(chao, "static", {bounce = 0});

end

return Plataforma;