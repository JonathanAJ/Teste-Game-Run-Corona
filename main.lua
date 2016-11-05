local fisica = require("physics");
fisica.start(true);
--fisica.setDrawMode("hybrid");

local background = require("controller.BackgroundController");
background.load();

local plataforma = require("controller.PlataformaController");
plataforma.load();

-- local player = require("controller.PlayerController");
-- player.load();

local confSprites = {
	width = 128,
	height = 128,
	numFrames = 4
}

local spritesPersonagem = graphics.newImageSheet("assets/spritesheet.png", confSprites);

local shapePernas = {
					  -20, 35, -- left-top
					   25, 35, -- rigth-top
					   25, 65, -- rigth-bottom
					  -20, 65  -- left-bottom
					}

local shapeTorax = {
					  -5, 15, -- left-top
					   35, 15, -- rigth-top
					   35, 45, -- rigth-bottom
					  -5, 45  -- left-bottom
					}

local shapeBracos = {
					  -10, 15, -- left-top
					   40, 15, -- rigth-top
					   40, 25, -- rigth-bottom
					  -10, 25  -- left-bottom
					}

local shapeCabeca = {
					  -10, -20, -- left-top
					   20, -20, -- rigth-top
					   20, 10, -- rigth-bottom
					  -10, 10  -- left-bottom
					}

local pernas = display.newImageRect(spritesPersonagem, 3, 128, 128)
pernas.x = display.contentCenterX
pernas.y = display.contentCenterY

local torax = display.newImageRect(spritesPersonagem, 4, 128, 128)
torax.x = display.contentCenterX - 10
torax.y = display.contentCenterY - 10

local cabeca = display.newImageRect(spritesPersonagem, 1, 128, 128)
cabeca.x = display.contentCenterX 
cabeca.y = display.contentCenterY - 5

local bracos = display.newImageRect(spritesPersonagem, 2, 128, 128)
bracos.x = display.contentCenterX - 10
bracos.y = display.contentCenterY - 10

fisica.addBody(pernas, "dynamic", {shape = shapePernas, bounce = 0.5});
fisica.addBody(torax, "dynamic", {shape = shapeTorax, bounce = 0.5});
fisica.addBody(bracos, "dynamic", {shape = shapeBracos, bounce = 0.75});
fisica.addBody(cabeca, "dynamic", {shape = shapeCabeca, bounce = 0.5});
pernas.isFixedRotation = true;

local joint = fisica.newJoint("piston", pernas, torax, pernas.x, pernas.y, 0, -1)
local joint2 = fisica.newJoint("piston", torax, bracos, torax.x, torax.y, 0, -1)
local joint3 = fisica.newJoint("piston", torax, cabeca, torax.x, torax.y, 0, -1)

joint.isLimitEnabled = true
joint:setLimits( -10, -5 )

joint2.isLimitEnabled = true
joint2:setLimits( -15, -5 )

joint3.isLimitEnabled = true
joint3:setLimits( -5, -2 )

local function pula(event)
	pernas:applyForce( 0, -6, pernas.x, pernas.y )
	torax:applyForce( 0, -4, torax.x, torax.y )
	cabeca:applyForce( 0, -2, cabeca.x, cabeca.y )
end

Runtime:addEventListener("tap", pula)