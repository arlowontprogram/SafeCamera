-- @ metadata
-- @ title: SafeCamera
-- @ creator: 110029109
-- @ github: https://github.com/arlowontprogram/SafeCamera
-- @ version: 1.1

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local PlayerCameraModule = {}
PlayerCameraModule.__index = PlayerCameraModule

local function UpdateCam(Cam, Part)
	pcall(function()
		Cam.CameraType = Enum.CameraType.Scriptable
		Cam.CFrame = Part.CFrame
	end)
end

function PlayerCameraModule:SetCamera(Camera)
	if not Camera then
		warn("Camera not defined")
		return self
	end
	self.Camera = Camera
end

function PlayerCameraModule:SetCFrameOffset(Offset)
	if not Offset then
		warn("No offset defined")
	end
	self.Offset = Offset or CFrame.new(0, 0, 0)
end

function PlayerCameraModule:Close()
	if self.Heartbeat ~= nil then
		self.Heartbeat:Disconnect()
	end
	if self.Destroying ~= nil then
		self.Destroying:Disconnect()
	end
	self.Camera.CameraType = Enum.CameraType.Custom
	self.Camera.CameraSubject = self.CameraSubject
end

function PlayerCameraModule:ChangePart(Basepart: BasePart): boolean
	-- checks
	if not Basepart then
		warn("Object", Basepart, "not defined.")
		return false
	end
	if not Basepart:IsA("BasePart") then
		warn("Object", Basepart, "is not a BasePart")
		return false
	end
	-- check if offset exists
	if not self.Offset then
		self.Offset = CFrame.new(0, 0, 0)
	end
	-- save subject
	self.CameraSubject = self.Camera.CameraSubject
	-- cut heartbeat
	if self.Heartbeat ~= nil then
		self.Heartbeat:Disconnect()
	end
	-- listen for part removal
	-- we cant listen to Destroying since ancestry changes to nil won't call Destroying
	--self.Destroying = Basepart.Destroying:Connect(function()

	self.Destroying = Basepart.AncestryChanged:Connect(function()
		if not Basepart:IsDescendantOf(game) then
			self:Close()
		end
	end)
	-- create new heartbeat instance
	self.Heartbeat = RunService.Heartbeat:Connect(function()
		UpdateCam(self.Camera, Basepart, self.Offset)
	end)
end

return setmetatable({}, PlayerCameraModule)
