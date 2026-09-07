----------------------------------------------------------------------
-- CONFIG & DATA
----------------------------------------------------------------------

local CONFIG = {

	QUALITY = "Showcase",       -- Showcase / Cinematic / Balanced
	MOOD = "Cinematic",             -- Cinematic / GoldenHour / Studio / Dreamy / Horror / Neon / Night
	TIME_OF_DAY = "Morning",

	CONTROL_TIME = true,

	REALISTIC_LIGHTING = true,
	PRIORITIZE_LIGHTING_QUALITY = true,	GLOBAL_SHADOWS = true,

	ADAPTATION = 0.65,

	-- Scene analysis
	MAX_PARTS = 1000,
	POINTS_PER_PART = 5,
	MAX_LIGHTS = 300,

	CAMERA_DISTANCE = 400,
	AUTO_FOCUS_DISTANCE = 500,

	-- Composition
	SCREEN_CENTER_WEIGHT = 2.4,
	SCREEN_EDGE_WEIGHT = 0.35,

	-- Existing light influence
	LIGHT_INFLUENCE = 0.75,

	-- Effects
	ENABLE_BLOOM = true,
	ENABLE_DOF = true,
	ENABLE_SUNRAYS = true,
	ENABLE_COLOR_GRADING = true,
	ENABLE_ATMOSPHERE = true,

	-- Keep cinematic effects restrained
	MAX_BLOOM = 0.35,
	MAX_DOF = 0.30,
	MAX_SUNRAYS = 0.16,

	DEBUG = true,
}

----------------------------------------------------------------------
-- MOODS
----------------------------------------------------------------------

