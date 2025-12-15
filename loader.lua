-- MR_Yete HUB Loader (estable)

local url = "https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua"

local ok, err = pcall(function()
	loadstring(game:HttpGet(url))()
end)

if not ok then
	warn("[MR_Yete HUB] Error cargando main.lua:", err)
end
