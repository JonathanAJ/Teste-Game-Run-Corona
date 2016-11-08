
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

    local background = display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight)
    background:setFillColor(0, 255, 255)

    local claName = display.newImageRect( sceneGroup, "./Icon.png", 130, 150 )
    claName.x = display.contentCenterX
    claName.y = 100

    local gameName = display.newText( sceneGroup, "Run N'Gun", display.contentCenterX, 200, native.systemFont, 30 )
    gameName:setFillColor( 0, 0, 0 )

    -- Equipe
    local menber1 = display.newText( sceneGroup, "Caiã Augusto", display.contentCenterX, 240, native.systemFont, 20 )
    menber1:setFillColor( 1, 1, 1 )

    local menber2 = display.newText( sceneGroup, "Ianna Leal", display.contentCenterX, 260, native.systemFont, 20 )
    menber2:setFillColor( 1, 1, 1 )

    local menber3 = display.newText( sceneGroup, "Italo Oliveira", display.contentCenterX, 280, native.systemFont, 20 )
    menber3:setFillColor( 1, 1, 1 )

    local menber4 = display.newText( sceneGroup, "Jonathan Alves", display.contentCenterX, 300, native.systemFont, 20 )
    menber4:setFillColor( 1, 1, 1 )

    local returnButton = display.newImageRect( sceneGroup, "./assets/icons/home.png", 32, 32 )
    returnButton.x = display.contentCenterX
    returnButton.y = 340

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
