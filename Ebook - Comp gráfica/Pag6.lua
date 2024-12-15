local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    local paiSaudavel = false
    local paiPortador = false
    local maeSaudavel = false
    local maePortadora = false
    local paiSaudavelClicado = false
    local maeSaudavelClicado = false

    local fundo = display.newImage(sceneGroup, "imagens/Pag6/Página 6.png")
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

    local maesaudavel = display.newImage(sceneGroup, "imagens/Pag6/Mae Saudavel.png")
    maesaudavel.x = 600
    maesaudavel.y = 600

    local maeportador = display.newImage(sceneGroup, "imagens/Pag6/Mae portador.png")
    maeportador.x = 600
    maeportador.y = 750

    local paisaudavel = display.newImage(sceneGroup, "imagens/Pag6/Pai Saudavel.png")
    paisaudavel.x = 170
    paisaudavel.y = 630

    local paiportador = display.newImage(sceneGroup, "imagens/Pag6/Pai portador.png")
    paiportador.x = 170
    paiportador.y = 770

    local filhaportadora = display.newImage(sceneGroup, "imagens/Pag6/filhaportadora.png")
    filhaportadora.x = display.contentCenterX
    filhaportadora.y = 700
    filhaportadora.alpha = 0

    local filhasaudavel = display.newImage(sceneGroup, "imagens/Pag6/filhasaudavel.png")
    filhasaudavel.x = display.contentCenterX
    filhasaudavel.y = 700
    filhasaudavel.alpha = 0

    local filha50portadora = display.newImage(sceneGroup, "imagens/Pag6/filha50portadora.png")
    filha50portadora.x = display.contentCenterX
    filha50portadora.y = 700
    filha50portadora.alpha = 0

    local filha50saudavel = display.newImage(sceneGroup, "imagens/Pag6/filha50saudavel.png")
    filha50saudavel.x = display.contentCenterX
    filha50saudavel.y = 700
    filha50saudavel.alpha = 0

    -- Função de atualizar alpha das imagens
    local function atualizarAlphaFilhas()
        if paiSaudavel and maeSaudavel then
            filhasaudavel.alpha = 1
            filhaportadora.alpha = 0
            filha50portadora.alpha = 0
            filha50saudavel.alpha = 0
        elseif paiPortador and maeSaudavel then
            filhasaudavel.alpha = 0
            filhaportadora.alpha = 1
            filha50portadora.alpha = 0
            filha50saudavel.alpha = 0
        elseif paiSaudavel and maePortadora then
            filhasaudavel.alpha = 0.5
            filhaportadora.alpha = 0.5
            filha50portadora.alpha = 0
            filha50saudavel.alpha = 0
        elseif paiPortador and maePortadora then
            filhasaudavel.alpha = 0.25
            filhaportadora.alpha = 0.5
            filha50portadora.alpha = 0.25
            filha50saudavel.alpha = 0
        end
    end

    -- Função de toque para o pai saudável
    local function toquePaiSaudavel(event)
        if event.phase == "began" then
            paiSaudavel = true
        elseif event.phase == "ended" then
            paiSaudavel = false
        end
        if paiSaudavel and maeSaudavel then
            filhasaudavel.alpha = 1
            filhaportadora.alpha = 0
            filha50portadora.alpha = 0
            filha50saudavel.alpha = 0
        end
        atualizarAlphaFilhas()
        return true
    end

    -- Função de toque para a mãe saudável
    local function toqueMaeSaudavel(event)
        if event.phase == "began" then
            maeSaudavel = true
        elseif event.phase == "ended" then
            maeSaudavel = false
        end
        if maeSaudavel and paiSaudavel then
            filhasaudavel.alpha = 1
            filhaportadora.alpha = 0
            filha50portadora.alpha = 0
            filha50saudavel.alpha = 0
        end
        atualizarAlphaFilhas()
        return true
    end

    function botaoproximo:tap(event)
        composer.gotoScene("Referencia", { effect = "fromRight", time = 1000 })
    end

    function botaoanterior:tap(event)
        composer.gotoScene("Pag5", { effect = "fromLeft", time = 1000 })
    end

    paisaudavel:addEventListener("touch", toquePaiSaudavel)
    maesaudavel:addEventListener("touch", toqueMaeSaudavel)
    local somInicio = audio.loadSound("Audios/Página 6.mp3")
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
