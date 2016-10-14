local fisica = require("physics");
fisica.start(true);
-- fisica.setDrawMode("hybrid");

local background = require("controller.BackgroundController");
background.load();

local plataforma = require("controller.PlataformaController");
plataforma.load();

local player = require("controller.PlayerController");
player.load();

local fps = display.newText("FPS: "..display.fps, 40, 10, native.systemFont, 18)

function printFPS()
	fps.text = "FPS: "..display.fps
	fps:setFillColor(255, 0, 0)
end

Runtime:addEventListener("enterFrame", printFPS)