local MOODS = {

	Cinematic = {
		Exposure = 0.05,
		Contrast = 0.12,
		Saturation = 0.03,
		Brightness = 0,

		Ambient = Color3.fromRGB(35, 35, 42),
		OutdoorAmbient = Color3.fromRGB(82, 86, 100),

		ShadowSoftness = 0.28,

		Atmosphere = {
			Density = 0.18,
			Offset = 0.15,
			Haze = 1.0,
			Glare = 0.08,
			Color = Color3.fromRGB(205, 214, 230),
			Decay = Color3.fromRGB(110, 120, 145),
		},

		Bloom = 0.16,
		SunRays = 0.07,
		DOF = 0.14,

		Tint = Color3.fromRGB(245, 245, 255),
	},

	GoldenHour = {
		Exposure = 0.15,
		Contrast = 0.08,
		Saturation = 0.08,
		Brightness = 0.03,

		Ambient = Color3.fromRGB(70, 58, 48),
		OutdoorAmbient = Color3.fromRGB(150, 112, 78),

		ShadowSoftness = 0.48,

		Atmosphere = {
			Density = 0.24,
			Offset = 0.12,
			Haze = 1.15,
			Glare = 0.18,
			Color = Color3.fromRGB(255, 220, 180),
			Decay = Color3.fromRGB(190, 130, 90),
		},

		Bloom = 0.20,
		SunRays = 0.12,
		DOF = 0.12,

		Tint = Color3.fromRGB(255, 239, 215),
	},

	Studio = {
		Exposure = 0.35,
		Contrast = 0.04,
		Saturation = 0.02,
		Brightness = 0.04,

		Ambient = Color3.fromRGB(85, 85, 90),
		OutdoorAmbient = Color3.fromRGB(125, 125, 130),

		ShadowSoftness = 0.22,

		Atmosphere = {
			Density = 0.04,
			Offset = 0.20,
			Haze = 0.25,
			Glare = 0.02,
			Color = Color3.fromRGB(220, 225, 235),
			Decay = Color3.fromRGB(170, 175, 185),
		},

		Bloom = 0.08,
		SunRays = 0.02,
		DOF = 0.10,

		Tint = Color3.fromRGB(250, 250, 255),
	},

	Dreamy = {
		Exposure = 0.30,
		Contrast = -0.04,
		Saturation = 0.12,
		Brightness = 0.05,

		Ambient = Color3.fromRGB(65, 60, 80),
		OutdoorAmbient = Color3.fromRGB(125, 120, 155),

		ShadowSoftness = 0.58,

		Atmosphere = {
			Density = 0.28,
			Offset = 0.08,
			Haze = 1.3,
			Glare = 0.15,
			Color = Color3.fromRGB(210, 205, 245),
			Decay = Color3.fromRGB(155, 145, 195),
		},

		Bloom = 0.25,
		SunRays = 0.06,
		DOF = 0.20,

		Tint = Color3.fromRGB(242, 235, 255),
	},

	Horror = {
		Exposure = -0.35,
		Contrast = 0.22,
		Saturation = -0.08,
		Brightness = -0.04,

		Ambient = Color3.fromRGB(18, 20, 27),
		OutdoorAmbient = Color3.fromRGB(38, 43, 55),

		ShadowSoftness = 0.12,

		Atmosphere = {
			Density = 0.32,
			Offset = 0.02,
			Haze = 1.7,
			Glare = 0,
			Color = Color3.fromRGB(125, 135, 155),
			Decay = Color3.fromRGB(65, 75, 95),
		},

		Bloom = 0.08,
		SunRays = 0.02,
		DOF = 0.18,

		Tint = Color3.fromRGB(210, 218, 235),
	},

	Neon = {
		Exposure = 0.15,
		Contrast = 0.18,
		Saturation = 0.18,
		Brightness = 0.02,

		Ambient = Color3.fromRGB(28, 25, 42),
		OutdoorAmbient = Color3.fromRGB(65, 50, 90),

		ShadowSoftness = 0.24,

		Atmosphere = {
			Density = 0.20,
			Offset = 0.12,
			Haze = 1.0,
			Glare = 0.10,
			Color = Color3.fromRGB(185, 190, 245),
			Decay = Color3.fromRGB(105, 80, 170),
		},

		Bloom = 0.30,
		SunRays = 0.04,
		DOF = 0.13,

		Tint = Color3.fromRGB(235, 235, 255),
	},

	Night = {
		Exposure = -0.05,
		Contrast = 0.14,
		Saturation = 0.02,
		Brightness = 0,

		Ambient = Color3.fromRGB(18, 22, 35),
		OutdoorAmbient = Color3.fromRGB(52, 60, 82),

		ShadowSoftness = 0.20,

		Atmosphere = {
			Density = 0.20,
			Offset = 0.10,
			Haze = 1.05,
			Glare = 0.04,
			Color = Color3.fromRGB(155, 175, 215),
			Decay = Color3.fromRGB(70, 85, 125),
		},

		Bloom = 0.12,
		SunRays = 0.025,
		DOF = 0.16,

		Tint = Color3.fromRGB(220, 230, 255),
	},
}

----------------------------------------------------------------------
-- TIME PROFILES
----------------------------------------------------------------------

local TIMES = {

	Dawn = {
		ClockTime = 6.2,
		Tint = Color3.fromRGB(255, 210, 175),
	},

	Morning = {
		ClockTime = 9.0,
		Tint = Color3.fromRGB(245, 245, 255),
	},

	Noon = {
		ClockTime = 12.5,
		Tint = Color3.fromRGB(255, 255, 255),
	},

	GoldenHour = {
		ClockTime = 17.2,
		Tint = Color3.fromRGB(255, 215, 170),
	},

	Dusk = {
		ClockTime = 18.4,
		Tint = Color3.fromRGB(205, 190, 220),
	},

	Night = {
		ClockTime = 22.0,
		Tint = Color3.fromRGB(175, 195, 235),
	},

	Studio = {
		ClockTime = 12.0,
		Tint = Color3.fromRGB(255, 255, 255),
	},
}

----------------------------------------------------------------------
-- SERVICES
----------------------------------------------------------------------

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

local Camera = Workspace.CurrentCamera

if not Camera then
	warn("[GFX V7] No CurrentCamera found.")
	return
end

----------------------------------------------------------------------
-- UTILITIES
----------------------------------------------------------------------

local function clamp(x, a, b)
	return math.max(a, math.min(b, x))
end

local function lerp(a, b, t)
	return a + (b - a) * t
