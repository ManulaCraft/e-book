local C = require("Constants")
local composer = require("composer")

local scene = composer.newScene()

-- Função para criar a cena
function scene:create(event)
    local sceneGroup = self.view

    -- Fundo da página
    local fundo = display.newImage(sceneGroup, "imagens/Pag4/Página 4.png")
    fundo.x = display.contentCenterX
    fundo.y = display.contentCenterY

    -- Botões de navegação
    local botaoproximo = display.newImage(sceneGroup, "imagens/Gerais/Próximo.png")
    botaoproximo.x = 650
    botaoproximo.y = 900

    local botaoanterior = display.newImage(sceneGroup, "imagens/Gerais/Voltar.png")
    botaoanterior.x = 120
    botaoanterior.y = 900

    -- Controle de volume
    local volumemaximo = display.newImage(sceneGroup, "imagens/Gerais/Volume maximo.png")
    volumemaximo.x = 650
    volumemaximo.y = 120
    volumemaximo.alpha = 0

    local volumemenos = display.newImage(sceneGroup, "imagens/Gerais/Volume menos.png")
    volumemenos.x = 650
    volumemenos.y = 120

    -- Imagens interativas
    local imagem1 = display.newImage(sceneGroup, "imagens/Pag4/imagem1.png")
    imagem1.x = display.contentCenterX
    imagem1.y = 700

    local imagem2 = display.newImage(sceneGroup, "imagens/Pag4/imagem2.png")
    imagem2.x = display.contentCenterX
    imagem2.y = 700
    imagem2.alpha = 0

    -- Áudio da página
    local somInicio = audio.loadSound("Audios/Página 4.mp3")
    local canalSom = 1

    -- Funções de controle do som
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

    -- Eventos de toque nos botões de volume
    volumemaximo:addEventListener("tap", alternarSom)
    volumemenos:addEventListener("tap", alternarSom)

    -- Navegação entre páginas
    local function irParaProximaPagina()
        composer.gotoScene("Pag5", { effect = "fromRight", time = 1000 })
    end

    local function irParaPaginaAnterior()
        composer.gotoScene("Pag3", { effect = "fromLeft", time = 1000 })
    end

    botaoproximo:addEventListener("tap", irParaProximaPagina)
    botaoanterior:addEventListener("tap", irParaPaginaAnterior)

    -- Interação com imagens
    local function onTouch(event)
        if event.phase == "ended" then
            if event.target == imagem1 then
                -- Animação de rotação e zoom na imagem1
                transition.to(imagem1, {
                    time = 1000,
                    xScale = 1.5,
                    yScale = 1.5,
                    rotation = 360,
                    onComplete = function()
                        -- Mostrar a imagem2 após a animação
                        imagem1.alpha = 0
                        imagem1.xScale = 1
                        imagem1.yScale = 1
                        imagem1.rotation = 0
                        transition.fadeIn(imagem2, { time = 500 })
                    end
                })
            end
        end
        return true
    end

    imagem1:addEventListener("touch", onTouch)
end

-- Função para mostrar a cena
function scene:show(event)
    local phase = event.phase

    if phase == "did" then
        audio.play(somInicio, { channel = 1, loops = -1 })
    end
end

-- Função para ocultar a cena
function scene:hide(event)
    local phase = event.phase

    if phase == "will" then
        audio.stop(1)
    end
end

-- Função para destruir a cena
function scene:destroy(event)
    if somInicio then
        audio.dispose(somInicio)
        somInicio = nil
    end
end

-- Adicionando os listeners das funções principais
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
