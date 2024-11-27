-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Ocultar a barra de status
display.setStatusBar(display.HiddenStatusBar)

-- Incluir o módulo "composer" do Corona
local composer = require("composer")

-- Carregar a tela inicial com efeito de transição "fade"
composer.gotoScene("Capa", { effect = "fade", time = 800 })
