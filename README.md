# ✩ Dynamic Camera

[![Dynamic Camera showcase video](https://img.youtube.com/vi/UHV4UTi0Kd4/maxresdefault.jpg)](https://www.youtube.com/watch?v=UHV4UTi0Kd4)

Subtle dynamic camera and first-person viewmodel (hands) inertia for OpenMW. More natural movement and jumping.

Target lock with shader effects (bokeh) and a sneak shader (vignette). Immersive cell transition effects (bokeh). Experimental strafe camera tilt effects (disabled by default). Highly customizable.

Meant to be used with the [Dynamic Reticle](https://www.nexusmods.com/morrowind/mods/56584) mod, but will work without it.

_1st-person animations in the video are from [ReAnimation v2](https://www.nexusmods.com/morrowind/mods/52596) and MCAR. Circular reticle, HP widget, sneak reticle and hit markers are from [Dynamic Reticle](https://www.nexusmods.com/morrowind/mods/56584)._

## ✩ Features

- Slight headbob when jumping and landing.
- Viewmodel inertia when looking around.
- Visual and sound effects when moving at high speeds (mainly to enhance the feel of big, long leaps).
- Target lock (set the key bind in the script settings) with a neat DOF bokeh shader active only during the lock. Lock distance and switching targets by moving the mouse/stick are adjustable.
- Immersive bokeh/darkening animated transition when entering or leaving interiors.
- Sneak vignette.
- A few **extra effects** - cinematic black bars on target lock and camera roll on strafing. They are disabled by default and can be turned on in the settings.
- **Full Body Awareness tweaks** - if you play with a visible body in first person using the FBA Compatibility folder of [ReAnimation](https://www.nexusmods.com/morrowind/mods/52596), these tweaks are applied automatically to make the experience more coherent and prevent some visual clipping.
- All of it is adjustable in Options -> Scripts -> Dynamic Caméra.

<p><a href="https://ko-fi.com/maxyari"><img src="imgs/morrowind_kofi_banner_left_half_bright124.gif" width="25.72%" align="top" alt="Support me on Ko-fi"></a><a href="https://ko-fi.com/maxyari"><img src="imgs/banner_right.png" width="73.88%" align="top" alt="Support me on Ko-fi"></a><br><a href="https://ko-fi.com/maxyari"><img src="imgs/banner_glow.png" width="99.6%" align="top" alt=""></a></p>

## ✩ How to install

- **Requires OpenMW 0.49 or newer.**
- Install and enable [Max Yari's Script Services (MSS)](https://www.nexusmods.com/morrowind/mods/60256), it's a required dependency.
- Install this mod **with a mod organiser**: download the archive (or this repository as an archive) and drag and drop it into your mod organiser of choice (e.g [Mod Organizer 2](https://github.com/ModOrganizer2/modorganizer/releases) on Windows or [Nerevarine Organizer](https://github.com/grazelandsnomad/nerevarine_organizer/releases/tag/v0.70) on Linux). **Or** [read this tutorial](https://modding-openmw.com/tips/installing-mods/) on how to install mods using the launcher or completely manually (it's also very easy).
- Enable `DynamicCamera.omwscripts` in the "Content Files" tab of the OpenMW launcher.
- Ensure that post processing is enabled: Options -> Video -> Post Processing (in-game) or "Enable post processing" in the "Visuals" tab of the launcher settings. The shader effects don't show without it.
- Set a key bind for target lock in Options -> Scripts -> Dynamic Caméra.

Have fun!

## ✩ Known issues

- With OpenMW's 360° third-person camera, if a target is locked while your weapon is not drawn, moving around switches between targets. It only happens with the weapon sheathed and the 360° camera. Can be "fixed" by disabling look-based target switching in setting.

## ✩ Credit

- Thanks to [Foxunder](https://www.nexusmods.com/profile/Foxunder/mods) for investigating and fixing rare camera jitters.
- [fallchildren](https://gitlab.com/fallchildren) for debugging and fixing issues.
- High-speed blur shader by EpochWon.
- Cinematic black bars shader by [Vtastek](https://gitlab.com/vtastek/).
- Vignette shader by [Wazabear](https://www.nexusmods.com/profile/wazabear/mods).
- Hex DOF (bokeh) shader by [Wareya](https://github.com/wareya).
- High-speed wind howling sound by [Nimlos' Sound](https://nimsound.ru/).
- Thanks to [taitechnic](https://www.nexusmods.com/profile/taitechnic) for helping to improve [Dynamic Actors](https://www.nexusmods.com/morrowind/mods/54782) compatibility.
- Thanks to the folks in the OpenMW Discord for name suggestions and overall help and support.

## ✩ For developers

Dynamic Camera exposes a small Lua interface, `I.DynamicCamera`.

### Forcing the tilt effects

You can force the strafe or look-based tilt to be active even if the corresponding extra setting is disabled (useful for modded dodges, sprints etc.):

```lua
local I = require("openmw.interfaces")
I.DynamicCamera.configOverrides.StrafeRollStrength = 1
I.DynamicCamera.configOverrides.LookAroundRollStrength = 1

-- And don't forget to set them back to nil when you don't want those features active anymore!
I.DynamicCamera.configOverrides.StrafeRollStrength = nil
I.DynamicCamera.configOverrides.LookAroundRollStrength = nil
```

### Extra camera yaw/pitch/roll

If you want to add extra yaw/pitch/roll to the camera in a way that is compatible with this mod and with any other mod using the same interface - Dynamic Camera exposes methods that mirror the corresponding OpenMW Lua camera methods, but let multiple mods provide their own values, which are then summed:

```lua
I.DynamicCamera.setExtraYaw(10, "my_mod_id")
I.DynamicCamera.setExtraPitch(0, "my_mod_id")
I.DynamicCamera.setExtraRoll(0, "my_mod_id")
```

`"my_mod_id"` is a unique id of your mod, please always use the same id inside your mod whenever you set or change those values.

### Limiting the viewmodel down tilt

You can limit how far down the first-person viewmodel (hands) may pitch, on top of this mod's own setting. The lowest limit from all mods wins:

```lua
I.DynamicCamera.setViewModelPitchLimit(math.rad(50), "my_mod_id") -- radians, positive is down
I.DynamicCamera.setViewModelPitchLimit(nil, "my_mod_id")          -- clears your limit
```

## ✩ Generative AI use disclaimer

ChatGPT was used to help write the original description, and it's likely that it was used for parts of the code too.
