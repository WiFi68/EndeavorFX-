----------------------------------------------------------------------
-- ENDEAVORFX V9 — CINEMATIC ADAPTIVE SHOT SOLVER
-- STANDALONE COMMAND BAR EDITION
--
-- User-facing configuration:
--     QUALITY = "Showcase" / "Cinematic" / "Balanced"
--     MOOD = "Cinematic" / "GoldenHour" / "Studio" / "Dreamy" / "Horror" / "Neon" / "Night"
--     TIME_OF_DAY = "Dawn" / "Morning" / "Noon" / "GoldenHour" / "Dusk" / "Night" / "Studio"
--     CONTROL_TIME = true/false
--
-- Run this from the Roblox Studio Command Bar.
-- No plugin required. No external application. Just Lua.
----------------------------------------------------------------------


----------------------------------------------------------------------
-- USER CONFIGURATION — EDIT THESE FOUR SETTINGS
----------------------------------------------------------------------

local QUALITY = "Showcase"
local MOOD = "Cinematic"
local TIME_OF_DAY = "Morning"
local CONTROL_TIME = true


----------------------------------------------------------------------
-- INTERNAL CONFIGURATION
----------------------------------------------------------------------

local CONFIG = {

	-- Quality:
	-- "Showcase" / "Cinematic" / "Balanced"
	QUALITY = QUALITY,

	-- Mood:
	-- "Cinematic" / "GoldenHour" / "Studio" /
	-- "Dreamy" / "Horror" / "Neon" / "Night"
	MOOD = MOOD,

	-- Time:
	-- "Dawn" / "Morning" / "Noon" / "GoldenHour" /
	-- "Dusk" / "Night" / "Studio"
	TIME_OF_DAY = TIME_OF_DAY,

	-- Should EndeavorFX control ClockTime?
	CONTROL_TIME = CONTROL_TIME,

	-- Optional live mode.
	-- false = analyze once and finish.
	-- true  = keep adapting while the camera moves.
	LIVE_PREVIEW = false,

	-- Effects
	ENABLE_ATMOSPHERE = true,
	ENABLE_BLOOM = true,
	ENABLE_DOF = true,
	ENABLE_SUNRAYS = true,
	ENABLE_COLOR_GRADING = true,

	-- Console information
	DEBUG = true,
}


----------------------------------------------------------------------
-- SERVICES
----------------------------------------------------------------------

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")


----------------------------------------------------------------------
-- CAMERA
----------------------------------------------------------------------

local Camera = Workspace.CurrentCamera

if not Camera then
	warn("[EndeavorFX V9] CurrentCamera unavailable.")
	return
end


----------------------------------------------------------------------
-- IDENTIFIERS
----------------------------------------------------------------------

local PREFIX = "G_EndeavorFX_"
local BACKUP_NAME = "G_EndeavorFX_BACKUP"


----------------------------------------------------------------------
-- QUALITY PROFILES
----------------------------------------------------------------------

local QUALITY = {

	Showcase = {
		PartLimit = 900,
		LightLimit = 260,
		PartSamples = 5,
		FocusRays = 9,
		SkyRays = 12,
		FrustumSamples = 15,

		CameraDistance = 450,
		FocusDistance = 500,
		SkyDistance = 220,

		LiveInterval = 1.0,
	},

	Cinematic = {
		PartLimit = 650,
		LightLimit = 180,
		PartSamples = 4,
		FocusRays = 7,
		SkyRays = 10,
		FrustumSamples = 11,

		CameraDistance = 400,
		FocusDistance = 450,
		SkyDistance = 200,

		LiveInterval = 1.25,
	},

	Balanced = {
		PartLimit = 400,
		LightLimit = 120,
		PartSamples = 3,
		FocusRays = 5,
		SkyRays = 8,
		FrustumSamples = 7,

		CameraDistance = 325,
		FocusDistance = 400,
		SkyDistance = 175,

		LiveInterval = 1.5,
	},
}

local Quality = QUALITY[CONFIG.QUALITY] or QUALITY.Showcase


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
			Haze = 1.00,
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
			Haze = 1.30,
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
			Haze = 1.70,
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
			Haze = 1.00,
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
-- TIME PRESETS
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
-- UTILITIES
----------------------------------------------------------------------

local function clamp(value, minimum, maximum)
	return math.max(minimum, math.min(maximum, value))
end


local function lerp(a, b, t)
	return a + (b - a) * t
end


local function colorLerp(a, b, t)
	return a:Lerp(b, clamp(t, 0, 1))
end


local function brightness(color)

	return
		color.R * 0.2126 +
		color.G * 0.7152 +
		color.B * 0.0722

end


