# EndeavorFX

**Adaptive cinematic lighting for Roblox Studio.**

Analyze the scene. Understand the shot. Enhance the image.

EndeavorFX is a free, open-source Roblox Lua lighting system that analyzes a scene and automatically builds a cinematic lighting setup around the active camera.

**There is no official plugin.** EndeavorFX is a standalone Command Bar Lua system. Copy the code, paste it into the Command Bar, and run it.

«Built by WiFi. Improved by everyone.»

---

## ✨ Features

**V9 implements:**

- 🎥 **Shot Analysis** — Analyzes the active camera, composition, visible scene content, screen-space importance, and shot characteristics.

- 🧠 **Adaptive Lighting** — Analyzes scene luminance, color, materials, existing lighting, and composition to determine an appropriate cinematic lighting solution.

- 🎯 **Multi-Ray Auto Focus** — Uses multiple camera rays to estimate a more stable focus distance instead of relying on a single center ray.

- 💡 **Existing Light Analysis** — Analyzes existing PointLights, SpotLights, and SurfaceLights and incorporates their contribution into the lighting solution.

- 🧱 **Material Awareness** — Considers relevant material characteristics including Metal, Glass, and Neon/emissive surfaces.

- 🌅 **Sun / Key Light Analysis** — Considers the scene's sun direction and existing lighting when solving the shot.

- 🏠 **Interior / Exterior Awareness** — Uses scene enclosure and sky visibility heuristics to distinguish between different lighting contexts.

- 🌫️ **Atmosphere Solver** — Dynamically determines atmospheric settings based on mood, time of day, scene conditions, and the solved shot.

- 🎨 **Cinematic Post Processing** — Supports Bloom, Color Correction, Depth of Field, Sun Rays, and Color Grading.

- 🎞️ **Color Grading** — Uses Roblox's ColorGradingEffect and appropriate tonemapper configuration where supported.

- 🌅 **Time of Day Presets** — Dawn, Morning, Noon, GoldenHour, Dusk, Night, and Studio.

- 🎭 **Mood Presets** — Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon, and Night.

- ⚙️ **Quality Modes** — Showcase, Cinematic, and Balanced. Quality controls how much analysis is performed internally.

- 💾 **Backup & Restore** — Protects the original lighting configuration before EndeavorFX modifies it.

---

## 🚀 Getting Started

### Roblox Studio

1. Open your Roblox Studio project.
2. Open the **Command Bar**.
3. Open `src/EndeavorFX.lua` in this repository.
4. Copy the entire code.
5. Paste it into the Command Bar.
6. Edit the four user settings at the top if desired:
   - `QUALITY`
   - `MOOD`
   - `TIME_OF_DAY`
   - `CONTROL_TIME`
7. Run the script.

That's it.

- **No plugin installation.**
- **No external application.**
- **No paid software.**
- **Just Lua.**

---

## ⚙️ Configuration

EndeavorFX exposes four user-facing settings:

```lua
local QUALITY = "Showcase"      -- Showcase, Cinematic, or Balanced
local MOOD = "Cinematic"        -- Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon, or Night
local TIME_OF_DAY = "Morning"   -- Dawn, Morning, Noon, GoldenHour, Dusk, Night, or Studio
local CONTROL_TIME = true       -- true to update ClockTime, false to leave it unchanged
```

### QUALITY

Controls how much scene analysis is performed:

- **Showcase** — Maximum quality. Analyzes more parts, lights, and viewport samples for the highest-quality result. Use when performance is not a concern.
- **Cinematic** — Balanced quality. Good analysis with reasonable performance. Recommended for most use cases.
- **Balanced** — Fast analysis. Lighter scene scanning for better performance on slower machines or complex scenes.

### MOOD

Defines the emotional tone and lighting aesthetic:

- **Cinematic** — Professional, neutral cinematic lighting.
- **GoldenHour** — Warm, golden sunlit aesthetic.
- **Studio** — Clean, bright studio lighting.
- **Dreamy** — Soft, ethereal, oversaturated look.
- **Horror** — Dark, desaturated, ominous atmosphere.
- **Neon** — High saturation, electric, synthwave-like.
- **Night** — Cool, dim night-time lighting.

### TIME_OF_DAY

Controls the sun angle, sky color, and atmospheric tint:

- **Dawn** — Early morning, cool light.
- **Morning** — Mid-morning, clear light.
- **Noon** — Midday, bright overhead sun.
- **GoldenHour** — Late afternoon, warm orange light.
- **Dusk** — Early evening, purple transitional light.
- **Night** — Night-time, cool blue darkness.
- **Studio** — Neutral midday (does not change ClockTime if CONTROL_TIME is false).

### CONTROL_TIME

If `true`, EndeavorFX sets the Lighting.ClockTime to match the TIME_OF_DAY preset. If `false`, the ClockTime is left unchanged.

---

## 🎥 How It Works

EndeavorFX operates as a single-shot heuristic solver:

```
CAMERA ANALYSIS
    ↓
SCENE ANALYSIS
    ↓
LIGHT ANALYSIS
    ↓
SHOT SOLVER
    ��
LIGHTING APPLICATION
    ↓
POST PROCESSING
    ↓
DONE
```

### Pipeline

1. **Camera Analysis** — Analyzes the active camera, viewport composition, and multi-ray focus distance.

2. **Scene Analysis** — Scans visible parts within the camera frustum. Analyzes colors, materials (Metal, Glass, Neon), saturation, and warmth. Computes screen-space composition weights.

3. **Light Analysis** — Analyzes existing PointLights, SpotLights, and SurfaceLights. Computes their energy, brightness, and warmth contribution.

