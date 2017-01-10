local Background = {}

local tableParallax = {}

function Background.load(sceneGroup)

	local alturaTela = display.contentHeight;
	local larguraTela = display.contentWidth;

	local scale = 0.5;
	local stageWidth = 3240 * scale;
	local stageHeigth = 720 * scale;

	local velocidade = 1

	local ceu = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, larguraTela, alturaTela);
	ceu:setFillColor(0.2, 0.8, 0.8)

	local clouds1 = display.newImageRect("assets/backgroundLevel1/clouds.png", stageWidth, stageHeigth);
	local clouds2 = display.newImageRect("assets/backgroundLevel1/clouds.png", stageWidth, stageHeigth);

	local mount1 = display.newImageRect("assets/backgroundLevel1/mount.png", stageWidth, stageHeigth);
	mount1.y = 100

	local mount2 = display.newImageRect("assets/backgroundLevel1/mount.png", stageWidth, stageHeigth);
	mount2.y = 100

	local vulcan1 = display.newImageRect("assets/backgroundLevel1/vulcan.png", stageWidth, stageHeigth);
	vulcan1.y = 100

	local vulcan2 = display.newImageRect("assets/backgroundLevel1/vulcan.png", stageWidth, stageHeigth);
	vulcan2.y = 100

	local ground1 = display.newImageRect("assets/backgroundLevel1/ground.png", stageWidth, stageHeigth);
	ground1.y = 50

	local ground2 = display.newImageRect("assets/backgroundLevel1/ground.png", stageWidth, stageHeigth);
	ground2.y = 50

	local tree_back1 = display.newImageRect("assets/backgroundLevel1/tree-back.png", stageWidth, stageHeigth);
	tree_back1.y = 50

	local tree_back2 = display.newImageRect("assets/backgroundLevel1/tree-back.png", stageWidth, stageHeigth);
	tree_back2.y = 50

	local tree_front1 = display.newImageRect("assets/backgroundLevel1/tree-front.png", stageWidth, stageHeigth);
	tree_front1.y = 50
	
	local tree_front2 = display.newImageRect("assets/backgroundLevel1/tree-front.png", stageWidth, stageHeigth);
	tree_front2.y = 50

	local tour1 = display.newImageRect("assets/backgroundLevel1/tour.png", stageWidth, stageHeigth);
	tour1.y = 100

	local tour2 = display.newImageRect("assets/backgroundLevel1/tour.png", stageWidth, stageHeigth);
	tour2.y = 100

	table.insert(tableParallax, clouds1)
	table.insert(tableParallax, clouds2)
	table.insert(tableParallax, vulcan1)
	table.insert(tableParallax, vulcan2)
	table.insert(tableParallax, tour1)
	table.insert(tableParallax, tour2)
	table.insert(tableParallax, mount1)
	table.insert(tableParallax, mount2)
	table.insert(tableParallax, tree_back1)
	table.insert(tableParallax, tree_back2)
	table.insert(tableParallax, tree_front1)
	table.insert(tableParallax, tree_front2)
	table.insert(tableParallax, ground1)
	table.insert(tableParallax, ground2)

	print("NumTable "..table.maxn(tableParallax))

	for i = 1, #tableParallax, 2 do

		print("index"..i)

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

	local runtime = 0
 
	function getDeltaTime()
	    local temp = system.getTimer()
	    local dt = (temp - runtime) / (1000 / 30)
	    runtime = temp
	    return dt
	end

	function move()
		local dt = getDeltaTime();

		-- print("enter frame game "..dt);

		for i = 1, #tableParallax, 2 do

			local image1 = tableParallax[i]
			local image2 = tableParallax[i+1]

			translateImages(image1, image2, i, dt)
			verificaImages(image1, image2);
		end

	end

	function translateImages(image1, image2, pos, dt)

		local moviment = ((pos * -1) * velocidade) * 1;

		image1:translate(moviment, 0)
		image2:translate(moviment, 0)
	end

	function verificaImages(image1, image2)
		if(image1.x <= -(image1.width)) then
			image1.x = image2.x + image2.width;
		elseif(image2.x <= -(image2.width)) then
			image2.x = image1.x + image1.width;
		end
	end
end

function Background.start()
	Runtime:addEventListener("enterFrame", move)
end

function Background.stop()
	
	for i = #tableParallax, 1,-1 do
	    table.remove(tableParallax, i)
	end

	print("NumTableEmpty "..table.maxn(tableParallax))

	Runtime:removeEventListener("enterFrame", move)
end

return Background;