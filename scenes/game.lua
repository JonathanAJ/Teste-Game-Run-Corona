display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")
local scene = composer.newScene()

local fisica = require("physics");
fisica.start(true);

local background
local plataforma
local player
local inimigo
local score

function scene:create( event )

    print("enter create game")

    local sceneGroup = self.view
    
    initSounds()
    
    background = require("controller.BackgroundController")
    plataforma = require("controller.PlataformaController")
    player = require("controller.PlayerController")
    inimigo = require("controller.InimigoController")
    score = require("controller.ScoreController")
end

function scene:show( event )

	local sceneGroup = self.view
    local phase = event.phase

    -- Code here runs when the scene is still off screen (but is about to come on screen)
    if ( phase == "will" ) then
        print("enter show will game")
        background.load(sceneGroup, {name = "game"})
        background.start()
        plataforma.load(sceneGroup)
        player.load(sceneGroup)
        inimigo.load(sceneGroup)
        score.load(sceneGroup)
        audio.play(scene.sounds.gameSound, { loops = -1, channel = 1 })
        audio.setVolume( 0.3, { channel = 1 } )
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        print("enter show did game")

    end
end

function scene:hide( event )

	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
        print("enter hide will game")
        
        background.stop()
        player.removeListeners()
        inimigo.pauseTimer()
        player.pauseTimer()
        fisica.stop(true)
        composer.removeScene("scenes.game")
        audio.stop()

    elseif ( phase == "did" ) then
        print("enter hide did game")
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

function scene:destroy( event )

	local sceneGroup = self.view
    print("enter destroy game")

end

function scene:resumeGame()
    fisica.pause()
    background.stop()
    player.removeListeners()
    inimigo.pauseTimer()
    player.pauseTimer()
end

function scene:getScore()
    return score.getScore()
end

function scene:hideScoreGame()
    return score.hideScoreGame()
end

function initSounds()
    scene.sounds = {
        gameSound = audio.loadSound("audio/loop/game.ogg"),
        hit = audio.loadSound("audio/game/hit.wav"),
        jump = audio.loadSound("audio/game/jump.wav"),
        gameover = audio.loadSound("audio/game/gameover.wav"),
        enemie = audio.loadSound("audio/game/enemie.wav"),
        fire = audio.loadSound("audio/game/fire.wav"),
        coin = audio.loadSound("audio/game/coin.wav")
    }
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene