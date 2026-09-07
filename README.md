# EndeavorFX

**Adaptive cinematic lighting for Roblox Studio.**

Analyze the scene. Understand the shot. Enhance the image.

EndeavorFX is a free, open-source Roblox Lua lighting system that analyzes the current scene and active camera, then builds a cinematic lighting solution around the shot.

**There is no official plugin.**

EndeavorFX is a standalone **Command Bar** system. Copy the source, paste it into Roblox Studio's Command Bar, and run it.

«Built by WiFi. Improved by everyone.»

---

## ✨ Features

**EndeavorFX V9 includes:**

* 🎥 **Shot Analysis** — Analyzes the active camera, viewport composition, visible scene content, screen-space importance, and shot characteristics.

* 🧠 **Adaptive Lighting** — Evaluates scene luminance, color, materials, existing lighting, and composition to calculate a cinematic lighting solution.

* 🎯 **Multi-Ray Auto Focus** — Uses multiple camera rays to estimate a more stable focus distance instead of relying on a single center ray.

* 💡 **Existing Light Analysis** — Analyzes existing PointLights, SpotLights, and SurfaceLights and incorporates their contribution into the solution.

* 🧱 **Material Awareness** — Considers relevant materials including Metal, Glass, and Neon/emissive surfaces.

* 🌅 **Sun & Key Light Analysis** — Considers the scene's sun direction and existing light sources when solving the shot.

* 🏠 **Interior / Exterior Awareness** — Uses sky visibility and scene enclosure heuristics to determine the lighting context.

* 🌫️ **Atmosphere Solver** — Dynamically calculates atmospheric settings from the selected mood, time of day, and analyzed scene.

* 🎨 **Cinematic Post Processing** — Supports Bloom, Color Correction, Depth of Field, Sun Rays, and Color Grading.

* 🎞️ **Tonemapping** — Uses Roblox's ColorGradingEffect with a supported tonemapper configuration.

* 🌅 **Time of Day Presets** — Dawn, Morning, Noon, GoldenHour, Dusk, Night, and Studio.

* 🎭 **Mood Presets** — Cinematic, GoldenHour, Studio, Dreamy, Horror, Neon, and Night.

* ⚙️ **Quality Modes** — Showcase, Cinematic, and Balanced. Quality determines how much scene analysis is performed.

* 💾 **Automatic Backup** — Creates a protected snapshot of the original Lighting configuration before EndeavorFX modifies it.

---

## 🚀 Getting Started

### Roblox Studio

1. Open your Roblox Studio project.
2. Open the **Command Bar**.
3. Open `src/EndeavorFX.lua` from this repository.
4. Copy the entire script.
5. Paste it into the Command Bar.
6. Edit the four settings at the top if desired.
7. Run the script.

That's it.

* **No plugin installation.**
* **No external application.**
* **No paid software.**
* **Just Lua.**

EndeavorFX analyzes the current shot, solves the lighting, applies the result, and finishes.

It does **not** run continuously in the background.

---

## ⚙️ Configuration

EndeavorFX intentionally exposes only four user-facing settings:

```lua
local QUALITY = "Showcase"
local MOOD = "Cinematic"
local TIME_OF_DAY = "Morning"
local CONTROL_TIME = true
```

These are the only settings most users need to change.

### QUALITY

Controls how much scene analysis is performed.

* **Showcase** — Maximum analysis. Uses more scene samples, lights, and camera analysis for the most thorough result.
* **Cinematic** — Balanced analysis and performance. Recommended for most scenes.
* **Balanced** — Faster and lighter analysis for slower machines or complex scenes.

Higher quality does not directly mean "better graphics."

It means **more analysis before the lighting solution is calculated.**

### MOOD

Defines the overall cinematic aesthetic.

* **Cinematic** — Neutral, balanced cinematic lighting.
* **GoldenHour** — Warm, golden, sunlit lighting.
* **Studio** — Clean and controlled studio lighting.
* **Dreamy** — Soft, bright, atmospheric lighting.
* **Horror** — Dark, desaturated, oppressive lighting.
* **Neon** — Saturated, bright, electric lighting.
* **Night** — Cool, dim nighttime lighting.

### TIME_OF_DAY

Defines the simulated time of day used by the solver.

Available presets:

* **Dawn**
* **Morning**
* **Noon**
* **GoldenHour**
* **Dusk**
* **Night**
* **Studio**

### CONTROL_TIME

Controls whether EndeavorFX changes `Lighting.ClockTime`.

```lua
local CONTROL_TIME = true
```

* `true` — EndeavorFX sets `ClockTime` according to the selected `TIME_OF_DAY`.
* `false` — EndeavorFX leaves the existing `ClockTime` unchanged.

---

## 🎥 How It Works

EndeavorFX V9 is a **single-shot heuristic lighting solver**.

```text
CAMERA ANALYSIS
       ↓
SCENE ANALYSIS
       ↓
LIGHT ANALYSIS
       ↓
SUN / SKY ANALYSIS
       ↓
SHOT SOLVER
       ↓
LIGHTING APPLICATION
       ↓
POST PROCESSING
       ↓
DONE
```

### Pipeline

#### 1. Camera Analysis

EndeavorFX analyzes the active camera, viewport composition, visible geometry, screen-space importance, and focus distance.

Multi-ray focus analysis helps produce a more stable depth-of-field target than a single center ray.

#### 2. Scene Analysis

Visible scene content is sampled within the camera's view.

The solver considers:

