--[[
	MR_YETE HUB
	HARDCORE LOADER SYSTEM

	© MR_YETE
	Unauthorized redistribution is strictly prohibited.
]]

-- =========================
-- PROTECCIÓN BÁSICA
-- =========================
if _G.__MRYETE_LOADER_RUNNING then
	return
end
_G.__MRYETE_LOADER_RUNNING = true

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer

-- =========================
-- MENSAJE DE ESTADO
-- =========================
warn("[MR_YETE] Initializing secure loader...")
warn("[MR_YETE] Verifying environment...")

-- =========================
-- ANTI DUMP SIMPLE
-- =========================
local forbidden = {
	"getscriptbytecode",
	"dumpstring",
	"decompile",
	"getscripts",
	"getloadedmodules"
}

for _,fn in ipairs(forbidden) do
	if rawget(getfenv(), fn) then
		lp:Kick("MR_YETE HUB\n\nExploit environment detected.\nAccess denied.")
		return
	end
end

-- =========================
-- SESIÓN ÚNICA
-- =========================
local SESSION_TOKEN = HttpService:GenerateGUID(false)
_G.__MRYETE_SESSION_TOKEN = SESSION_TOKEN

-- =========================
-- FLAG DE LOADER
-- =========================
_G.MRYETE_LOADED = true

warn("[MR_YETE] Loader verified successfully")
warn("[MR_YETE] Loading main module...")

-- =========================
-- CARGA DEL SCRIPT REAL
-- =========================
local success, err = pcall(function()
	loadstring(game:HttpGet(
		"https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua",
		true
	))()
end)

if not success then
	warn("[MR_YETE] ERROR while loading main script:")
	warn(err)
	lp:Kick("MR_YETE HUB\n\nFailed to load main module.")
end
