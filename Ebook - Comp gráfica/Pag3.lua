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

    local opcao2 = display.newImage(sceneGroup, "imagens/Pag3/opcao2.png")
    opcao2.x = 550
    opcao2.y = 750
    opcao2.alpha = 0

    local opcao1 = display.newImage(sceneGroup, "imagens/Pag3/opcao1.png")
    opcao1.x = 220
    opcao1.y = 750
    opcao1.alpha = 0

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
            -- Atualiza a posição da lupa
            lupa.x = event.x
            lupa.y = event.y
    
            -- Verifica interação com pessoa1
            if math.abs(lupa.x - pessoa1.x) < pessoa1.width / 2 and math.abs(lupa.y - pessoa1.y) < pessoa1.height / 2 then
                if opcao2.alpha == 0 then
                    opcao2.alpha = 1
                    transition.to(opcao2, { time = 200, xScale = 1.1, yScale = 1.1, onComplete = function()
                        transition.to(opcao2, { time = 200, xScale = 1, yScale = 1 })
                    end })
                end
            else
                if opcao2.alpha == 1 then
                    transition.to(opcao2, { time = 200, alpha = 0 })
                end
            end
    
            -- Verifica interação com pessoa2
            if math.abs(lupa.x - pessoa2.x) < pessoa2.width / 2 and math.abs(lupa.y - pessoa2.y) < pessoa2.height / 2 then
                if opcao1.alpha == 0 then
                    opcao1.alpha = 1
                    transition.to(opcao1, { time = 200, xScale = 1.1, yScale = 1.1, onComplete = function()
                        transition.to(opcao1, { time = 200, xScale = 1, yScale = 1 })
                    end })
                end
            else
                if opcao1.alpha == 1 then
                    transition.to(opcao1, { time = 200, alpha = 0 })
                end
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
