display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

function scene:create( event )
    print("create preGame")

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        print("show will preGame")
        composer.gotoScene( "scenes.game", "fade", 200 )

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("show did preGame")
        
    end
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )

return scene