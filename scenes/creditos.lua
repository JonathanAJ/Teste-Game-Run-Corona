display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require( "composer" )

local scene = composer.newScene()

local function gotoMenu(event)
    event.target:setFillColor( 1, 1, 1)
    composer.gotoScene( "scenes.menu", "fade", 300 )
end

local background

-- create()
function scene:create( event )

	local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    initSounds()
    
    background = require("controller.BackgroundController");
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        background.load(sceneGroup, {name = "creditos"})
        background.start()
        audio.play(scene.sounds.sceneCreditSound, { loops = -1, channel = 3 })

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        initTextCred(sceneGroup)
        
    end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        audio.stop()        
        background.stop()

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen  
        composer.removeScene("scenes.creditos")
    end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end

function initSounds()
    scene.sounds = {
        sceneCreditSound = audio.loadSound("audio/loop/finalle.ogg"),
    }
end

function initTextCred(sceneGroup)

    local txt1 = 
    {
        parent = sceneGroup,
        text = "Ianna Leal",     
        x = 350,
        y = 150,
        width = 300,
        font = fontDialog,
        fontSize = 27,
        align = "left"
    }
     local txt2 = 
    {
        parent = sceneGroup,
        text = "Italo Oliveira",     
        x = 350,
        y = 220,
        width = 300,
        font = fontDialog,
        fontSize = 27,
        align = "left"
    }
     local txt3 = 
    {
        parent = sceneGroup,
        text = "Jonathan Alves",     
        x = 350,
        y = 290,
        width = 300,
        font = fontDialog,
        fontSize = 27,
        align = "left"
    }
    
    local cred = display.newText( sceneGroup, "ABOUT", display.contentCenterX, 55, fontTitle, 40 )
    cred:setFillColor( 0, 0, 0 )

    local ianna = display.newImageRect( sceneGroup, "assets/char/ianna.png", 50, 60 )
    ianna.x = 150
    ianna.y = 150

    local iannatxt = display.newText(txt1)
    iannatxt:setFillColor( 0, 0, 0 )

    local italo = display.newImageRect( sceneGroup, "assets/char/italo.png", 65, 70 )
    italo.x = 150
    italo.y = 220

    local italoTxt = display.newText(txt2)
    italoTxt:setFillColor( 0, 0, 0 )

    local jon = display.newImageRect( sceneGroup, "assets/char/jon.png", 65, 70 )
    jon.x = 150
    jon.y = 290

    local jonTxt = display.newText(txt3)
    jonTxt:setFillColor( 0, 0, 0 )

    local returnButton = display.newText( sceneGroup, "<<<", 200, 150, fontTitle, 40 )
    returnButton.x = 50
    returnButton.y = 340

    returnButton:addEventListener( "tap", gotoMenu )

    transition.from( cred, { xScale = 2.5, yScale = 2.5, time = 440, transition = easing.outQuad } )
    transition.from( ianna, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( italo, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( jon, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( iannatxt, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( italoTxt, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( jonTxt, { y = altura, time = 540, transition = easing.outQuad } )
    transition.from( returnButton, { x = largura, time = 540, transition = easing.outQuad } )
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
