
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------

local function gotoCutscene()
	composer.gotoScene( "scenes.game", "fade", 1000 )
end

local function gotoCreditos()
	composer.gotoScene( "scenes.creditos", "fade", 200 )
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local background = require("controller.BackgroundMenuController");
    background.load(sceneGroup);

    local logoName = display.newImageRect( sceneGroup, "assets/logoname.png", 157, 106 )
    logoName.x = display.contentCenterX
    logoName.y = display.contentCenterY-50

    local playButton = display.newText( sceneGroup, "Jogar", display.contentCenterX, 250, "3Dventure.ttf", 40 )
    playButton:setFillColor( 1, 1, 1 )

    local creditosButton = display.newText( sceneGroup, "Creditos", display.contentCenterX, 300, "3Dventure.ttf", 40 )
    creditosButton:setFillColor( 1, 1, 1 )

    playButton:addEventListener( "tap", gotoCutscene )
    creditosButton:addEventListener( "tap", gotoCreditos )

    local soundEffect = audio.loadSound( "audio/chiptune-loop.wav" )
    audio.play( soundEffect )

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
