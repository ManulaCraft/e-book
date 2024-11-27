local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    -- Fundo
    local fundo = display.newImage(sceneGroup, "imagens/Pag2/Página 2.png")
    fundo.x = display.contentCenterX
    fundo.y = display.contentCenterY

    -- Botões
    local botaoproximo = display.newImage(sceneGroup, "imagens/Gerais/Próximo.png")
    botaoproximo.x = 650
    botaoproximo.y = 900

    local botaoanterior = display.newImage(sceneGroup, "imagens/Gerais/Voltar.png")
    botaoanterior.x = 120
    botaoanterior.y = 900

    -- Controle de Volume
    local volumemaximo = display.newImage(sceneGroup, "imagens/Gerais/Volume maximo.png")
    volumemaximo.x = 650
    volumemaximo.y = 120
    volumemaximo.alpha = 0

    local volumemenos = display.newImage(sceneGroup, "imagens/Gerais/Volume menos.png")
    volumemenos.x = 650
    volumemenos.y = 120

    -- Imagens
    local imagem1 = display.newImage(sceneGroup, "imagens/Pag2/imagem1.png")
    imagem1.x = display.contentCenterX
    imagem1.y = 600

    local imagem2 = display.newImage(sceneGroup, "imagens/Pag2/imagem2.png")
    imagem2.x = display.contentCenterX + 5
    imagem2.y = 700
    imagem2.alpha = 0

    -- Som
    local somInicio = audio.loadSound("Audios/Página 2.mp3")
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

    -- Eventos de toque
    function volumemaximo:tap(event)
        alternarSom()
    end

    function volumemenos:tap(event)
        alternarSom()
    end

    function botaoproximo:tap(event)
        composer.gotoScene("Pag3", { effect = "fromRight", time = 1000 })
    end

    function botaoanterior:tap(event)
        composer.gotoScene("Capa", { effect = "fromLeft", time = 1000 })
    end

    -- Acelerômetro
    local function Shake(event)
        if event.isShake then
            imagem2.alpha = 1
        end
    end

    Runtime:addEventListener("accelerometer", Shake)

    -- Adicionar listeners aos objetos
    botaoproximo:addEventListener("tap", botaoproximo)
    botaoanterior:addEventListener("tap", botaoanterior)
    volumemaximo:addEventListener("tap", volumemaximo)
    volumemenos:addEventListener("tap", volumemenos)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "did") then
        audio.play(somInicio, { channel = 1, loops = -1 })
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        audio.stop(1)
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    if somInicio then
        audio.dispose(somInicio)
        somInicio = nil
    end
end

-- Adicionar listeners de ciclo de vida da cena
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
