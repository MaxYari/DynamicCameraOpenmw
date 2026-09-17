local I = require('openmw.interfaces')
local input = require('openmw.input')

local HighSpeedEffectsOpts = {
    Everywhere = "Everywhere",
    Air = "In the air",
    Ground = "On the ground",
    Off = "Off"
}

input.registerTrigger {
    key = 'LockTarget',    
    l10n = 'FPViewDynamics'
}

I.Settings.registerPage {
    key = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Dynamic Caméra',
    description = "~~ Whoaaa, look how it moves. Some of the settings are not updated in realtime. Open a ~ console and run 'reloadlua' command to apply settings, or restart the game.",
}
I.Settings.registerGroup {
    key = '1FPViewDynamicsControlsSettings',
    page = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Controls',
    permanentStorage = true,    
    settings = {
        {
            key = "LockTargetButton",
            renderer = "inputBinding",
            default = "LockTargetButtonKey",
            name = "Lock Target",
            description = 'Press to lock the view onto a target.',
            argument = {
                type = "trigger",
                key = "LockTarget"
            }
        },
        {
            key = "LockTargetDistance",
            renderer = "number",
            default = 15,
            argument = {
                min = 1
            },
            name = "Lock Target Distance",
            description = "In meters. How far a target can be to get locked onto. A locked target is released a bit beyond it."
        },
        {
            key = "LockTargetSwitching",
            renderer = "checkbox",
            default = true,
            name = "Switch Target By Look Movement",
            description = "While locked, a quick mouse or stick movement switches to another target in that direction."
        }
    }
}
I.Settings.registerGroup {
    key = '2FPViewDynamicsVisualSettings',
    page = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Visuals',    
    permanentStorage = true,
    settings = {
        {
            key = "JumpBobStrength",
            renderer = "number",
            default = 100,
            argument = {
                min = 0
            },
            name = "Jump Headbob Strength"
        },
        {
            key = "LandBobStrength",
            renderer = "number",
            default = 100,
            argument = {
                min = 0
            },
            name = "Landing Headbob Strength"
        },        
        {
            key = "ViewmodelIntertiaStrength",
            renderer = "number",
            default = 175,
            argument = {
                min = 0
            },
            name = "Viewmodel Inertia Strength"
        },
        {
            key = 'HighSpeedEffects',
            renderer = 'select',
            default = HighSpeedEffectsOpts.Everywhere,
            argument = {
                l10n = 'FPViewDynamics',
                items = { HighSpeedEffectsOpts.Everywhere, HighSpeedEffectsOpts.Air, HighSpeedEffectsOpts.Ground, HighSpeedEffectsOpts.Off },
            },
            name = 'High Speed Effects'
        },
        {
            key = "HighSpeedEffectStart",
            renderer = "number",
            default = 600,
            argument = {
                min = 0
            },
            name = "High-speed Effect Start",
            description = 'Character speed at which high-speed effects kick in.',
        },
        {
            key = "SpeedBlurStrength",
            renderer = "number",
            default = 100,
            argument = {
                min = 0
            },
            name = "High-speed Blur Strength"
        },
        {
            key = "DofEffects",
            renderer = "checkbox",
            default = true,
            name = "Depth of field effects",
            description = "If enabled uses subtle depth-of-field effects on target lock and cell transitions. Keeping it disabled might improve performace."
        },
        {
            key = "CellTransitionDuration",
            renderer = "number",
            default = 1,
            argument = {
                min = 0
            },
            name = "Cell Transition Animation Duration",
            description = "In seconds"
        },
        {
            key = "SneakVignetteOpacity",
            renderer = "number",
            default = 35,
            argument = {
                min = 0,
                max = 100
            },
            name = "Sneak Vignette Opacity",
            description = "In 0 - 100 range"
        }
    },
}
I.Settings.registerGroup {
    key = '3FPViewDynamicsSoundSettings',
    page = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Sound',
    description = 'Wind goes woooshhhhh',
    permanentStorage = true,
    settings = {
        {
            key = "SpeedWindVolume",
            renderer = "number",
            default = 100,
            argument = {
                min = 0
            },
            name = "High-speed Wind Volume"
        }
    },
}

I.Settings.registerGroup {
    key = '4FPViewDynamicsVisualExtraSettings',
    page = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Extra Visuals',
    description = "For those of unusual tastes.",
    permanentStorage = true,
    settings = {
        {
            key = "BlackBarsRatio",
            renderer = "number",
            default = 0,
            argument = {
                min = 0
            },
            name = "Black Bars Ratio",
            description = "If > 0 - Cinematic black bars will appear upon locking a target. 2.2 is a good starting value."
        },
        {
            key = "StrafeRollStrength",
            renderer = "number",
            default = 0,
            argument = {
                
            },
            name = "Camera Roll Strength (Strafing)",
            description = "Subtly (or not so subtly) tilts the camera from side to side during strafing. 100 is a good starting value. Can be negative."
        },
        {
            key = "LookAroundRollStrength",
            renderer = "number",
            default = 0,
            argument = {
                
            },
            name = "Camera Roll Strength (Looking Around)",
            description = "Subtly (or not so subtly) tilts the camera from side to side when looking around. 100 is a good starting value. Can be negative."
        }
    },
}




-- Only does something with ReAnimation's FBA Compatibility folder loaded; the status line (rendered by
-- scripts/menu.lua) says whether it is.
I.Settings.registerGroup {
    key = '5FPViewDynamicsFBASettings',
    page = 'FPViewDynamicsPage',
    l10n = 'FPViewDynamics',
    name = 'Full Body Awareness Tweaks',
    description = "For OpenMW Full Body Awareness with ReAnimation's FBA Compatibility folder, where your body is visible in first person.",
    permanentStorage = true,
    settings = {
        {
            key = "FBAStatus",
            renderer = "DynamicCameraFBAStatus",
            default = "",
            name = "ReAnimation FBA Compatibility",
            description = "Found when ReAnimation_FBA_Compatibility.txt is in a loaded data folder."
        },
        {
            key = "LimitViewTiltMelee",
            renderer = "checkbox",
            default = true,
            name = "Limit Viewmodel Down Tilt: Melee",
            description = "Looking down, the hands ease to a stop at about 50 degrees while the camera keeps going, so they don't sink into the body. For melee weapons, fists and spells."
        },
        {
            key = "LimitViewTiltMarksman",
            renderer = "checkbox",
            default = false,
            name = "Limit Viewmodel Down Tilt: Marksman",
            description = "The same for bows, crossbows and throwing weapons. Off by default: shots follow the hands, so with the limit you can't shoot steeply down."
        },
        {
            key = "AdjustCameraLookingDown",
            renderer = "checkbox",
            default = true,
            name = "Adjust Camera Position When Looking Down",
            description = "Looking down, the camera eases forward (10 units by 85 degrees, starting at 20) so it clears the chest instead of looking into the armor's neck opening. Level view is untouched."
        }
    },
}

return {
    HighSpeedEffectsOpts = HighSpeedEffectsOpts
}