end

local function colorLerp(a, b, t)
	return a:Lerp(b, clamp(t, 0, 1))
end

local function brightness(c)
	return c.R * 0.2126 + c.G * 0.7152 + c.B * 0.0722
end

local function saturation(c)
	local maxC = math.max(c.R, c.G, c.B)
	local minC = math.min(c.R, c.G, c.B)

	if maxC == 0 then
		return 0
	end

	return (maxC - minC) / maxC
end

local function warmth(c)
	return clamp(((c.R - c.B) + (c.R - c.G) * 0.5) * 2, -1, 1)
end

local function distanceWeight(distance)
	return 1 / (1 + distance * 0.018)
end

local function screenWeight(worldPosition)
	local viewport = Camera.ViewportSize

	if viewport.X <= 0 or viewport.Y <= 0 then
		return 1
	end

	local point, visible = Camera:WorldToViewportPoint(worldPosition)

	if not visible or point.Z <= 0 then
		return 0
	end

	local nx = point.X / viewport.X
	local ny = point.Y / viewport.Y

	local dx = math.abs(nx - 0.5) * 2
	local dy = math.abs(ny - 0.5) * 2

	local radial = math.sqrt(dx * dx + dy * dy)
	radial = clamp(radial, 0, 1)

	return lerp(CONFIG.SCREEN_CENTER_WEIGHT, CONFIG.SCREEN_EDGE_WEIGHT, radial)
end

local function safeSet(instance, property, value)
	pcall(function()
		instance[property] = value
	end)
end

----------------------------------------------------------------------
-- QUALITY PROFILE
----------------------------------------------------------------------

local QUALITY = {

	Showcase = {
		PartLimit = 1000,
		Points = 5,
		LightLimit = 300,
		FocusRays = 9,
	},

	Cinematic = {
		PartLimit = 750,
		Points = 5,
		LightLimit = 220,
		FocusRays = 7,
	},

	Balanced = {
		PartLimit = 500,
		Points = 3,
		LightLimit = 150,
		FocusRays = 5,
	},
}

local Quality = QUALITY[CONFIG.QUALITY] or QUALITY.Showcase

----------------------------------------------------------------------
-- BACKUP
----------------------------------------------------------------------

local BACKUP_NAME = "GFX_V7_BACKUP"

local backup = {
	Lighting = {},
	Effects = {},
}

local lightingProperties = {
	"Ambient",
	"OutdoorAmbient",
	"Brightness",
	"ExposureCompensation",
	"ClockTime",
	"GeographicLatitude",
	"GlobalShadows",
	"ShadowSoftness",
	"EnvironmentDiffuseScale",
	"EnvironmentSpecularScale",
	"ColorShift_Top",
	"ColorShift_Bottom",
	"ColorShift_Side",
	"PrioritizeLightingQuality",
	"LightingStyle",
}

for _, property in ipairs(lightingProperties) do
	pcall(function()
		backup.Lighting[property] = Lighting[property]
	end)
end

for _, child in ipairs(Lighting:GetChildren()) do
	if child:IsA("PostEffect") or child:IsA("Atmosphere") then
		backup.Effects[child.Name] = child:Clone()
	end
end

local backupFolder = Lighting:FindFirstChild(BACKUP_NAME)

if backupFolder then
	backupFolder:Destroy()
end

backupFolder = Instance.new("Folder")
backupFolder.Name = BACKUP_NAME
backupFolder.Parent = Lighting

for property, value in pairs(backup.Lighting) do
	local valueObject

	if typeof(value) == "Color3" then
		valueObject = Instance.new("Color3Value")
	elseif typeof(value) == "number" then
		valueObject = Instance.new("NumberValue")
	elseif typeof(value) == "boolean" then
		valueObject = Instance.new("BoolValue")
	elseif typeof(value) == "string" then
		valueObject = Instance.new("StringValue")
	end

	if valueObject then
		valueObject.Name = property
		valueObject.Value = value
		valueObject.Parent = backupFolder
	end
end

----------------------------------------------------------------------
-- REMOVE ONLY OUR OWN EFFECTS
----------------------------------------------------------------------

