local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

  
    local fundo = display.newImage(sceneGroup, "imagens/Pag3/Página 2.png")
    fundo.x = display.contentCenterX
    fundo.y = display.contentCenterY

   
    local botaoproximo = display.newImage(sceneGroup, "imagens/Gerais/Próximo.png")
    botaoproximo.x = 650
    botaoproximo.y = 900

    local botaoanterior = display.newImage(sceneGroup, "imagens/Gerais/Voltar.png")
    botaoanterior.x = 120
    botaoanterior.y = 900

   
    local volumemaximo = display.newImage(sceneGroup, "imagens/Gerais/Volume maximo.png")
    volumemaximo.x = 650
    volumemaximo.y = 120
    volumemaximo.alpha = 0 

    local volumemenos = display.newImage(sceneGroup, "imagens/Gerais/Volume menos.png")
    volumemenos.x = 650
    volumemenos.y = 120

    local pessoa1 = display.newImage(sceneGroup, "imagens/Pag3/pessoa1.png")
    pessoa1.x = display.contentCenterX
    pessoa1.y = 700

    local pessoa2 = display.newImage(sceneGroup, "imagens/Pag3/pessoa2.png")
    pessoa2.x = display.contentCenterX + 5
    pessoa2.y = 820

    local texto1 = display.newImage(sceneGroup, "imagens/Pag3/texto1.png")
    texto1.x = 550
    texto1.y = 750
    texto1.alpha = 0

    local texto2 = display.newImage(sceneGroup, "imagens/Pag3/texto2.png")
    texto2.x = 220
    texto2.y = 750
    texto2.alpha = 0

    local lupa = display.newImage(sceneGroup, "imagens/Pag3/lupa.png")
    lupa.x = 220
    lupa.y = 850
    lupa.height = 80
    lupa.width = 80




    local somInicio = audio.loadSound("Audios/Página 3.mp3")
    local canalSom = 1 

    local function tocarSom()
        audio.play(somInicio, { channel = canalSom, loops = -1 })
    end

    local function pararSom()
        audio.stop(canalSom)
    end

    local function alternarSom()
        if audio.isChannelPlaying(canalSom) then
            pararSom()
            volumemenos.alpha = 1
            volumemaximo.alpha = 0
        else
            tocarSom()
            volumemenos.alpha = 0
            volumemaximo.alpha = 1
        end
    end

    function volumemaximo:tap(event)
        alternarSom()
    end

    function volumemenos:tap(event)
        alternarSom()
    end

    function botaoproximo:tap(event)
        composer.gotoScene("Pag4", { effect = "fromRight", time = 1000 })
    end

    function botaoanterior:tap(event)
        composer.gotoScene("Pag2", { effect = "fromLeft", time = 1000 })
    end

    local function moverLupa(event)
        if event.phase == "moved" then

            lupa.x = event.x
            lupa.y = event.y

 
            if math.abs(lupa.x - pessoa1.x) < pessoa1.width / 2 and math.abs(lupa.y - pessoa1.y) < pessoa1.height / 2 then
                texto1.alpha = 1
            else
                texto1.alpha = 0
            end


            if math.abs(lupa.x - pessoa2.x) < pessoa2.width / 2 and math.abs(lupa.y - pessoa2.y) < pessoa2.height / 2 then
                texto2.alpha = 1
            else
                texto2.alpha = 0
            end
        end
        return true
    end

    lupa:addEventListener("touch", moverLupa)



    botaoproximo:addEventListener("tap", botaoproximo)
    botaoanterior:addEventListener("tap", botaoanterior)
    volumemaximo:addEventListener("tap", volumemaximo)
    volumemenos:addEventListener("tap", volumemenos)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
        audio.play(somInicio, { channel = 1, loops = -1 })
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        audio.stop(1)
    elseif (phase == "did") then
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    if somInicio then
        audio.dispose(somInicio)
        somInicio = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