* Scene luminance
* Color
* Saturation
* Warmth
* Screen-space importance
* Materials
* Large visible objects
* Metal
* Glass
* Neon/emissive surfaces
* Scene enclosure
* Sky visibility

#### 3. Light Analysis

Existing `PointLight`, `SpotLight`, and `SurfaceLight` instances are analyzed.

Their contribution is incorporated into the lighting solution rather than being completely ignored.

#### 4. Sun & Sky Analysis

The solver analyzes sky visibility and the scene's sun direction.

This helps determine whether the shot behaves more like an exterior, partially enclosed, or interior environment.

#### 5. Shot Solver

The analyzed data is combined with the selected **Quality**, **Mood**, and **Time of Day**.

The solver calculates values such as:

* Exposure compensation
* Ambient lighting
* Outdoor ambient lighting
* Color shifts
* Lighting tint
* Bloom
* Sun rays
* Depth of field
* Atmosphere
* Focus distance

#### 6. Application

The calculated solution is applied to Roblox Lighting and the required cinematic post-processing effects.

Once the shot is solved, the script finishes.

---

## 🎭 Mood Presets

Each mood provides a different starting aesthetic.

| Mood           | Description                            |
| -------------- | -------------------------------------- |
| **Cinematic**  | Neutral, balanced cinematic lighting   |
| **GoldenHour** | Warm, saturated sunlight               |
| **Studio**     | Clean, bright controlled lighting      |
| **Dreamy**     | Soft, atmospheric lighting             |
| **Horror**     | Dark, desaturated, oppressive lighting |
| **Neon**       | Saturated, bright, electric lighting   |
| **Night**      | Cool, dim nighttime lighting           |

The mood does not completely override the scene.

Instead, it acts as a **target aesthetic** that the solver adapts to the analyzed shot.

---

## 🌅 Time of Day

The available presets are:

| Preset         | ClockTime | General Character                   |
| -------------- | --------: | ----------------------------------- |
| **Dawn**       |       6.2 | Early morning, warm/cool transition |
| **Morning**    |       9.0 | Clear morning light                 |
| **Noon**       |      12.5 | Bright overhead daylight            |
| **GoldenHour** |      17.2 | Warm late-afternoon light           |
| **Dusk**       |      18.4 | Transitional evening light          |
| **Night**      |      22.0 | Cool nighttime lighting             |
| **Studio**     |      12.0 | Neutral studio-style daylight       |

`CONTROL_TIME = false` prevents EndeavorFX from changing `ClockTime`.

---

## ⚙️ Quality Modes

Quality controls the **depth of analysis**, not a direct graphics-quality switch.

### Showcase

Maximum analysis.

* 900 parts
* 260 lights
* 15 frustum samples
* 9 focus rays
* 12 sky rays

Best for detailed showcase scenes when additional analysis time is acceptable.

### Cinematic

Balanced analysis.

* 650 parts
* 180 lights
* 11 frustum samples
* 7 focus rays
* 10 sky rays

Recommended for most scenes.

### Balanced

Lightweight analysis.

* 400 parts
* 120 lights
* 7 frustum samples
* 5 focus rays
* 8 sky rays

Useful for complex scenes or slower development machines.

---

## 💾 Automatic Backup

Before modifying Lighting, EndeavorFX creates a backup snapshot at:

```text
Lighting.G_EndeavorFX_BACKUP
```

The backup contains the original Lighting configuration and copies of relevant existing atmosphere and post-processing effects.

If EndeavorFX is run multiple times, the existing backup is reused rather than creating a new snapshot every time.

This means you can keep the original state protected while experimenting with different settings.

The backup can be deleted manually when it is no longer needed.

---

## 🧪 Open Source

EndeavorFX is intentionally open source.

You can:

* **Fork the project**
* **Modify the solver**
* **Create custom moods**
* **Create custom time presets**
* **Experiment with the analysis algorithms**
* **Optimize performance**
* **Fix bugs**
* **Build your own tools around EndeavorFX**

You don't need to wait for the main project to support your idea.

**Make your own version.**

Want to create:

> «EndeavorFX Ultra Mega Blender Quality Lighting Extreme»

**Go for it.**

Want to make a tiny performance-focused version?

**Go for it.**

Want to completely rewrite the lighting solver?

**Go for it.**

That's what open source is for.

---

## 🤝 Contributing

Found a bug?

Have an optimization?

Improved the solver?

Added a useful feature?

**Open an issue or pull request.**

Useful improvements may eventually become part of the main EndeavorFX codebase.

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

V9 performs heuristic scene analysis and produces a **one-shot lighting solution**.

It is not physically accurate and does not attempt to simulate real-world lighting perfectly.

### Expect

* Experimental features
* Changing algorithms
* Performance improvements
* New presets
* Bug fixes
* Occasional lighting that makes you question your life choices 💀

### Known Limitations

* Scene analysis is heuristic rather than physics-based.
* Lighting is not physically accurate.
* Results can vary between scenes.
* Performance depends on scene complexity and selected quality.
* Complex scenes may require additional analysis time.
* Algorithms may change between versions.

If something doesn't behave correctly, report it through **GitHub Issues**.

---

## 📜 License

EndeavorFX is released under the **MIT License**.

See `LICENSE` for the full license text.

You are free to use, modify, and distribute EndeavorFX for any purpose permitted by the MIT License.

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

[**English**](./README.md) | [**Português (Brasil)**](./README.pt-BR.md)
