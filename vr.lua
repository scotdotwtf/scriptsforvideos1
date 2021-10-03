--thanks for 10 subs

--hats
--left hand https://www.roblox.com/catalog/451220849/Lavender-Updo
--right hand https://www.roblox.com/catalog/63690008/Pal-Hair
--head https://www.roblox.com/catalog/4962722078/Cute-Pink-Reality

game.Players.LocalPlayer.Character["LavanderHair"].Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
game.Players.LocalPlayer.Character["Pal Hair"].Handle:FindFirstChildOfClass("SpecialMesh"):Destroy()
game.Players.LocalPlayer.Character["Meshes/Pink_VRAccessory"].Handle.Transparency = 1
wait(1)
loadstring(game:HttpGet(('https://raw.githubusercontent.com/SynHaru/Selexity/main/Reanimate'),true))()
wait(5)

local options = {}

-- OPTIONS:

options.headscale = 1.2 -- how big you are in vr, 1 is default, 3 is recommended for max comfort in vr
options.forcebubblechat = true -- decide if to force bubblechat so you can see peoples messages

options.headhat = "Meshes/Pink_VRAccessory" -- name of the accessory which you are using as a head
options.righthandhat = "Pal Hair" -- name of the accessory which you are using as your right hand
options.lefthandhat = "LavanderHair" -- name of the accessory which you are using as your left hand

options.righthandrotoffset = Vector3.new(0,0,0)
options.lefthandrotoffset = Vector3.new(0,0,0)

--

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
--local backpack = plr.Backpack

local VR = game:GetService("VRService")
local input = game:GetService("UserInputService")

local cam = workspace.CurrentCamera

cam.CameraType = "Scriptable"

cam.HeadScale = options.headscale

game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0)
game:GetService("StarterGui"):SetCore("VREnableControllerModels", false)


local function createpart(size, name)
	local Part = Instance.new("Part", char)
	Part.CFrame = char.HumanoidRootPart.CFrame
	Part.Size = size
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Anchored = true
	Part.Name = name
	return Part
end

local moveHandL = createpart(Vector3.new(1,1,2), "moveRH")
local moveHandR = createpart(Vector3.new(1,1,2), "moveLH")
local moveHead = createpart(Vector3.new(1,1,1), "moveH")

local handL
local handR
local head
local R1down = false

for i,v in pairs(char.Humanoid:GetAccessories()) do
	if v:FindFirstChild("Handle") then
		local handle = v.Handle
		
		if v.Name == options.righthandhat and not handR then
			handR = v
		elseif v.Name == options.lefthandhat and not handL then
			handL = v
		elseif v.Name == options.headhat and not head then
			handle.Transparency = 1
			head = v
		end
	end
end

char.Humanoid.AnimationPlayed:connect(function(anim)
	anim:Stop()
end)

for i,v in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
	v:AdjustSpeed(0)
end

local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
torso.Anchored = true
char.HumanoidRootPart.Anchored = true

workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position)

input.UserCFrameChanged:connect(function(part,move)
	if part == Enum.UserCFrame.Head then
		--move(head,cam.CFrame*move)
		moveHead.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move)
	elseif part == Enum.UserCFrame.LeftHand then
		--move(handL,cam.CFrame*move)
		moveHandL.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
	elseif part == Enum.UserCFrame.RightHand then
		--move(handR,cam.CFrame*move)
		moveHandR.CFrame = cam.CFrame*(CFrame.new(move.p*(cam.HeadScale-1))*move*CFrame.Angles(math.rad(options.righthandrotoffset.X),math.rad(options.righthandrotoffset.Y),math.rad(options.righthandrotoffset.Z)))
	end
end)

local function Align(Part1,Part0,CFrameOffset) -- i dont know who made this function but 64will64 sent it to me so credit to whoever made it
	local AlignPos = Instance.new('AlignPosition', Part1);
	AlignPos.Parent.CanCollide = false;
	AlignPos.ApplyAtCenterOfMass = true;
	AlignPos.MaxForce = 67752;
	AlignPos.MaxVelocity = math.huge/9e110;
	AlignPos.ReactionForceEnabled = false;
	AlignPos.Responsiveness = 200;
	AlignPos.RigidityEnabled = false;
	local AlignOri = Instance.new('AlignOrientation', Part1);
	AlignOri.MaxAngularVelocity = math.huge/9e110;
	AlignOri.MaxTorque = 67752;
	AlignOri.PrimaryAxisOnly = false;
	AlignOri.ReactionTorqueEnabled = false;
	AlignOri.Responsiveness = 200;
	AlignOri.RigidityEnabled = false;
	local AttachmentA=Instance.new('Attachment',Part1);
	local AttachmentB=Instance.new('Attachment',Part0);
	AttachmentB.CFrame = AttachmentB.CFrame * CFrameOffset
	AlignPos.Attachment0 = AttachmentA;
	AlignPos.Attachment1 = AttachmentB;
	AlignOri.Attachment0 = AttachmentA;
	AlignOri.Attachment1 = AttachmentB;
end

head.Handle:BreakJoints()
handR.Handle:BreakJoints()
handL.Handle:BreakJoints()

Align(head.Handle,moveHead,CFrame.new(0,0,0))
Align(handR.Handle,moveHandR,CFrame.new(0,0,0))
Align(handL.Handle,moveHandL,CFrame.new(0,0,0))

input.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		if key.Position.Z > 0.9 then
			R1down = true
		else
			R1down = false
		end
	end
end)

input.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = true
	end
end)

input.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		R1down = false
	end
end)

game:GetService("RunService").RenderStepped:connect(function()
	if R1down then
		cam.CFrame = cam.CFrame:Lerp(cam.CoordinateFrame + (moveHandR.CFrame*CFrame.Angles(-math.rad(options.righthandrotoffset.X),-math.rad(options.righthandrotoffset.Y),math.rad(180-options.righthandrotoffset.X))).LookVector * cam.HeadScale/2, 0.5)
	end
end)

local function bubble(plr,msg)
	game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
end

if options.forcebubblechat == true then
	game.Players.PlayerAdded:connect(function(plr)
		plr.Chatted:connect(function(msg)
			game:GetService("Chat"):Chat(plr.Character.Head,msg,Enum.ChatColor.White)
		end)
	end)
	
	for i,v in pairs(game.Players:GetPlayers()) do
		v.Chatted:connect(function(msg)
			game:GetService("Chat"):Chat(v.Character.Head,msg,Enum.ChatColor.White)
		end)
	end
end
