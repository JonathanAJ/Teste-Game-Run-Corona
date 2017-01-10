
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
    composer.gotoScene("scenes.menu")
end

-- Hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    local background = require("controller.BackgroundCreditosController");
    background.load(sceneGroup);

    local cred = display.newText( sceneGroup, "Creditos", display.contentCenterX, 55, "3Dventure.ttf", 40 )
    cred:setFillColor( 0, 0, 0 )

    local caia = display.newImageRect( sceneGroup, "assets/char/caia.png", 65, 70 )
    caia.x = 120
    caia.y = 150

    local menber1 = display.newText( sceneGroup, "Caia", 200, 150, "3Dventure.ttf", 40 )
    menber1:setFillColor( 0, 0, 0 )

    local ianna = display.newImageRect( sceneGroup, "assets/char/ianna.png", 50, 60 )
    ianna.x = 120
    ianna.y = 210

    local menber2 = display.newText( sceneGroup, "Ianna", 210, 210, "3Dventure.ttf", 40 )
    menber2:setFillColor( 0, 0, 0 )

    local italo = display.newImageRect( sceneGroup, "assets/char/italo.png", 65, 70 )
    italo.x = 370
    italo.y = 150

    local menber3 = display.newText( sceneGroup, "Italo", 470, 150, "3Dventure.ttf", 40 )
    menber3:setFillColor( 0, 0, 0 )

    local jon = display.newImageRect( sceneGroup, "assets/char/jon.png", 65, 70 )
    jon.x = 370
    jon.y = 210

    local menber4 = display.newText( sceneGroup, "Jonathan", 500, 210, "3Dventure.ttf", 40 )
    menber4:setFillColor( 0, 0, 0 )

    local returnButton = display.newText( sceneGroup, "<<<", 200, 150, "3Dventure.ttf", 40 )
    returnButton.x = 50
    returnButton.y = 340

    returnButton:addEventListener( "tap", gotoMenu )

    local soundEffect = audio.loadSound( "audio/credits5.wav" )
    -- audio.play( soundEffect )

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
        

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
       
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
