-- TEST VISUAL FORZADO
game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "MRYETE LOADER",
	Text = "SI VES ESTO, EL LOADER CAMBIÓ",
	Duration = 6
})

wait(2)

-- CARGA SCRIPT REAL
loadstring(game:HttpGet("https://raw.githubusercontent.com/franciscofranciscojrmy-bit/MrYeteHUB/main/main.lua?nocache="..math.random()))()
