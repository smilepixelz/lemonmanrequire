
-- nebula's ezconvert
--[[
PUT YOUR SCRIPTS BELOW HERE VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV	
]]


wait(1/60)
require(4781464455)()
--real

local BodyParts = {}

for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
    if v:IsA("BasePart") then 
      BodyParts[v.Name] = v
    end
end

local plr = game.Players.LocalPlayer
local char = plr.Character 
local function CreateSound(vol, id, pitch)
    local s = Instance.new("Sound", BodyParts.HumanoidRootPart)
  s.Playing = true
  s.PlaybackSpeed = pitch
  s.SoundId = id
  s.Volume = vol
  s.PlayOnRemove = true
  s:Destroy()
end


char:FindFirstChild("Animate"):Destroy()
--roblox animate script interfiere with cframe
--so i destroy it

local function create(class, properties)
  local newclass = Instance.new(class);
  for _,v in pairs(properties) do 
    newclass[_] = v;
  end
  return newclass
end

local function tween(f)
  local p,tim,estyle,edir,goal,yield = f.Part, f.Time, f.EasingStyle, f.EasingDirection, f.Goal, f.Yield
  local tweenService = game.TweenService
  local tween = tweenService:Create(p, TweenInfo.new(tim,Enum.EasingStyle[estyle], Enum.EasingDirection[edir]),goal)
  tween:Play();
  if yield then 
    tween.Completed:Wait();
  end 
end

local fx = {}
fx.__index = fx

function fx.new(args)
  local self = setmetatable({}, fx)
  self.args = args
  return self
end

function fx:effect() -- creates a ball that explodes
  local args = self.args or {}
  local sSize = args.StartingSize
  local eSize = args.EndingSize
  local random = args.RandomizerValue
  local color = args.Color
  local part = create("Part", {
      Parent = BodyParts.HumanoidRootPart.Parent,
      Name = "Circle",
      Transparency = 0.5,
      Anchored = true,
      CanCollide = false, 
      CFrame = BodyParts.HumanoidRootPart.CFrame,
      Size = sSize,
      Color = color
  });
  local mesh = create("SpecialMesh", {
      Name = "mesh1",
      MeshType = Enum.MeshType.Sphere,
      Parent = part
  });
  tween({
      Part = part,
      Time = 0.5,
      EasingStyle = "Quad",
      EasingDirection = "InOut",
      Goal = {
        Transparency = 1,
        Size = part.Size + Vector3.new(
          eSize*Random.new():NextInteger(1, random),
          eSize*Random.new():NextInteger(1, random),
          eSize*Random.new():NextInteger(1, random)
        )
      },
      Yield = false;
  });
end

fx.new({StartingSize = Vector3.new(5,5,5), EndingSize = 5, RandomizerValue = 5, Color = Color3.fromRGB(255,255,0)}):effect()

function playAnimation(keyframes)
    local motor6Ds = {}
    motor6Ds["Torso"] = char.HumanoidRootPart.RootJoint
    motor6Ds["Left Arm"] = char.Torso["Left Shoulder"]
    motor6Ds["Right Arm"] = char.Torso["Right Shoulder"]
    motor6Ds["Left Leg"] = char.Torso["Left Hip"]
    motor6Ds["Right Leg"] = char.Torso["Right Hip"]
    motor6Ds["Head"] = char.Torso.Neck
    
    local lastframePos = 0
    
    for k,v in pairs(keyframes) do 
        local tim = math.abs(k-lastframePos)
        lastframePos = k
        local root = v.HumanoidRootPart.Torso
        local rootCF = root.CFrame
        tween({
          Part = motor6Ds["Torso"],
          Time = tim,
          EasingStyle = "Quad",
          EasingDirection = "InOut",
          Goal = {
            C0 = motor6Ds["Torso"].C0 * rootCF
          },
          Yield = false;
        });
        for _,v in pairs(root) do 
            if _ ~= "CFrame" then 
                if motor6Ds[_] then 
                    print(motor6Ds[_], v.CFrame, tim)
                    tween({
                      Part = motor6Ds[_],
                      Time = tim,
                      EasingStyle = "Linear",
                      EasingDirection = "InOut",
                      Goal = {
                        C0 = motor6Ds[_].C0 * v.CFrame
                      },
                      Yield = false;
                    });
                end
            end
        end
        wait(tim)
    end
end

playAnimation(require(script.IdleTest).Keyframes);

--[[
  
Docs:

fx.test({message = "debug: this script works"})
  
create("Part", {
    Name = "Part",
    Parent = game.Workspace;
});

fx.new({StartingSize = Vector3.new(5,5,5), EndingSize = 5, RandomizerValue = 5, Color = Color3.fromRGB(255,255,0)}):effect()

]]--
