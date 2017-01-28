display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local fisica = require("physics");
fisica.start(true);
fisica.setDrawMode("hybrid");

local function endGame()
    composer.gotoScene( "scenes.menu", { time = 800, effect = "crossFade" } )
end

local function gotoMenu(event)
    event.target:setFillColor( 0, 0, 0)
    composer.gotoScene( "scenes.menu", { time = 200, effect = "crossFade" } )
end

function scene:create( event )

    print("enter create game")

    local sceneGroup = self.view

    background = require("controller.BackgroundController");
    plataforma = require("controller.PlataformaController");
    player = require("controller.PlayerController");
    inimigo = require "controller.InimigoController"
end

function scene:show( event )

	local sceneGroup = self.view
    local phase = event.phase

    -- Code here runs when the scene is still off screen (but is about to come on screen)
    if ( phase == "will" ) then
        background.load(sceneGroup)
        background.start()
        plataforma.load(sceneGroup)
        player.load(sceneGroup)
        inimigo.load(sceneGroup)
        initHUD(sceneGroup)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end

function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        
        background.stop()
        player.removeListeners()
        inimigo.pauseTimer()
        player.pauseTimer()
        fisica.stop(true)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        --Runtime:removeEventListener( "collision", onCollision )
        composer.removeScene("scenes.game")
    end
end

function scene:destroy( event )

	local sceneGroup = self.view
    print("enter destroy game")

end

function initHUD(sceneGroup)
    local returnButton = display.newText(sceneGroup, "Menu", display.contentWidth - 50, 25, "3Dventure.ttf", 32)
    returnButton:setFillColor( 1, 1, 1)
    returnButton:addEventListener( "tap", gotoMenu )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene