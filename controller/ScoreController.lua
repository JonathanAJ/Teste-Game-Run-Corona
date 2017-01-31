display.setStatusBar( display.HiddenStatusBar )
math.randomseed(os.time())

local composer = require("composer")

local Score = {}

local sceneGroupLocal
local scoreTxt
local score
local timerIdScore
local modal
local level = 1

-- Pega a cena atual
local scene = composer.getScene(composer.getSceneName( "current" ))
local sounds = scene.sounds

function Score.load(sceneGroup)

	sceneGroupLocal = sceneGroup

	modal = display.newRoundedRect(sceneGroup,
                                         centerX,
                                         0, 250, 60, 7)
	modal.alpha = 0.6
	score = 0

	scoreTxt = display.newText({
		parent = sceneGroup,
		text = score.." m",
		font = fontDialog,
		fontSize = 34,
		x = centerX,
		y = 5
	})
    scoreTxt:setFillColor(22/255, 66/255, 91/255)

    timerIdScore = timer.performWithDelay(100, atualizaScore, -1)
end

function atualizaScore()
	score = score + 1
	if (score%100 == 0) then
		audio.play(sounds.coin)
		level = level + 1
	end
	scoreTxt.text = score.." m"
end

function pausaScore()
	timer.pause(timerIdScore)
	return score
end

function Score.show()
	local background = require("controller.BackgroundController")
    background.modalAlpha(sceneGroupLocal)
	pausaScore()
	local options = {
	    effect = "fromTop",
	    time = 800,
	    isModal = true
	}
	composer.showOverlay( "scenes.modalRetorno", options )
end

function Score.hideScoreGame()
	transition.to(modal, {y = -100, time = 100})
	transition.to(scoreTxt, {y = -100, time = 100})
end

function Score.getScore()
	return score
end

function Score.getLevel()
	return level
end

return Score