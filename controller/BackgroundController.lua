local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local Background = {}

local bg1 = display.newImage("assets/bg.png");
local bg2 = display.newImage("assets/bg.png");

local nuvem1 = display.newImage("assets/nuvens.png");
local nuvem2 = display.newImage("assets/nuvens.png");

function Background.load()
	bg1.anchorX = 0;
	bg1.anchorY = 1;

	bg2.anchorX = 0;
	bg2.anchorY = 1;

	bg1.y = alturaTela
	bg2.y = alturaTela

	bg2.x = bg1.width;

	nuvem1.anchorX = 0;
	nuvem1.anchorY = 0;

	nuvem2.anchorX = 0;
	nuvem2.anchorY = 0;

	nuvem2.x = nuvem1.width;
end

function move()
	bg1.x = bg1.x - 5;
	bg2.x = bg2.x - 5;

	nuvem1.x = nuvem1.x - 2;
	nuvem2.x = nuvem2.x - 2;

	if(bg1.x <= -(bg1.width)) then
		bg1.x = bg2.x + bg2.width;

	elseif(bg2.x <= -(bg2.width)) then
		bg2.x = bg1.x + bg1.width;

	end

	if(nuvem1.x <= -(nuvem1.width)) then
		nuvem1.x = nuvem2.x + nuvem2.width;

	elseif(nuvem2.x <= -(nuvem2.width)) then
		nuvem2.x = nuvem1.x + nuvem1.width;

	end

end

timer.performWithDelay(1, move, 0);

return Background;