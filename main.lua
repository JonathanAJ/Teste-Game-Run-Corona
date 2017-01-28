display.setStatusBar(display.HiddenStatusBar)
math.randomseed(os.time())

local composer = require("composer")
-- composer.gotoScene("scenes.cutscene1", "fade", 1000)
composer.gotoScene("scenes.menu", "fade", 1000)