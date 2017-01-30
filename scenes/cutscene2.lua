display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local background;

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- This is a good place to put variables and functions that need to be available scene
-- wide.
-- -----------------------------------------------------------------------------------

local function gotoMenu()
	composer.gotoScene( "scenes.menu", "slideLeft", 200 )
end

local myText2 = [[We do not know what period of time you were sent due to the conditions of the time machine, we hope you can fulfill the mission, now you are our only hope, please Dr. Luter, Run N 'Gun for your life.]]

local optionsText = {
   text = myText2,
   x = display.contentCenterX,
   y = display.contentCenterY,
   width = 540,
   height = 150,
   font = "DTM-Sans",
   fontSize = 25,
   align = "center"
}


local history1 = display.newText( optionsText )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background2 = require("controller.BackgroundCutscene2");
    background2.load(sceneGroup);
    background2.start();

    local dialog2 = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth-50 , display.contentHeight-80, 40 )
    dialog2.strokeWidth = 2
	dialog2:setFillColor( 1 )
	dialog2:setStrokeColor( 0, 0, 0 )
	dialog2.alpha = 0.75

    local italo = display.newImageRect( sceneGroup, "assets/char/italo.png", 50, 60 )
    italo.x = 65
    italo.y = 75

    local menber = display.newText( sceneGroup, "Italo:", 160, 75, "3Dventure.ttf", 40 )
    menber:setFillColor( 0, 0.5, 1 )
     
	
	history1:setFillColor( 0, 0, 0 )



    local skip = display.newText( sceneGroup, ">>>", 575, 300, "3Dventure.ttf", 40 )
    skip:setFillColor( 0, 0, 0 )
    

    skip:addEventListener( "touch", gotoMenu )
    

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
	    audio.stop()		
		composer.removeScene("scenes.cutscene2")


	elseif ( phase == "did" ) then
		-- roda depois que a cena for ocultada

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

	history1:removeSelf()

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
