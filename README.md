# Dynamic Camera (OpenMW)

Below readme is just a dump of nexus page, [nexus readme](https://www.nexusmods.com/morrowind/mods/55327) contains proper links, please refer to that.

Subtle dynamic camera and first-person viewmodel (hands) inertia. More natural movement and jumping.

Target lock with shader effects (bokeh) and a sneak shader (vignette). Immersive cell transition effects (bokeh).

Experimental strafe camera-tilt effects (disabled by default).

Highly customizable.

Meant to be used with the Dynamic Reticle mod, but will work without it.

## Acknowledgment

fallchildren for debugging and fixing issues
High-speed blur shader by EpochWon
Cinematic black bars shader by Vtastek
Vignette shader by Wazabear
Hex DOF (Bokeh) shader by Wareya
High-speed wind howling sound by Nimlos' Sound
Thanks to taitechnic for helping to improve Dynamic Actors compatibility﻿
Thanks to folk in OpenMW discord for name suggestions and overall help and support

## Features

- Slight headbob when jumping.
- Viewmodel inertia when looking around.
- Visual and sound effects when moving at high speeds (mainly to enhance the feel of big, long leaps).
- Target lock (key bind should be set in script options) with a neat DOF bokeh shader active only during the target lock.
- Immersive bokeh/darkening animated transition for entering/leaving interiors.
- All of the effects are adjustable in Options->Scripts->Caméra.
- few EXTRA EFFECTS (cinematic black bars on target lock and camera roll on strafing) - are disabled by default and can be activated in script options.

## This is a Lua mod for OpenMW

It should work with OpenMW version 0.48+, though it has only been tested on 0.49.

## Installation

- Install like any other OpenMW mod: copy the contents of the archive into your Morrowind folder (not the OpenMW folder), or—preferably—use MO2 to install the archive.
- Ensure that Options->Video->Post Processing is enabled
- Enable `DynamicCamera.omwscripts` in the launcher.
- Set a key bind for target lock in Options->Scripts->Caméra
- If the mod doesn’t work with your version of OpenMW, download the 0.49 release candidate (RC) build from OpenMW Downloads .

## For developers

A simple interface is now exposed in Lua. Using it you can force strafe or look-based tilt to be active even if corresponding experimental setting is disabled in this mod (might be useful for modded dodges, sprints e.t.c). To use those do something along the lines of:

```lua
local I = require("openmw.interfaces")
I.DynamicCamera.configOverrides.StrafeRollStrength = 1
I.DynamicCamera.configOverrides.LookAroundRollStrength = 1

-- And don't forget to set those values to nil when you don't want those features to be active anymore!
I.DynamicCamera.configOverrides.StrafeRollStrength = nil
I.DynamicCamera.configOverrides.LookAroundRollStrength = nil
```

Additionally if you want to set extra yaw/pitch/roll on a camera in a way that will be compatible with this mod and with any mod using same interface - Dynamic Camera exposes a set of methods that mirror corresponding OpenMW lua methods but allow for multiple mods to provide their own values.

E.g

```lua
I.DynamicCamera.setExtraYaw(10, "my_mod_id")
```

Where "my_mod_id" is a unique id of your mod, please always use the same id inside your mod whenever you set or change those extra values.

## AI Disclaimer

I used ChatGPT to help write this description because I’m lazy, and it’s likely that ChatGPT was used for parts of the code too.
