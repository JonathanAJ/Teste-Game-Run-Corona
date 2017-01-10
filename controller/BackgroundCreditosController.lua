local alturaTela = display.contentHeight;
local larguraTela = display.contentWidth;

local scale = 0.5;
local stageWidth = 3240 * scale;
local stageHeigth = 720 * scale;

local velocidade = 0.9

local Background = {}

local ceu = display.newRect(display.contentCenterX, display.contentCenterY, larguraTela, alturaTela);
ceu:setFillColor(0.2, 0.8, 0.8)

local clouds1 = display.newImageRect("assets/backgroundLevel1/clouds.png", stageWidth, stageHeigth);
local clouds2 = display.newImageRect("assets/backgroundLevel1/clouds.png", stageWidth, stageHeigth);

local mount1 = display.newImageRect("assets/backgroundLevel1/mount.png", stageWidth, stageHeigth);
mount1.x = contentWidth
mount1.y = 140

local mount2 = display.newImageRect("assets/backgroundLevel1/mount.png", stageWidth, stageHeigth);
mount2.x = contentWidth
mount2.y = 140

local vulcan1 = display.newImageRect("assets/backgroundLevel1/vulcan.png", stageWidth, stageHeigth);
vulcan1.x = contentWidth
vulcan1.y = 100

local vulcan2 = display.newImageRect("assets/backgroundLevel1/vulcan.png", stageWidth, stageHeigth);
vulcan2.x = contentWidth
vulcan2.y = 100


local tableParallax = {}
table.insert(tableParallax, clouds1)
table.insert(tableParallax, clouds2)
table.insert(tableParallax, vulcan1)
table.insert(tableParallax, vulcan2)
table.insert(tableParallax, mount1)
table.insert(tableParallax, mount2)


function Background.load(sceneGroup)

	sceneGroup:insert(ceu)

	for i = 1, #tableParallax, 2 do

		local image1 = tableParallax[i]
		local image2 = tableParallax[i+1]

		sceneGroup:insert(image1)
		sceneGroup:insert(image2)

		image1.anchorX = 0;
		image1.anchorY = 0;
		image2.anchorX = 0;
		image2.anchorY = 0;
		image2.x = image1.width;
	end
end

function move()

	for i = 1, #tableParallax, 2 do

		local image1 = tableParallax[i]
		local image2 = tableParallax[i+1]

		translateImages(image1, image2, i)
		verificaImages(image1, image2);
	end

end

function translateImages(image1, image2, pos)
	image1:translate((pos*-1)*velocidade, 0)
	image2:translate((pos*-1)*velocidade, 0)
end

function verificaImages(image1, image2)
	if(image1.x <= -(image1.width)) then
		image1.x = image2.x + image2.width;
	elseif(image2.x <= -(image2.width)) then
		image2.x = image1.x + image1.width;
	end
end

timer.performWithDelay(1, move, 0);

return Background;