
# SafeCamera
The ROBLOX SafeCamera module allows developers to easily change the workspace CurrentCamera or a custom camera's CameraType and CFrame safely without having to worry about part deletion

## Docs
#### Load SafeCamera
```lua
local PlayerCameraModule = require(script.PlayerCameraController)
```

#### Change Camera
```lua
PlayerCameraModule:SetCamera(workspace.CurrentCamera)
```

#### Set Camera Part
```lua
local Part = workspace.Part
PlayerCameraModule:ChangeCamera(Part)
```

#### Return to Player
```lua
PlayerCameraModule:Close()
```

## Example Usage
Setting Camera Part
```lua
local NewPart = Instance.new("Part", workspace)
NewPart.Position = Vector3.new(0, 10, 180)

local PlayerCameraModule = require(script.PlayerCameraController)

PlayerCameraModule:SetCamera(workspace.CurrentCamera)

PlayerCameraModule:ChangeCamera(NewPart)
```
