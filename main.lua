display.setStatusBar(display.HiddenStatusBar)
math.randomseed(os.time())

local fisica = require("physics");
-- fisica.setDrawMode("hybrid");

local composer = require("composer")

-- var globais do jogo
fontDialog = native.newFont("fonts/DTMSans.ttf")
fontTitle = native.newFont("fonts/3Dventure.ttf")
altura = display.contentHeight
largura = display.contentWidth
larguraAtual = display.actualContentWidth
alturaAtual = display.actualContentHeight
centerX = display.contentCenterX
centerY = display.contentCenterY

composer.gotoScene("scenes.cutscene1", "fade", 1000)
-- composer.gotoScene("scenes.menu", "fade", 1000)
-- composer.gotoScene("scenes.game", "fade", 1000)