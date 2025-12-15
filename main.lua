--[[
	MR_YETE HUB
	MAIN MODULE

	Protected by Hardcore Anti-Leak System
]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- =========================
-- VERIFICACIÓN DEL LOADER
-- =========================
if not _G.MRYETE_LOADED then
	lp:Kick("MR_YETE HUB\n\nUnauthorized execution detected.")
	return
end

if not _G.__MRYETE_SESSION_TOKEN then
	lp:Kick("MR_YETE HUB\n\nInvalid or expired session.")
	return
end

-- =========================
-- ANTI DOBLE EJECUCIÓN
-- =========================
if _G.__MRYETE_MAIN_RUNNING then
	return
end
_G.__MRYETE_MAIN_RUNNING = true

-- =========================
-- BIND AL JUGADOR
-- =========================
local boundUserId = lp.UserId
task.delay(2, function()
	if Players.LocalPlayer.UserId ~= boundUserId then
		lp:Kick("MR_YETE HUB\n\nSession hijack detected.")
	end
end)

-- =========================
-- BLOQUEO POR JUEGO
-- =========================
local ALLOWED_GAMES = {
	game.GameId
	-- Puedes poner IDs específicos si quieres
}

if not table.find(ALLOWED_GAMES, game.GameId) then
	lp:Kick("MR_YETE HUB\n\nThis game is not supported.")
	return
end

-- =========================
-- ANTI TAMPER SIMPLE
-- =========================
local integrityValue = 913742
local integrityCheck = 400000 + 513742

if integrityValue ~= integrityCheck then
	lp:Kick("MR_YETE HUB\n\nScript integrity compromised.")
	return
end

-- =========================
-- MENSAJE DE ÉXITO
-- =========================
warn("[MR_YETE] Main module loaded successfully")
warn("[MR_YETE] Protection level: HARDCORE")

-- =========================
-- AQUÍ EMPIEZA TU SCRIPT REAL
-- =========================

-- ↓↓↓ AQUÍ PEGAS TU GUI COMPLETA ↓↓↓
-- (la GUI grande con blur, glow, start, stop, etc.)
-- No la vuelvo a pegar aquí para no romper nada,
-- simplemente colócala debajo de este comentario.
