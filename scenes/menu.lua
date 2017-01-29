display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()
composer.isDebug = true

local fisica = require("physics");

local soundEffect = audio.loadSound( "audio/chiptune-loop.wav" )

local function gotoCutscene(event)
	event.target:setFillColor( 0, 0, 0)
	composer.gotoScene( "scenes.game", "fade", 300 )
end

local function gotoCreditos(event)
	event.target:setFillColor( 0, 0, 0)
	composer.gotoScene( "scenes.creditos", "fade", 200 )
end

function scene:create( event )

	print("enter create menu")

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    background = require("controller.BackgroundController");
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
	    background.load(sceneGroup)
        background.start()
    	initHUD(sceneGroup)
    	audio.play(soundEffect)

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
        background.stop()

	elseif ( phase == "did" ) then
		-- roda depois que a cena for ocultada
		composer.removeScene("scenes.menu")

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	print("enter destroy menu")

end

function initHUD(sceneGroup)
    local logoName = display.newImageRect( sceneGroup, "assets/logoname.png", 157, 106 )
    logoName.x = display.contentCenterX
    logoName.y = display.contentCenterY-50

    local playButton = display.newText( sceneGroup, "PLAY", display.contentCenterX, 250, "3Dventure.ttf", 40 )
    playButton:setFillColor( 1, 1, 1 )

    local creditosButton = display.newText( sceneGroup, "ABOUT", display.contentCenterX, 300, "3Dventure.ttf", 40 )
    creditosButton:setFillColor( 1, 1, 1 )

    playButton:addEventListener( "tap", gotoCutscene )
    creditosButton:addEventListener( "tap", gotoCreditos )
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
