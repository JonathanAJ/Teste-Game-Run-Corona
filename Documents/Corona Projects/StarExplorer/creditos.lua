
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoMenu()
    composer.gotoScene( "menu" )
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

    local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
    title.x = display.contentCenterX
    title.y = 200

    -- Equipe
    local teamName = display.newText( sceneGroup, "DiamondsDev", display.contentCenterX, 300, native.systemFont, 44 )
    teamName:setFillColor( 0, 1, 1 )

    local menber1 = display.newText( sceneGroup, "Caiã Augusto", display.contentCenterX, 400, native.systemFont, 44 )
    menber1:setFillColor( 0, 1, 1 )

    local menber2 = display.newText( sceneGroup, "Ianna Leal", display.contentCenterX, 450, native.systemFont, 44 )
    menber2:setFillColor( 0, 1, 1 )

    local menber3 = display.newText( sceneGroup, "Italo Oliveira", display.contentCenterX, 500, native.systemFont, 44 )
    menber3:setFillColor( 0, 1, 1 )

    local menber4 = display.newText( sceneGroup, "Jonathan Alves", display.contentCenterX, 550, native.systemFont, 44 )
    menber4:setFillColor( 0, 1, 1 )

    --

    local returnButton = display.newText( sceneGroup, "Return", display.contentCenterX, 950, native.systemFont, 44 )
    returnButton:setFillColor( 0.82, 0.86, 1 )

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