local function saturation(color)

	local maximum =
		math.max(color.R, color.G, color.B)

	local minimum =
		math.min(color.R, color.G, color.B)

	if maximum <= 0 then
		return 0
	end

	return (maximum - minimum) / maximum

end


local function warmth(color)

	return clamp(
		(
			(color.R - color.B) +
				(color.R - color.G) * 0.5
		) * 2,
		-1,
		1
	)

end


local function distanceWeight(distance)

	return 1 / (1 + distance * 0.018)

end


local function safeSet(instance, property, value)

	pcall(function()
		instance[property] = value
	end)

end


----------------------------------------------------------------------
-- BACKUP SYSTEM
----------------------------------------------------------------------

local function createBackup()

	local existing =
		Lighting:FindFirstChild(BACKUP_NAME)

	if existing then
		return existing
	end

	local folder =
		Instance.new("Folder")

	folder.Name = BACKUP_NAME
	folder.Parent = Lighting


	local properties = {

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


	for _, property in ipairs(properties) do

		local success, value =
			pcall(function()
				return Lighting[property]
			end)

		if success then

			local valueObject

			if typeof(value) == "Color3" then

				valueObject =
					Instance.new("Color3Value")

			elseif typeof(value) == "number" then

				valueObject =
					Instance.new("NumberValue")

			elseif typeof(value) == "boolean" then

				valueObject =
					Instance.new("BoolValue")

			elseif typeof(value) == "EnumItem" then

				valueObject =
					Instance.new("StringValue")

				value = tostring(value)

			end

			if valueObject then

				valueObject.Name = property
				valueObject.Value = value
				valueObject.Parent = folder

			end

		end

	end


	------------------------------------------------------------------
	-- BACKUP EXISTING EFFECTS
	------------------------------------------------------------------

	local effects =
		Instance.new("Folder")

	effects.Name = "Effects"
	effects.Parent = folder


	for _, child in ipairs(Lighting:GetChildren()) do

		if child:IsA("PostEffect")
			or child:IsA("Atmosphere")
		then

			local clone =
				child:Clone()

			clone.Parent = effects

		end

	end


	return folder

end


local Backup = createBackup()


----------------------------------------------------------------------
-- RESTORE FUNCTION
----------------------------------------------------------------------

local function restoreBackup()

	if not Backup then
		return false
	end


	------------------------------------------------------------------
	-- REMOVE ENDEAVORFX EFFECTS
	------------------------------------------------------------------

	for _, child in ipairs(Lighting:GetChildren()) do

		if child.Name:sub(1, #PREFIX) == PREFIX then
			child:Destroy()
		end

	end


	------------------------------------------------------------------
	-- RESTORE LIGHTING
	------------------------------------------------------------------

	for _, valueObject in ipairs(Backup:GetChildren()) do

		if valueObject:IsA("Folder") then
			continue
		end


		pcall(function()

			if valueObject:IsA("Color3Value") then

				Lighting[valueObject.Name] =
					valueObject.Value

			elseif valueObject:IsA("NumberValue") then

				Lighting[valueObject.Name] =
					valueObject.Value

			elseif valueObject:IsA("BoolValue") then

				Lighting[valueObject.Name] =
					valueObject.Value

			end

		end)

	end


	------------------------------------------------------------------
	-- RESTORE EFFECTS
	------------------------------------------------------------------

	local effects =
		Backup:FindFirstChild("Effects")

	if effects then

		for _, child in ipairs(effects:GetChildren()) do

			child:Clone().Parent = Lighting

		end

	end


	return true

end


----------------------------------------------------------------------
-- REMOVE OLD ENDEAVORFX EFFECTS
----------------------------------------------------------------------

for _, child in ipairs(Lighting:GetChildren()) do

	if child.Name:sub(1, #PREFIX) == PREFIX then
		child:Destroy()
	end

end


----------------------------------------------------------------------
-- CREATE EFFECTS
----------------------------------------------------------------------

local atmosphere
local colorCorrection
local bloom
local sunRays
local dof
local grading


if CONFIG.ENABLE_ATMOSPHERE then

	atmosphere =
		Instance.new("Atmosphere")

	atmosphere.Name =
		PREFIX .. "Atmosphere"

	atmosphere.Parent =
		Lighting

end


if CONFIG.ENABLE_COLOR_GRADING then

	colorCorrection =
		Instance.new("ColorCorrectionEffect")

	colorCorrection.Name =
		PREFIX .. "ColorCorrection"

	colorCorrection.Parent =
		Lighting


	grading =
		Instance.new("ColorGradingEffect")

	grading.Name =
		PREFIX .. "ColorGrading"

	pcall(function()
		grading.TonemapperPreset =
			Enum.TonemapperPreset.Default
	end)

	grading.Parent =
		Lighting

end


if CONFIG.ENABLE_BLOOM then

	bloom =
		Instance.new("BloomEffect")

	bloom.Name =
		PREFIX .. "Bloom"

	bloom.Size = 24
	bloom.Threshold = 1.1

	bloom.Parent =
		Lighting

end


if CONFIG.ENABLE_SUNRAYS then

	sunRays =
		Instance.new("SunRaysEffect")

	sunRays.Name =
		PREFIX .. "SunRays"

	sunRays.Spread = 0.65

	sunRays.Parent =
		Lighting

end


if CONFIG.ENABLE_DOF then

	dof =
		Instance.new("DepthOfFieldEffect")

	dof.Name =
		PREFIX .. "DepthOfField"

	dof.Parent =
		Lighting

end


----------------------------------------------------------------------
-- RAYCAST
----------------------------------------------------------------------

local rayParams =
	RaycastParams.new()

rayParams.FilterType =
	Enum.RaycastFilterType.Exclude

rayParams.IgnoreWater = true


----------------------------------------------------------------------
-- SKY DIRECTIONS
----------------------------------------------------------------------

local SKY_DIRECTIONS = {

	Vector3.new(0, 1, 0),

	Vector3.new(0.707, 0.707, 0),
	Vector3.new(-0.707, 0.707, 0),

	Vector3.new(0, 0.707, 0.707),
	Vector3.new(0, 0.707, -0.707),

	Vector3.new(0.577, 0.577, 0.577),
	Vector3.new(-0.577, 0.577, 0.577),

	Vector3.new(0.577, 0.577, -0.577),
	Vector3.new(-0.577, 0.577, -0.577),

	Vector3.new(0.408, 0.816, 0.408),
	Vector3.new(-0.408, 0.816, 0.408),

	Vector3.new(0.408, 0.816, -0.408),
	Vector3.new(-0.408, 0.816, -0.408),
}


----------------------------------------------------------------------
-- SKY VISIBILITY
----------------------------------------------------------------------

local function getSkyVisibility(position)

	local visible = 0

	local count =
		math.min(
			Quality.SkyRays,
			#SKY_DIRECTIONS
		)


	for i = 1, count do

		local result =
			Workspace:Raycast(
				position,
				SKY_DIRECTIONS[i] *
				Quality.SkyDistance,
				rayParams
			)

		if not result then
			visible += 1
		end

	end


	if count <= 0 then
		return 1
	end


	return visible / count

end


----------------------------------------------------------------------
-- SAMPLE POINTS
----------------------------------------------------------------------

local function getSamplePoints(part)

	local size = part.Size
	local cf = part.CFrame

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

	local count =
		math.min(
			Quality.PartSamples,
			#points
		)


	for i = 1, count do

		result[i] =
			cf:PointToWorldSpace(
				points[i]
			)

	end


	return result

end


----------------------------------------------------------------------
-- SCREEN WEIGHT
----------------------------------------------------------------------

local function screenWeight(position)

	local viewport =
		Camera.ViewportSize

	if viewport.X <= 0 or viewport.Y <= 0 then
		return 1
	end


	local point, visible =
		Camera:WorldToViewportPoint(position)


	if not visible or point.Z <= 0 then
		return 0
	end


	local nx =
		point.X / viewport.X

	local ny =
		point.Y / viewport.Y


	local dx =
		math.abs(nx - 0.5) * 2

	local dy =
		math.abs(ny - 0.5) * 2


	local radial =
		clamp(
			math.sqrt(dx * dx + dy * dy),
			0,
			1
		)


	return lerp(
		2.5,
		0.30,
		radial
	)

end


----------------------------------------------------------------------
-- AUTO FOCUS (MULTI-RAY)
----------------------------------------------------------------------

local function getFocusDistance()

	local origin =
		Camera.CFrame.Position

	local forward =
		Camera.CFrame.LookVector

	local right =
		Camera.CFrame.RightVector

	local up =
		Camera.CFrame.UpVector


	local offsets = {

		Vector2.zero,

		Vector2.new(0.08, 0),
		Vector2.new(-0.08, 0),

		Vector2.new(0, 0.08),
		Vector2.new(0, -0.08),

		Vector2.new(0.12, 0.08),
		Vector2.new(-0.12, 0.08),

		Vector2.new(0.12, -0.08),
		Vector2.new(-0.12, -0.08),
	}


	local distances = {}

	local count =
		math.min(
			Quality.FocusRays,
			#offsets
		)


	for i = 1, count do

		local offset =
			offsets[i]


		local direction =
			(
				forward
				+ right * offset.X
				+ up * offset.Y
			).Unit
			* Quality.FocusDistance


		local result =
			Workspace:Raycast(
				origin,
				direction,
				rayParams
			)


		if result then

			table.insert(
				distances,
				result.Distance
			)

		end

	end


	if #distances == 0 then

		return math.min(
			Quality.FocusDistance,
			100
		)

	end


	table.sort(distances)


	return distances[
	math.ceil(#distances / 2)
	]

end


----------------------------------------------------------------------
-- FRUSTUM ANALYSIS
----------------------------------------------------------------------

local function analyzeFrustum()

	local samples = {

		Vector2.new(0.50, 0.50),

		Vector2.new(0.25, 0.50),
		Vector2.new(0.75, 0.50),

		Vector2.new(0.50, 0.25),
		Vector2.new(0.50, 0.75),

		Vector2.new(0.25, 0.25),
		Vector2.new(0.75, 0.25),

		Vector2.new(0.25, 0.75),
		Vector2.new(0.75, 0.75),

		Vector2.new(0.10, 0.50),
		Vector2.new(0.90, 0.50),

		Vector2.new(0.50, 0.10),
		Vector2.new(0.50, 0.90),

		Vector2.new(0.10, 0.10),
		Vector2.new(0.90, 0.90),
	}


	local luminance = 0
	local warmthTotal = 0
	local totalWeight = 0

	local count =
		math.min(
			Quality.FrustumSamples,
			#samples
		)


	for i = 1, count do

		local uv = samples[i]

		local ray =
			Camera:ViewportPointToRay(
				Camera.ViewportSize.X * uv.X,
				Camera.ViewportSize.Y * uv.Y
			)


		local hit =
			Workspace:Raycast(
				ray.Origin,
				ray.Direction *
				Quality.CameraDistance,
				rayParams
			)


		if hit and hit.Instance:IsA("BasePart") then

			local color =
				hit.Instance.Color


			local centerDistance =
				math.sqrt(
					(uv.X - 0.5)^2 +
					(uv.Y - 0.5)^2
				)


			local centerWeight =
				1 +
				(1 - centerDistance) *
				1.5


			local depthWeight =
				1 /
				(1 + hit.Distance * 0.012)


			local weight =
				centerWeight *
				depthWeight


			luminance +=
				brightness(color) *
				weight


			warmthTotal +=
				warmth(color) *
				weight


			totalWeight += weight

		end

	end


	if totalWeight <= 0 then

		return {
			Luminance = 0.5,
			Warmth = 0,
		}

	end


	return {

		Luminance =
			luminance /
			totalWeight,

		Warmth =
			warmthTotal /
			totalWeight,
	}

end


----------------------------------------------------------------------
-- LIGHT ANALYSIS
----------------------------------------------------------------------

local function getLightPosition(light)

	local parent = light.Parent

	if parent:IsA("Attachment") then
		return parent.WorldPosition
	end

	if parent:IsA("BasePart") then
		return parent.Position
	end

	return nil

end


local function analyzeLights()

	local cameraPosition =
		Camera.CFrame.Position


	local candidates = {}


	for _, instance in ipairs(
		Workspace:GetDescendants()
		) do

		if
			(
				instance:IsA("PointLight")
					or instance:IsA("SpotLight")
					or instance:IsA("SurfaceLight")
			)
				and instance.Enabled
		then

			local position =
				getLightPosition(instance)


			if position then

				local distance =
					(
						position -
						cameraPosition
					).Magnitude


				if distance <= Quality.CameraDistance then

					local distanceFactor =
						distanceWeight(distance)


					local brightnessValue =
						clamp(
							instance.Brightness / 5,
							0,
							2
						)


					local rangeValue =
						clamp(
							instance.Range / 30,
							0.1,
							3
						)


					local importance =
						distanceFactor *
						brightnessValue *
						rangeValue


					table.insert(
						candidates,
						{
							Light = instance,
							Position = position,
							Importance = importance,
						}
					)

				end

			end

		end

	end


	table.sort(
		candidates,
		function(a, b)
			return a.Importance > b.Importance
		end
	)


	local count =
		math.min(
			#candidates,
			Quality.LightLimit
		)


	local energy = 0
	local lightBrightness = 0
	local lightWarmth = 0

	local keyEnergy = 0
	local keyWarmth = 0


	for i = 1, count do

		local data =
			candidates[i]

		local light =
			data.Light

		local importance =
			data.Importance


		energy += importance


		lightBrightness +=
			clamp(
				light.Brightness / 5,
				0,
				2
			) *
			importance


		lightWarmth +=
			warmth(light.Color) *
			importance


		if i == 1 then

			keyEnergy =
				importance

			keyWarmth =
				warmth(light.Color)

		end

	end


	if count > 0 then

		energy /= count
		lightBrightness /= count
		lightWarmth /= count

	end


	return {

		Energy = energy,
		Brightness = lightBrightness,
		Warmth = lightWarmth,

		KeyEnergy = keyEnergy,
		KeyWarmth = keyWarmth,
	}

end


----------------------------------------------------------------------
-- SCENE ANALYSIS
----------------------------------------------------------------------

local scene = {

	Luminance = 0.5,
	CameraLuminance = 0.5,

	Saturation = 0,
	Warmth = 0,

	Glass = 0,
	Metal = 0,
	Emissive = 0,

	SkyVisibility = 1,
	Enclosure = 0,

	LightEnergy = 0,
	LightBrightness = 0,
	LightWarmth = 0,

	KeyEnergy = 0,
	KeyWarmth = 0,

	SunVisibility = 1,
	SunAlignment = 0,

	FocusDistance = 100,

	Parts = 0,
}


----------------------------------------------------------------------
-- FULL SCENE ANALYSIS
----------------------------------------------------------------------

local function analyzeScene()

	local cameraPosition =
		Camera.CFrame.Position


	------------------------------------------------------------------
	-- FOCUS
	------------------------------------------------------------------

	scene.FocusDistance =
		getFocusDistance()


	------------------------------------------------------------------
	-- SKY
	------------------------------------------------------------------

	scene.SkyVisibility =
		getSkyVisibility(cameraPosition)

	scene.Enclosure =
		1 - scene.SkyVisibility


	------------------------------------------------------------------
	-- CAMERA VIEW
	------------------------------------------------------------------

	local frustum =
		analyzeFrustum()


	scene.CameraLuminance =
		frustum.Luminance


	------------------------------------------------------------------
	-- LIGHTS
	------------------------------------------------------------------

	local lights =
		analyzeLights()


	scene.LightEnergy =
		lights.Energy

	scene.LightBrightness =
		lights.Brightness

	scene.LightWarmth =
		lights.Warmth

	scene.KeyEnergy =
		lights.KeyEnergy

	scene.KeyWarmth =
		lights.KeyWarmth


	------------------------------------------------------------------
	-- SUN
	------------------------------------------------------------------

	local sunDirection =
		Lighting:GetSunDirection()


	local cameraForward =
		Camera.CFrame.LookVector


	scene.SunAlignment =
		math.abs(
			clamp(
				cameraForward:Dot(sunDirection),
				-1,
				1
			)
		)


	scene.SunVisibility =
		clamp(
			(sunDirection.Y + 0.15) / 0.65,
			0,
			1
		)


	------------------------------------------------------------------
	-- WORLD PARTS
	------------------------------------------------------------------

	local parts = {}


	for _, instance in ipairs(
		Workspace:GetDescendants()
		) do

		if
			instance:IsA("BasePart")
			and instance.Transparency < 0.98
			and instance.Size.Magnitude > 0.1
		then

			local distance =
				(
					instance.Position -
					cameraPosition
				).Magnitude


			if distance <= Quality.CameraDistance then

				table.insert(parts, instance)

			end

		end

	end


	------------------------------------------------------------------
	-- REDUCE SAMPLE COUNT
	------------------------------------------------------------------

	if #parts > Quality.PartLimit then

		local reduced = {}

		local step =
			#parts /
			Quality.PartLimit


		for i = 1, Quality.PartLimit do

			local index =
				math.floor(
					(i - 1) *
					step
				) + 1


			if parts[index] then
				table.insert(
					reduced,
					parts[index]
				)
			end

		end


		parts = reduced

	end


	------------------------------------------------------------------
	-- ANALYSIS
	------------------------------------------------------------------

	local luminance = 0
	local saturationTotal = 0
	local warmthTotal = 0

	local glass = 0
	local metal = 0
	local emissive = 0

	local totalWeight = 0


	for _, part in ipairs(parts) do

		local distance =
			(
				part.Position -
				cameraPosition
			).Magnitude


		local distanceFactor =
			distanceWeight(distance)


		local compositionWeight =
			screenWeight(part.Position)


		if compositionWeight > 0 then

			local sizeFactor =
				clamp(
					math.log(
						part.Size.Magnitude + 1
					) / 4,
					0.15,
					2
				)


			local materialFactor = 1


			if part.Material ==
				Enum.Material.Neon
			then

				emissive += 1
				materialFactor = 1.60


			elseif part.Material ==
				Enum.Material.Glass
			then

				glass += 1
				materialFactor = 1.25


			elseif part.Material ==
				Enum.Material.Metal
			then

				metal += 1
				materialFactor = 1.15

			end


			local baseWeight =
				compositionWeight *
				distanceFactor *
				sizeFactor *
				materialFactor


			for _, point in ipairs(
				getSamplePoints(part)
				) do

				local visibleWeight = 1


				local ray =
					Workspace:Raycast(
						cameraPosition,
						point - cameraPosition,
						rayParams
					)


				if ray and ray.Instance ~= part then
					visibleWeight = 0.30
				end


				local weight =
					baseWeight *
					visibleWeight


				local color =
					part.Color


				luminance +=
					brightness(color) *
					weight


				saturationTotal +=
					saturation(color) *
					weight


				warmthTotal +=
					warmth(color) *
					weight


				totalWeight += weight

			end

		end

	end


	if totalWeight > 0 then

		scene.Luminance =
			luminance /
			totalWeight

		scene.Saturation =
			saturationTotal /
			totalWeight

		scene.Warmth =
			warmthTotal /
			totalWeight

	else

		scene.Luminance = 0.5
		scene.Saturation = 0
		scene.Warmth = 0

	end


	scene.Parts = #parts

end


----------------------------------------------------------------------
-- SHOT SOLVER
----------------------------------------------------------------------

local function solve()

	local mood =
		MOODS[CONFIG.MOOD]
		or MOODS.Night


	local time =
		TIMES[CONFIG.TIME_OF_DAY]
		or TIMES.Night


	------------------------------------------------------------------
	-- BASE
	------------------------------------------------------------------

	local exposure =
		mood.Exposure


	local ambient =
		mood.Ambient


	local outdoor =
		mood.OutdoorAmbient


	local tint =
		colorLerp(
			mood.Tint,
			time.Tint,
			0.12
		)


	------------------------------------------------------------------
	-- CAMERA EXPOSURE
	------------------------------------------------------------------

	local cameraDarkness =
		clamp(
			(0.45 - scene.CameraLuminance)
			/ 0.45,
			0,
			1
		)


	local cameraBrightness =
		clamp(
			(scene.CameraLuminance - 0.58)
			/ 0.42,
			0,
			1
		)


	exposure +=
		cameraDarkness * 0.24


	exposure -=
		cameraBrightness * 0.20


	------------------------------------------------------------------
	-- GLOBAL SCENE
	------------------------------------------------------------------

	local sceneDarkness =
		clamp(
			(0.38 - scene.Luminance)
			/ 0.38,
			0,
			1
		)


	local sceneBrightness =
		clamp(
			(scene.Luminance - 0.62)
			/ 0.38,
			0,
			1
		)


	exposure +=
		sceneDarkness * 0.16


	exposure -=
		sceneBrightness * 0.14


	------------------------------------------------------------------
	-- LIGHT RESPONSE
	------------------------------------------------------------------

	exposure -=
		scene.LightEnergy * 0.80 * 0.22


	exposure -=
		scene.KeyEnergy * 0.10


	exposure +=
		scene.SunVisibility *
		scene.SunAlignment *
		0.10


	------------------------------------------------------------------
	-- INTERIOR
	------------------------------------------------------------------

	local interior =
		scene.Enclosure


	ambient =
		colorLerp(
			ambient,
			Color3.fromRGB(68, 68, 78),
			interior * 0.40
		)


	------------------------------------------------------------------
	-- WARMTH
	------------------------------------------------------------------

	if math.abs(scene.Warmth) > 0.06 then

		local warmthColor


		if scene.Warmth > 0 then

			warmthColor =
				Color3.fromRGB(
					255,
					207,
					170
				)

		else

			warmthColor =
				Color3.fromRGB(
					165,
					190,
					255
				)

		end


		ambient =
			colorLerp(
				ambient,
				warmthColor,
				math.abs(scene.Warmth) * 0.12
			)

	end


	------------------------------------------------------------------
	-- KEY LIGHT COLOR
	------------------------------------------------------------------

	if math.abs(scene.KeyWarmth) > 0.08 then

		local keyColor


		if scene.KeyWarmth > 0 then

			keyColor =
				Color3.fromRGB(
					255,
					220,
					185
				)

		else

			keyColor =
				Color3.fromRGB(
					175,
					195,
					255
				)

		end


		ambient =
			colorLerp(
				ambient,
				keyColor,
				math.abs(scene.KeyWarmth) * 0.08
			)

	end


	------------------------------------------------------------------
	-- BLOOM
	------------------------------------------------------------------

	local bloom =
		mood.Bloom


	bloom +=
		scene.LightBrightness * 0.10


	if scene.Emissive > 0 then

		bloom +=
			clamp(
				scene.Emissive /
				math.max(scene.Parts, 1)
				* 0.18,
				0,
				0.12
			)

	end


	------------------------------------------------------------------
	-- SUN RAYS
	------------------------------------------------------------------

	local sunRays =
		mood.SunRays *
		scene.SunVisibility *
		(
			0.55 +
			scene.SunAlignment * 0.45
		)


	------------------------------------------------------------------
	-- DOF
	------------------------------------------------------------------

	local dof =
		mood.DOF


	local reflective =
		clamp(
			(scene.Glass + scene.Metal) /
			math.max(
				scene.Glass +
				scene.Metal +
				scene.Emissive,
				1
			),
			0,
			1
		)


	dof *=
		1 - reflective * 0.20


	------------------------------------------------------------------
	-- ATMOSPHERE
	------------------------------------------------------------------

	local atmosphereDensity =
		mood.Atmosphere.Density


	atmosphereDensity +=
		interior * 0.025


	atmosphereDensity -=
		scene.SunVisibility * 0.015


	------------------------------------------------------------------
	-- FINAL SOLUTION
	------------------------------------------------------------------

	return {

		Exposure =
			clamp(
				exposure,
				-1,
				1
			),

		Ambient = ambient,

		OutdoorAmbient =
			colorLerp(
				outdoor,
				time.Tint,
				0.10
			),

		Tint = tint,

		ShadowSoftness =
			mood.ShadowSoftness,

		Brightness =
			clamp(
				mood.Brightness +
				(
					scene.CameraLuminance < 0.18
					and 0.025
					or 0
				),
				-1,
				1
			),

		Contrast =
			clamp(
				mood.Contrast,
				-1,
				1
			),

		Saturation =
			clamp(
				mood.Saturation +
				(
					scene.Saturation < 0.12
					and 0.025
					or 0
				),
				-1,
				1
			),

		AtmosphereDensity =
			clamp(
				atmosphereDensity,
				0,
				1
			),

		AtmosphereOffset =
			mood.Atmosphere.Offset,

		AtmosphereHaze =
			mood.Atmosphere.Haze,

		AtmosphereGlare =
			mood.Atmosphere.Glare,

		AtmosphereColor =
			mood.Atmosphere.Color,

		AtmosphereDecay =
			mood.Atmosphere.Decay,

		Bloom =
			clamp(
				bloom,
				0,
				0.35
			),

		SunRays =
			clamp(
				sunRays,
				0,
				0.16
			),

		DOF =
			clamp(
				dof,
				0,
				0.30
			),

		FocusDistance =
			clamp(
				scene.FocusDistance,
				5,
				Quality.FocusDistance
			),
	}

end


----------------------------------------------------------------------
-- APPLY SOLUTION
----------------------------------------------------------------------

local function apply(solution)

	safeSet(
		Lighting,
		"Ambient",
		solution.Ambient
	)


	safeSet(
		Lighting,
		"OutdoorAmbient",
		solution.OutdoorAmbient
	)


	safeSet(
		Lighting,
		"ExposureCompensation",
		solution.Exposure
	)


	safeSet(
		Lighting,
		"ShadowSoftness",
		solution.ShadowSoftness
	)


	safeSet(
		Lighting,
		"Brightness",
		clamp(
			2.5 +
				solution.Brightness,
			0,
			10
		)
	)


	safeSet(
		Lighting,
		"ColorShift_Top",
		solution.Tint
	)


	safeSet(
		Lighting,
		"ColorShift_Bottom",
		Color3.new(0, 0, 0)
	)


	safeSet(
		Lighting,
		"ColorShift_Side",
		Color3.new(0, 0, 0)
	)


	------------------------------------------------------------------
	-- ATMOSPHERE
	------------------------------------------------------------------

	if atmosphere then

		atmosphere.Density =
			solution.AtmosphereDensity

		atmosphere.Offset =
			solution.AtmosphereOffset

		atmosphere.Haze =
			solution.AtmosphereHaze

		atmosphere.Glare =
			solution.AtmosphereGlare

		atmosphere.Color =
			solution.AtmosphereColor

		atmosphere.Decay =
			solution.AtmosphereDecay

	end


	------------------------------------------------------------------
	-- COLOR
	------------------------------------------------------------------

	if colorCorrection then

		colorCorrection.Brightness =
			solution.Brightness

		colorCorrection.Contrast =
			solution.Contrast

		colorCorrection.Saturation =
			solution.Saturation

		colorCorrection.TintColor =
			solution.Tint

	end


	------------------------------------------------------------------
	-- BLOOM
	------------------------------------------------------------------

	if bloom then

		bloom.Intensity =
			solution.Bloom

	end


	------------------------------------------------------------------
	-- SUN RAYS
	------------------------------------------------------------------

	if sunRays then

		sunRays.Intensity =
			solution.SunRays

	end


	------------------------------------------------------------------
	-- DOF
	------------------------------------------------------------------

	if dof then

		dof.FocusDistance =
			solution.FocusDistance

		dof.InFocusRadius =
			clamp(
				solution.FocusDistance * 0.20,
				8,
				60
			)

		dof.NearIntensity =
			clamp(
				solution.DOF * 0.55,
				0,
				0.30
			)

		dof.FarIntensity =
			solution.DOF

	end

end


----------------------------------------------------------------------
-- GLOBAL LIGHTING SETUP
----------------------------------------------------------------------

safeSet(
	Lighting,
	"LightingStyle",
	Enum.LightingStyle.Realistic
)


safeSet(
	Lighting,
	"PrioritizeLightingQuality",
	true
)


safeSet(
	Lighting,
	"GlobalShadows",
	true
)


safeSet(
	Lighting,
	"EnvironmentDiffuseScale",
	0.85
)


safeSet(
	Lighting,
	"EnvironmentSpecularScale",
	1
)


----------------------------------------------------------------------
-- TIME CONTROL
----------------------------------------------------------------------

if CONFIG.CONTROL_TIME then

	local time =
		TIMES[CONFIG.TIME_OF_DAY]
		or TIMES.Night


	safeSet(
		Lighting,
		"ClockTime",
		time.ClockTime
	)

end


----------------------------------------------------------------------
-- EXECUTE ANALYSIS AND SOLVE
----------------------------------------------------------------------

print("[EndeavorFX V9] Analyzing shot...")


analyzeScene()


local solution =
	solve()


apply(solution)


----------------------------------------------------------------------
-- OPTIONAL LIVE PREVIEW
----------------------------------------------------------------------

if CONFIG.LIVE_PREVIEW then

	local elapsed = 0
	local lastCamera = Camera.CFrame


	RunService.RenderStepped:Connect(
		function(dt)

			elapsed += dt


			local currentCamera =
				Camera.CFrame


			local moved =
				(
					currentCamera.Position -
					lastCamera.Position
				).Magnitude > 1.5


			local rotated =
				1 -
				clamp(
					currentCamera.LookVector:Dot(
						lastCamera.LookVector
					),
					-1,
					1
				)


			lastCamera =
				currentCamera


			if
				elapsed >= Quality.LiveInterval
				or moved
				or rotated > 0.035
			then

				elapsed = 0

				analyzeScene()

				local newSolution =
					solve()


				apply(newSolution)

			end

		end
	)

end


----------------------------------------------------------------------
-- DEBUG OUTPUT
----------------------------------------------------------------------

if CONFIG.DEBUG then

	print("")
	print("══════════════════════════════════════════")
	print("        EndeavorFX V9 — SHOT SOLVER")
	print("══════════════════════════════════════════")

	print("Quality:", CONFIG.QUALITY)
	print("Mood:", CONFIG.MOOD)
	print("Time:", CONFIG.TIME_OF_DAY)

	print("")

	print("Scene Parts:", scene.Parts)

	print(
		"Scene Luminance:",
		string.format(
			"%.3f",
			scene.Luminance
		)
	)

	print(
		"Camera Luminance:",
		string.format(
			"%.3f",
			scene.CameraLuminance
		)
	)

	print(
		"Warmth:",
		string.format(
			"%.3f",
			scene.Warmth
		)
	)

	print(
		"Sky Visibility:",
		string.format(
			"%.3f",
			scene.SkyVisibility
		)
	)

	print(
		"Focus:",
		string.format(
			"%.1f studs",
			scene.FocusDistance
		)
	)

	print("")

	print(
		"Exposure:",
		string.format(
			"%.3f",
			solution.Exposure
		)
	)

	print(
		"Bloom:",
		string.format(
			"%.3f",
			solution.Bloom
		)
	)

	print(
		"DOF:",
		string.format(
			"%.3f",
			solution.DOF
		)
	)

	print(
		"Sun Rays:",
		string.format(
			"%.3f",
			solution.SunRays
		)
	)

	print("")

	print("EndeavorFX V9 READY.")
	print("══════════════════════════════════════════")
	print("")

end


----------------------------------------------------------------------
-- BACKUP LOCATION
--
-- The backup remains in Lighting.G_EndeavorFX_BACKUP for manual
-- restoration if needed. Call restoreBackup() before the script
-- finishes to restore manually.
----------------------------------------------------------------------
