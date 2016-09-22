local fisica = require("physics");
fisica.start();
-- fisica.setDrawMode("hybrid");

local plataforma = require("controller.PlataformaController");
plataforma.load();

local player = require("controller.PlayerController");
player.load();
