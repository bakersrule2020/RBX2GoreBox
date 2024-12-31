local FolderName = "RBX2GoreBox/" .. tostring(#listfiles("RBX2GoreBox"))
makefolder(FolderName)
makefolder(FolderName.."/CustomTextures")
makefolder(FolderName.."/MapData")
makefolder(FolderName.."/MapDataBackup")
local module = {}
function MainConversion()

	local objectindex = 0
	for i,v in game.Workspace:GetDescendants() do
        task.wait()
		if v:IsA("BasePart") and v.Name ~= "Terrain" --[[DONT FUCKING CONVERT TERRAINNNN]] then
                if v:FindFirstChild("HumanoidRootPart") ~= nil then
                    v:Destroy()
                    continue
                end
                local function GetCanCollide()
                    if v.CanCollide then return "True" else return "False" end
                end
                 local function GetGravity()
                    if v.Anchored then return "False" else return "True" end --Inverted because GoreBox uses the property as true for unanchored.
                end
				print("==mesh" .. objectindex .. ".mapCube (" .. v.Name .. ")==")
				print("Begin conversion...")
				Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
                writefile(FolderName .. "/MapData/mesh" .. objectindex .. ".mapCube", "")
				local function WriteData(data: string)
					appendfile(FolderName.."/MapData/mesh" .. objectindex .. ".mapCube", tostring(data .. "\n"))
				end
				print("Writing mat data")
				WriteData([[Concrete
0
True
]] .. GetCanCollide() .."\n" .. GetGravity() .."\nTiled") --Concrete is the only supported sound material for now =C
			print("Writing position data...")
			WriteData(v.Position.X/3)
			WriteData(v.Position.Y/3)
			WriteData(v.Position.Z/3)
			print("Writing rotation data...")
			WriteData(v.Rotation.X)
			WriteData(v.Rotation.Y)
			WriteData(v.Rotation.Z)
			print("Writing scale data")
			WriteData(v.Size.X/3)
			WriteData(v.Size.Y/3)
			WriteData(v.Size.Z/3)
			print("Conversion done!")
			objectindex += 1
			
		else
			continue
			
		end
	end
end

MainConversion()
print("Generating the project file...")
writefile(FolderName .. "/projectFile.gbi", [[2
]] .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "\n" .. [[
Exported with RBX2GoreBox
12/30/2024
44.000
55.000
66.000
.000
22.000
.000
§
0
60.000
160.000
.000
1.4
50
400
DFEEFF
]])
print("Converted everything! Might take a minute to write depending on your executor.")
