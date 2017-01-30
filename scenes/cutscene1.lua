display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local background;

local soundEffect = audio.loadSound( "audio/cutscene-song.wav" )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------

local function gotoCutscene2()
	composer.gotoScene( "scenes.cutscene2", "slideLeft", 200 )
end

local myText = [[Hello, if you are seeing this message, then our plans have worked well and you have been able to travel through time, now the future is in your hands, we need you to defeat the dictator of the Temporal Empire............]]

local options = {
   text = myText,
   x = display.contentCenterX,
   y = display.contentCenterY,
   width = 550,
   height = 150,
   font = "DTM-Sans",
   fontSize = 25,
   align = "center"
}

local history = display.newText( options )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background1 = require("controller.BackgroundCutscene");
    background1.load(sceneGroup);
    background1.start();

    local dialog = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth-50 , display.contentHeight-80, 40 )
    dialog.strokeWidth = 2
	dialog:setFillColor( 1 )
	dialog:setStrokeColor( 0, 0, 0 )
	dialog.alpha = 0.75

    local ianna = display.newImageRect( sceneGroup, "assets/char/ianna.png", 50, 60 )
    ianna.x = 65
    ianna.y = 75

    local menber = display.newText( sceneGroup, "Ianna:", 160, 75, "3Dventure.ttf", 40 )
    menber:setFillColor( 1, 0.3, 0.8 )
     
	
	history:setFillColor( 0, 0, 0 )

    local skip = display.newText( sceneGroup, ">>>", 575, 300, "3Dventure.ttf", 40 )
    skip:setFillColor( 0, 0, 0 )
    

    skip:addEventListener( "touch", gotoCutscene2 )

    audio.play(soundEffect)


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
		-- roda assim que a cena for ocultada	
	    --audio.stop()		
		composer.removeScene("scenes.cutscene1")
	elseif ( phase == "did" ) then
		-- roda depois que a cena for ocultada

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

	history:removeSelf()


	print("enter destroy menu")

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
