display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local fisica = require("physics");
fisica.start(true);
fisica.setDrawMode("hybrid");

function scene:create( event )

    print("enter create game")

    local sceneGroup = self.view

    background = require("controller.BackgroundController")
    plataforma = require("controller.PlataformaController")
    player = require("controller.PlayerController")
    inimigo = require("controller.InimigoController")
    background.load(sceneGroup)
    background.start()
    plataforma.load(sceneGroup)
end

function scene:show( event )

	local sceneGroup = self.view
    local phase = event.phase

    -- Code here runs when the scene is still off screen (but is about to come on screen)
    if ( phase == "will" ) then
        print("enter show will game")
        player.load(sceneGroup)
        inimigo.load(sceneGroup)
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("enter show did game")

    end
end

function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        print("enter hide will game")
        
        background.stop()
        player.removeListeners()
        inimigo.pauseTimer()
        player.pauseTimer()
        fisica.stop(true)

    elseif ( phase == "did" ) then
        print("enter hide did game")
        -- Code here runs immediately after the scene goes entirely off screen
        --Runtime:removeEventListener( "collision", onCollision )
        composer.removeScene("scenes.game")
    end
end

function scene:destroy( event )

	local sceneGroup = self.view
    print("enter destroy game")

end

function scene:resumeGame()
    background.stop()
    -- player.removeListeners()
    inimigo.pauseTimer()
    player.pauseTimer()
    -- fisica.pause()
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene