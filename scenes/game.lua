display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local background;

local fisica = require("physics");
fisica.start(true);
-- fisica.setDrawMode("hybrid");

local function endGame()
    composer.gotoScene( "scenes.menu", { time=800, effect="crossFade" } )
end

local function gotoMenu()
    composer.gotoScene( "scenes.menu", { time=800, effect="crossFade" } )
end

-- create()
function scene:create( event )

    print("enter create game")

    local sceneGroup = self.view

    background = require("controller.BackgroundController");
    background.load(sceneGroup);
    background.start();

    local plataforma = require("controller.PlataformaController");
    plataforma.load(sceneGroup);

    local player = require("controller.PlayerController");
    player.load(sceneGroup);
	
    local returnButton = display.newText(sceneGroup, "Menu", display.contentWidth - 50, 25, "3Dventure.ttf", 32)
    returnButton:setFillColor( 0, 0, 0)
    returnButton:addEventListener( "tap", gotoMenu )
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        
        background.stop()
        composer.removeScene("scenes.game")
        fisica.stop()

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        --Runtime:removeEventListener( "collision", onCollision )
    end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

    print("enter destroy game")

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene