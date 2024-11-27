local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view

    local physics = require("physics")
    physics.start()

    local fundo = display.newImage(sceneGroup, "imagens/Pag5/Página 5.png")
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

    local botao = display.newImage(sceneGroup, "imagens/Pag5/botao.png")
    botao.x = display.contentCenterX
    botao.y = 850
    botao.alpha = 0


    local Acao = display.newImage(sceneGroup, "imagens/Pag5/aazul.png")
    Acao.x = 550
    Acao.y = 800

    local Avermelho = display.newImage(sceneGroup, "imagens/Pag5/avermelho.png")
    Avermelho.x = display.contentCenterX
    Avermelho.y = -50

    local Aazinho = display.newImage(sceneGroup, "imagens/Pag5/Aaazul.png")
    Aazinho.x = 230
    Aazinho.y = 800

    local linha = display.newImage(sceneGroup, "imagens/Pag5/linha.png")
    linha.x = display.contentCenterX
    linha.y = 800

    local texto1 = display.newImage(sceneGroup, "imagens/Pag5/Portador.png")
    texto1.x = 640
    texto1.y = 800
    texto1.alpha = 0

    local texto2 = display.newImage(sceneGroup, "imagens/Pag5/Afetado.png")
    texto2.x = 160
    texto2.y = 800
    texto2.alpha = 0

    local somInicio = audio.loadSound("Audios/Página 5.mp3")
    local canalSom = 1 

    physics.addBody(Avermelho, {radius = 50, bounce = 0.3})
    physics.addBody(Aazinho, "static", {radius = 50})
    physics.addBody(Acao, "static", {radius = 50})
    physics.addBody(linha, "static", {bounce = 0.1})

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
        composer.gotoScene("Pag6", { effect = "fromRight", time = 1000 })
    end

    function botaoanterior:tap(event)
        composer.gotoScene("Pag4", { effect = "fromLeft", time = 1000 })
    end

    local function onCollision(event)
        if event.phase == "began" then
            if (event.object1 == Avermelho and event.object2 == Aazinho) or (event.object1 == Aazinho and event.object2 == Avermelho) then
                texto1.alpha = 1
            elseif (event.object1 == Avermelho and event.object2 == Acao) or (event.object1 == Acao and event.object2 == Avermelho) then
                texto2.alpha = 1
            end
        end
    end

    local function onBotaoTouch(event)
        if event.phase == "ended" then
            Avermelho:setLinearVelocity(0, 400)
        end
    end

    botao:addEventListener("touch", onBotaoTouch)
    Runtime:addEventListener("collision", onCollision)
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