local PREFIX = "GFX_V7_"

for _, child in ipairs(Lighting:GetChildren()) do
	if child.Name:sub(1, #PREFIX) == PREFIX then
		child:Destroy()
	end
end

----------------------------------------------------------------------
-- CAMERA FOCUS ANALYZER
----------------------------------------------------------------------

local function createRayParams()
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {}
	params.IgnoreWater = true
	return params
end

local rayParams = createRayParams()

local function getFocusDistance()

	local origin = Camera.CFrame.Position
	local forward = Camera.CFrame.LookVector

	local right = Camera.CFrame.RightVector
	local up = Camera.CFrame.UpVector

	local offsets = {
		Vector3.zero,

		right * 0.08,
		-right * 0.08,

		up * 0.08,
		-up * 0.08,

		right * 0.12 + up * 0.08,
		-right * 0.12 + up * 0.08,

		right * 0.12 - up * 0.08,
		-right * 0.12 - up * 0.08,
	}

	local distances = {}

	for i = 1, math.min(#offsets, Quality.FocusRays) do

		local offset = offsets[i]

		local direction = (
			forward +
				right * offset.X +
				up * offset.Y
		).Unit * CONFIG.AUTO_FOCUS_DISTANCE

		local result = Workspace:Raycast(origin, direction, rayParams)

		if result then
			table.insert(distances, result.Distance)
		end
	end

	if #distances == 0 then
		return math.min(CONFIG.AUTO_FOCUS_DISTANCE, 100)
	end

	table.sort(distances)

	local middle = math.ceil(#distances / 2)

	return distances[middle]
end

local focusDistance = getFocusDistance()

----------------------------------------------------------------------
-- SCENE ANALYSIS
----------------------------------------------------------------------

local scene = {
	parts = 0,

	totalWeight = 0,

	brightness = 0,
	saturation = 0,
	warmth = 0,

	colorR = 0,
	colorG = 0,
	colorB = 0,

	interiorScore = 0,

	largeObjects = 0,
	metalScore = 0,
	glassScore = 0,

	lightContribution = 0,
	lightWarmth = 0,
	lightBrightness = 0,
}

local candidates = {}

for _, instance in ipairs(Workspace:GetDescendants()) do

	if instance:IsA("BasePart")
		and instance.Transparency < 0.98
		and instance.Size.Magnitude > 0.1
	then

		table.insert(candidates, instance)

	end
end

----------------------------------------------------------------------
-- LIMIT + RANDOMIZED DISTRIBUTION
----------------------------------------------------------------------

if #candidates > Quality.PartLimit then

	local reduced = {}

	local step = #candidates / Quality.PartLimit

	for i = 1, Quality.PartLimit do
		local index = math.floor((i - 1) * step) + 1
		local part = candidates[index]

		if part then
			table.insert(reduced, part)
		end
	end

	candidates = reduced
end

----------------------------------------------------------------------
-- MULTI-POINT PART SAMPLING
----------------------------------------------------------------------

local function getSamplePoints(part)

	local cf = part.CFrame
	local size = part.Size

	local points = {
		Vector3.zero,

		Vector3.new(size.X * 0.5, 0, 0),
		Vector3.new(-size.X * 0.5, 0, 0),

		Vector3.new(0, size.Y * 0.5, 0),
		Vector3.new(0, -size.Y * 0.5, 0),

		Vector3.new(0, 0, size.Z * 0.5),
		Vector3.new(0, 0, -size.Z * 0.5),
	}

	local result = {}

	for i = 1, math.min(CONFIG.POINTS_PER_PART, #points) do
		table.insert(result, cf:PointToWorldSpace(points[i]))
	end

	return result
end

for _, part in ipairs(candidates) do

	local center = part.Position

	local distance = (center - Camera.CFrame.Position).Magnitude

	if distance <= CONFIG.CAMERA_DISTANCE then

		local composition = screenWeight(center)

		if composition > 0 then

			local distanceFactor = distanceWeight(distance)

			local sizeFactor = clamp(
				math.log(part.Size.Magnitude + 1) / 4,
				0.15,
				2
			)

			local materialFactor = 1

			if part.Material == Enum.Material.Neon then
				materialFactor = 1.6
			elseif part.Material == Enum.Material.Glass then
				materialFactor = 1.25
				scene.glassScore += 1
			elseif part.Material == Enum.Material.Metal then
				materialFactor = 1.15
				scene.metalScore += 1
			end

			local weight = composition
				* distanceFactor
				* sizeFactor
				* materialFactor

			local points = getSamplePoints(part)

			for _, point in ipairs(points) do

				local c = part.Color
				local b = brightness(c)
				local s = saturation(c)
				local w = warmth(c)

				scene.brightness += b * weight
				scene.saturation += s * weight
				scene.warmth += w * weight

				scene.colorR += c.R * weight
				scene.colorG += c.G * weight
				scene.colorB += c.B * weight

				scene.totalWeight += weight

			end

			scene.parts += 1

			if part.Size.Magnitude > 35 then
				scene.largeObjects += 1
			end

		end
	end
end

----------------------------------------------------------------------
-- NORMALIZE SCENE DATA
----------------------------------------------------------------------

if scene.totalWeight > 0 then

	scene.brightness /= scene.totalWeight
	scene.saturation /= scene.totalWeight
	scene.warmth /= scene.totalWeight

	scene.colorR /= scene.totalWeight
	scene.colorG /= scene.totalWeight
	scene.colorB /= scene.totalWeight

end

----------------------------------------------------------------------
-- EXISTING LIGHT ANALYZER
----------------------------------------------------------------------

local lightCount = 0

for _, instance in ipairs(Workspace:GetDescendants()) do

	if lightCount >= Quality.LightLimit then
		break
	end

	if instance:IsA("PointLight")
		or instance:IsA("SpotLight")
		or instance:IsA("SurfaceLight")
	then

		if instance.Enabled then

			local parent = instance.Parent

			local position

			if parent:IsA("Attachment") then
				position = parent.WorldPosition
			elseif parent:IsA("BasePart") then
				position = parent.Position
			end

			if position then

				local distance =
					(position - Camera.CFrame.Position).Magnitude

				if distance < CONFIG.CAMERA_DISTANCE then

					local dWeight = distanceWeight(distance)

					local brightnessValue =
						clamp(instance.Brightness / 5, 0, 2)

					local rangeValue =
						clamp(instance.Range / 30, 0.1, 3)

					local influence = dWeight * brightnessValue * rangeValue

					scene.lightContribution += influence

					scene.lightBrightness += brightnessValue * influence

					scene.lightWarmth += warmth(instance.Color) * influence

					lightCount += 1
				end
			end
		end
	end
end

if lightCount > 0 then

	scene.lightContribution /= lightCount
	scene.lightBrightness /= lightCount
	scene.lightWarmth /= lightCount

end

----------------------------------------------------------------------
-- INTERIOR / EXTERIOR ESTIMATION
----------------------------------------------------------------------

local function skyRay(origin, direction)

	local result = Workspace:Raycast(origin, direction * 180, rayParams)

	return result ~= nil
end

local interiorSamples = 0
local blockedSamples = 0

for _, part in ipairs(candidates) do

	if interiorSamples >= 150 then
		break
	end

	local p = part.Position

	local directions = {
		Vector3.new(0, 1, 0),
		Vector3.new(0, -1, 0),
		Vector3.new(1, 0, 0),
		Vector3.new(-1, 0, 0),
	}

	for _, direction in ipairs(directions) do

		interiorSamples += 1

		if skyRay(p, direction) then
			blockedSamples += 1
		end

		if interiorSamples >= 150 then
			break
		end
	end
end

if interiorSamples > 0 then
	scene.interiorScore = clamp(blockedSamples / interiorSamples, 0, 1)
end

----------------------------------------------------------------------
-- ADAPTIVE SOLVER
----------------------------------------------------------------------

local Mood = MOODS[CONFIG.MOOD] or MOODS.Night
local Time = TIMES[CONFIG.TIME_OF_DAY] or TIMES.Night

local targetExposure = Mood.Exposure

if scene.brightness < 0.18 then
	targetExposure += 0.22
elseif scene.brightness > 0.70 then
	targetExposure -= 0.18
end

targetExposure -= scene.lightContribution * CONFIG.LIGHT_INFLUENCE * 0.10

local interiorAmount = scene.interiorScore

local targetAmbient = colorLerp(
	Mood.Ambient,
	colorLerp(Mood.Ambient, Color3.fromRGB(70, 70, 80), 0.35),
	interiorAmount
)

local targetOutdoor = colorLerp(Mood.OutdoorAmbient, Time.Tint, 0.08)

if math.abs(scene.warmth) > 0.08 then

	local warmthColor

	if scene.warmth > 0 then
		warmthColor = Color3.fromRGB(255, 205, 165)
	else
		warmthColor = Color3.fromRGB(165, 190, 255)
	end

	targetAmbient = colorLerp(
		targetAmbient,
		warmthColor,
		math.abs(scene.warmth) * 0.10
	)

end

----------------------------------------------------------------------
-- APPLY LIGHTING
----------------------------------------------------------------------

if CONFIG.REALISTIC_LIGHTING then
	safeSet(Lighting, "LightingStyle", Enum.LightingStyle.Realistic)
end

safeSet(
	Lighting,
	"PrioritizeLightingQuality",
	CONFIG.PRIORITIZE_LIGHTING_QUALITY
)

safeSet(Lighting, "GlobalShadows", CONFIG.GLOBAL_SHADOWS)

safeSet(Lighting, "ShadowSoftness", Mood.ShadowSoftness)

safeSet(Lighting, "Ambient", targetAmbient)

safeSet(Lighting, "OutdoorAmbient", targetOutdoor)

safeSet(Lighting, "EnvironmentDiffuseScale", 0.85)

safeSet(Lighting, "EnvironmentSpecularScale", 1)

safeSet(Lighting, "Brightness", clamp(2.5 + Mood.Brightness, 0, 10))

safeSet(Lighting, "ExposureCompensation", targetExposure)

safeSet(Lighting, "ColorShift_Top", colorLerp(Time.Tint, Mood.Tint, 0.35))

safeSet(Lighting, "ColorShift_Bottom", Color3.fromRGB(0, 0, 0))

safeSet(Lighting, "ColorShift_Side", Color3.fromRGB(0, 0, 0))

if CONFIG.CONTROL_TIME then
	safeSet(Lighting, "ClockTime", Time.ClockTime)
end

----------------------------------------------------------------------
-- ATMOSPHERE
----------------------------------------------------------------------

local atmosphere

if CONFIG.ENABLE_ATMOSPHERE then

	atmosphere = Instance.new("Atmosphere")
	atmosphere.Name = PREFIX .. "Atmosphere"

	atmosphere.Density = clamp(
		Mood.Atmosphere.Density + scene.interiorScore * 0.025,
		0,
		1
	)

	atmosphere.Offset = clamp(Mood.Atmosphere.Offset, -1, 1)

	atmosphere.Haze = clamp(Mood.Atmosphere.Haze, 0, 2)

	atmosphere.Glare = clamp(Mood.Atmosphere.Glare, 0, 2)

	atmosphere.Color = Mood.Atmosphere.Color

	atmosphere.Decay = Mood.Atmosphere.Decay

	atmosphere.Parent = Lighting
end

----------------------------------------------------------------------
-- COLOR CORRECTION
----------------------------------------------------------------------

local colorCorrection = Instance.new("ColorCorrectionEffect")

colorCorrection.Name = PREFIX .. "ColorCorrection"

colorCorrection.Brightness = clamp(
	Mood.Brightness + (scene.brightness < 0.2 and 0.025 or 0),
	-1,
	1
)

colorCorrection.Contrast = clamp(Mood.Contrast, -1, 1)

colorCorrection.Saturation = clamp(
	Mood.Saturation + (scene.saturation < 0.12 and 0.025 or 0),
	-1,
	1
)

colorCorrection.TintColor = colorLerp(Mood.Tint, Time.Tint, 0.12)

colorCorrection.Parent = Lighting

----------------------------------------------------------------------
-- BLOOM
----------------------------------------------------------------------

if CONFIG.ENABLE_BLOOM then

	local bloom = Instance.new("BloomEffect")
	bloom.Name = PREFIX .. "Bloom"

	local neonBoost = clamp(scene.lightBrightness * 0.10, 0, 0.10)

	bloom.Intensity = clamp(Mood.Bloom + neonBoost, 0, CONFIG.MAX_BLOOM)

	bloom.Size = 24
	bloom.Threshold = 1.1

	bloom.Parent = Lighting
end

----------------------------------------------------------------------
-- SUN RAYS
----------------------------------------------------------------------

if CONFIG.ENABLE_SUNRAYS then

	local rays = Instance.new("SunRaysEffect")
	rays.Name = PREFIX .. "SunRays"

	rays.Intensity = clamp(Mood.SunRays, 0, CONFIG.MAX_SUNRAYS)

	rays.Spread = 0.65

	rays.Parent = Lighting
end

----------------------------------------------------------------------
-- DEPTH OF FIELD
----------------------------------------------------------------------

if CONFIG.ENABLE_DOF then

	local dof = Instance.new("DepthOfFieldEffect")
	dof.Name = PREFIX .. "DepthOfField"

	dof.FocusDistance = clamp(focusDistance, 5, CONFIG.AUTO_FOCUS_DISTANCE)

	dof.InFocusRadius = clamp(focusDistance * 0.20, 8, 60)

	dof.NearIntensity = clamp(Mood.DOF * 0.55, 0, CONFIG.MAX_DOF)

	dof.FarIntensity = clamp(Mood.DOF, 0, CONFIG.MAX_DOF)

	dof.Parent = Lighting
end

----------------------------------------------------------------------
-- COLOR GRADING
----------------------------------------------------------------------

if CONFIG.ENABLE_COLOR_GRADING then

	local grading = Instance.new("ColorGradingEffect")
	grading.Name = PREFIX .. "ColorGrading"

	pcall(function()
		grading.TonemapperPreset = Enum.TonemapperPreset.Default
	end)

	grading.Parent = Lighting
end

----------------------------------------------------------------------
-- DIAGNOSTICS
----------------------------------------------------------------------

if CONFIG.DEBUG then

	print("")
	print("══════════════════════════════════════════════")
	print("              GFX V7 — SHOT SOLVER")
	print("══════════════════════════════════════════════")

	print("QUALITY:", CONFIG.QUALITY)
	print("MOOD:", CONFIG.MOOD)
	print("TIME:", CONFIG.TIME_OF_DAY)

	print("")
	print("SCENE ANALYSIS")
	print("Parts:", scene.parts)
	print("Brightness:", string.format("%.3f", scene.brightness))
	print("Saturation:", string.format("%.3f", scene.saturation))
	print("Warmth:", string.format("%.3f", scene.warmth))
	print("Interior:", string.format("%.3f", scene.interiorScore))

	print("")
	print("LIGHT ANALYSIS")
	print("Lights:", lightCount)
	print("Influence:", string.format("%.3f", scene.lightContribution))

	print("")
	print("CAMERA ANALYSIS")
	print("Focus:", string.format("%.1f studs", focusDistance))

	print("")
	print("SOLVER")
	print("Exposure:", string.format("%.3f", targetExposure))

	print("Ambient:", targetAmbient)

	print("Outdoor:", targetOutdoor)

	print("")
	print("Effects:")
	print("  Atmosphere:", CONFIG.ENABLE_ATMOSPHERE)
	print("  Bloom:", CONFIG.ENABLE_BLOOM)
	print("  DOF:", CONFIG.ENABLE_DOF)
	print("  SunRays:", CONFIG.ENABLE_SUNRAYS)
	print("  ColorGrading:", CONFIG.ENABLE_COLOR_GRADING)

	print("")
	print("BACKUP:")
	print("  " .. BACKUP_NAME)

	print("")
	print("V7 COMPLETE.")
	print("══════════════════════════════════════════════")
	print("")
end
