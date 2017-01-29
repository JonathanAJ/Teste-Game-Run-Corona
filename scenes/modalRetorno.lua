local composer = require( "composer" )
 
local scene = composer.newScene()

local alturaTela = display.contentHeight
local larguraTela = display.contentWidth

function scene:create( event )
 
	local sceneGroup = self.view
 
end

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
		local parent = event.parent  --reference to the parent scene object
	    parent:resumeGame()

        local modal = display.newRoundedRect(sceneGroup,
                                             display.contentCenterX,
                                             display.contentCenterY,
                                             300, 250, 7)
        local scoreTxt = display.newText(sceneGroup, "YOUR SCORE",
                                        display.contentCenterX,
                                        display.contentCenterY - 90, "3Dventure.ttf", 40 )

        local score = display.newText(sceneGroup, "11280",
                                        display.contentCenterX,
                                        display.contentCenterY - 30, "3Dventure.ttf", 80 )

        local retornaTxt = display.newText(sceneGroup, "RELOAD",
                                        display.contentCenterX - 65,
                                        display.contentCenterY + 100, "3Dventure.ttf", 20 )

        local menuTxt = display.newText(sceneGroup, "GO MENU",
                                    display.contentCenterX + 65,
                                    display.contentCenterY + 100, "3Dventure.ttf", 20 )

        local imgReload = display.newImageRect(sceneGroup, "assets/icons/ic_play.png", 72, 72)
        imgReload.x = display.contentCenterX - 70
        imgReload.y = display.contentCenterY + 50

        local imgMenu = display.newImageRect( sceneGroup, "assets/icons/ic_menu.png", 72, 72)
        imgMenu.x = display.contentCenterX + 70
        imgMenu.y = display.contentCenterY + 50

        modal:setFillColor(185/255, 205/255, 218/255)
        scoreTxt:setFillColor(22/255, 66/255, 91/255)
        score:setFillColor(8/255, 126/255, 139/255)
        imgReload:setFillColor(43/255, 192/255, 22/255)
        retornaTxt:setFillColor(43/255, 192/255, 22/255)
        imgMenu:setFillColor(225/255, 101/255, 67/255)
        menuTxt:setFillColor(225/255, 101/255, 67/255)

        imgReload:addEventListener("tap", goReload)
        imgMenu:addEventListener("tap", goMenu)

    elseif ( phase == "did" ) then
    end
end

function goReload(event)
    event.target:setFillColor(1,1,1)
    
    -- composer.removeScene("scenes.game")
    -- composer.gotoScene( "scenes.game", "fade", 200 )
    composer.gotoScene( "scenes.preGame", "fade", 200 )
end

function goMenu(event)
    event.target:setFillColor(1,1,1)
    composer.gotoScene( "scenes.menu", "fade", 200 )
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  --reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene
        -- parent:resumeGame()
    end
end
 
-- By some method (a "resume" button, for example), hide the overlay
composer.hideOverlay( "fade", 400 )
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )

return scene