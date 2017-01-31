display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local background

local function gotoCutscene2()
	composer.gotoScene( "scenes.cutscene2", "slideLeft", 200 )
end

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    initSounds()

    background = require("controller.BackgroundController");
    background.load(sceneGroup, {name = "cutscene", r = 0.5, g = 0, b = 0.6});
    background.start();

    initDialog(sceneGroup)

end

-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
    	audio.play(scene.sounds.sceneDialogSound, { loops = -1, channel = 4 })
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
      initText(sceneGroup)

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- roda assim que a cena for ocultada	
	    --audio.stop()
    background.stop()
		composer.removeScene("scenes.cutscene1")
	elseif ( phase == "did" ) then
		-- roda depois que a cena for ocultada

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view

	print("enter destroy menu")

end

function initDialog(sceneGroup)
  
  local dialog = display.newRoundedRect( sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth-50 , display.contentHeight-80, 40 )
  dialog.strokeWidth = 2
  dialog:setFillColor( 1 )
  dialog:setStrokeColor( 0, 0, 0 )
  dialog.alpha = 0.75

  local ianna = display.newImageRect( sceneGroup, "assets/char/ianna.png", 50, 60 )
  ianna.x = 65
  ianna.y = 75

  local member = display.newText( sceneGroup, "Dr. Ianna:", 210, 75, fontTitle, 40 )
  member:setFillColor( 1, 0.3, 0.8 )

  local skip = display.newText( sceneGroup, ">>>", 575, 300, fontTitle, 40 )
  skip:setFillColor( 0, 0, 0 )

  transition.from( ianna, { xScale = 3, yScale = 3, time = 440, transition = easing.outQuad } )
  transition.from( member, { y = altura, time = 540, transition = easing.outQuad } )
  transition.from( skip, { y = 100, time = 540, transition = easing.outQuad } )

  skip:addEventListener( "touch", gotoCutscene2 )
end

function initText(sceneGroup)
  local myText = "Hello, if you are seeing this message,then our plans have worked well and you have been able to travel through time, now the future is in your hands, we need you to defeat the dictator of the Temporal Empire [...]"

  local options = {
     parent = sceneGroup,
     text = myText,
     x = display.contentCenterX,
     y = display.contentCenterY + 20,
     width = 450,
     font = fontDialog,
     fontSize = 25,
     align = "justify"
  }

  local history = display.newText( options )
  history:setFillColor( 0, 0, 0 )

  transition.from( history, { y = altura, time = 540, transition = easing.outQuad } )


 
end

function initSounds()
    scene.sounds = {
        sceneDialogSound = audio.loadSound("audio/loop/dialog.ogg"),
    }
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
