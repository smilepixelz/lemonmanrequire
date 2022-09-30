require(3747589551)()
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

--[[
  
Docs:

fx.test({message = "debug: this script works"})
  
create("Part", {
    Name = "Part",
    Parent = game.Workspace;
});

fx.new({StartingSize = Vector3.new(5,5,5), EndingSize = 5, RandomizerValue = 5, Color = Color3.fromRGB(255,255,0)}):effect()

]]--
