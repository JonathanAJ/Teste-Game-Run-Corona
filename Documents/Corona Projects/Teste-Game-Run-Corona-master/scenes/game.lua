display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

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

    local sceneGroup = self.view

    local background = require("controller.BackgroundController");
    background.load(sceneGroup);

    local plataforma = require("controller.PlataformaController");
    plataforma.load(sceneGroup);

    local player = require("controller.PlayerController");
    player.load(sceneGroup);
	
    local returnButton = display.newText(sceneGroup, "Menu", display.contentWidth - 50, 25, native.systemFont, 22)
    returnButton:setFillColor( 255, 0, 0)
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
        physics.start()
       -- Runtime:addEventListener( "collision", onCollision )
        gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        --timer.cancel( gameLoopTimer )

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        --Runtime:removeEventListener( "collision", onCollision )
         physics.pause()
    end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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