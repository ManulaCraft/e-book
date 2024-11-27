local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

  
    local fundo = display.newImage(sceneGroup, "imagens/Pag4/Página 4.png")
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

    local imagem1 = display.newImage(sceneGroup, "imagens/Pag4/imagem1.png")
    imagem1.x = display.contentCenterX
    imagem1.y = 700

    local imagem2 = display.newImage(sceneGroup, "imagens/Pag4/imagem2.png")
    imagem2.x = display.contentCenterX
    imagem2.y = 700
    imagem2.alpha = 0


    local somInicio = audio.loadSound("Audios/Página 4.mp3")
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
        composer.gotoScene("Pag5", { effect = "fromRight", time = 1000 })
    end

    function botaoanterior:tap(event)
        composer.gotoScene("Pag3", { effect = "fromLeft", time = 1000 })
    end

    local function onTouch(event)
        if event.phase == "ended" then
            
            if event.target == imagem1 then -- Verifica se o alvo do toque é a imagem1
                -- Altera o alpha da imagem2
                if imagem2.alpha == 0 then
                    transition.fadeIn(imagem2, {time = 500})
                    imagem1.alpha = 0
                end
            end
        end
        return true  
    end
    
    imagem1:addEventListener("touch", onTouch)

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
