local fisica = require("physics");
fisica.start(true);
-- fisica.setDrawMode("hybrid");

local background = require("controller.BackgroundController");
background.load();

local plataforma = require("controller.PlataformaController");
plataforma.load();

local player = require("controller.PlayerController");
player.load();