4. **Sky & Sun Analysis** — Determines sky visibility and sun direction alignment. Estimates interior vs. exterior context.

5. **Shot Solver** — Combines all analysis data with the selected Mood and Time of Day to compute:
   - Exposure compensation
   - Ambient color
   - Outdoor ambient color
   - Color shift and tint
   - Bloom intensity
   - Sun rays intensity
   - Depth of field parameters
   - Atmosphere density

6. **Application** — Applies the solution to Lighting and creates/updates post-processing effects.

### Design Philosophy

EndeavorFX is **heuristic**, not physically accurate. It uses rules and heuristics to make educated guesses about the scene's lighting needs. Results can vary by scene, and algorithms may change between versions.

The system is designed to produce a **strong cinematic starting point** rather than perfect photorealism.

---

## 🎭 Mood Presets

Each mood defines a unique aesthetic with specific exposure, color, atmosphere, and effect intensities:

- **Cinematic** — Professional, neutral, balanced for general use.
- **GoldenHour** — Warm, saturated, bright bloom and sun rays.
- **Studio** — Clean, bright, minimal atmospheric effects.
- **Dreamy** — Soft, oversaturated, heavy bloom and haze.
- **Horror** — Dark, desaturated, minimal bloom, oppressive atmosphere.
- **Neon** — High saturation, high bloom, electric atmosphere.
- **Night** — Cool, dim, moderate atmosphere and bloom.

---

## 🌅 Time of Day

Time of Day presets control the sun's ClockTime and the tint of lighting:

| Preset     | ClockTime | Tint                    |
|------------|-----------|-------------------------|
| Dawn       | 6.2       | Warm orange (sunrise)   |
| Morning    | 9.0       | Neutral white           |
| Noon       | 12.5      | Bright white            |
| GoldenHour | 17.2      | Warm golden orange      |
| Dusk       | 18.4      | Cool purple             |
| Night      | 22.0      | Cool blue               |
| Studio     | 12.0      | Neutral white           |

---

## ⚙️ Quality Modes

Higher quality does not mean "better graphics." It means more thorough scene analysis:

- **Showcase** — 900 parts, 260 lights, 15 frustum samples, 9 focus rays, 12 sky rays.
- **Cinematic** — 650 parts, 180 lights, 11 frustum samples, 7 focus rays, 10 sky rays.
- **Balanced** — 400 parts, 120 lights, 7 frustum samples, 5 focus rays, 8 sky rays.

Choose **Showcase** for complex, detailed scenes where you want maximum analysis.

Choose **Cinematic** for balanced performance and quality.

Choose **Balanced** for fast analysis on slow machines or very complex scenes.

---

## 💾 Backup & Restore

When EndeavorFX runs, it automatically creates a backup of the original Lighting configuration in:

```
Lighting.G_EndeavorFX_BACKUP
```

This includes:
- Original Lighting properties (Ambient, Exposure, etc.)
- Original post-processing effects (Bloom, DOF, ColorCorrection, etc.)
- Original Atmosphere (if present)

If you run EndeavorFX multiple times, it reuses the same backup (does not create duplicates).

The backup is safe to delete manually at any time.

---

## 🧪 Open Source

EndeavorFX is intentionally open source.

You can:

- **Fork the project** — Create your own version.
- **Modify the solver** — Change how lighting is computed.
- **Create presets** — Add custom moods and times.
- **Experiment with algorithms** — Test new approaches.
- **Optimize for performance** — Make it faster.
- **Fix bugs** — Improve stability.
- **Build tools** — Create plugins, exporters, or integrations around EndeavorFX.

You don't need to wait for the main project to support your idea.

**Make your own version.**

Want to create:

«EndeavorFX Ultra Mega Blender Quality Lighting Extreme»

**Go for it.**

Want to make a tiny version optimized for performance?

**Go for it.**

Want to completely rewrite the lighting solver?

**Go for it.**

That's what open source is for.

---

## 🤝 Contributing

Found a bug? Have an optimization? Improved the solver? Added a useful feature?

**Open an issue or pull request.**

If your changes are useful to the project, they may become part of the main EndeavorFX codebase.

Your fork can also remain completely independent.

---

## 🌐 The Community

**Welcome, Wifilings. 📶**

Wifilings are the community around EndeavorFX and the projects built from it.

Whether you're using the original code, modifying it, creating a fork, or building something completely ridiculous with it—

**you're part of the community.**

---

## ⚠️ Current Status

**EndeavorFX V9 is an evolving experimental cinematic lighting solver.**

The V9 shot solver performs heuristic scene analysis and produces a one-shot lighting solution. It is not physically accurate.

**Expect:**

- Experimental features
- Changing algorithms
- Performance improvements
- New presets
- Bug fixes
- Occasional lighting that makes you question your life choices 💀

**Known limitations:**

- Scene analysis is heuristic, not physics-based.
- Lighting is not physically accurate.
- Results can vary significantly by scene.
- Performance depends on scene complexity and quality setting.
- Algorithms may change between versions.

If something doesn't behave correctly, please report it through [GitHub Issues](https://github.com/WiFi68/EndeavorFX-/issues).

---

## 📜 License

EndeavorFX is released under the **MIT License**.

See [LICENSE](./LICENSE) for the full license text.

You are free to use, modify, and distribute EndeavorFX for any purpose.

---

## 💭 Philosophy

EndeavorFX isn't meant to decide what your game should look like.

It's meant to give you a strong starting point.

**Analyze the scene.**

**Solve the shot.**

**Then make it yours.**

— WiFi

---

## 🌐 Languages

[English](./README.md) | [Português (Brasil)](./README.pt-BR.md)
