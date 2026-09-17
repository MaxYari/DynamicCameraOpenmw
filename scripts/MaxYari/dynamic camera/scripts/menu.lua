-- Menu context: setting renderers can only be registered here.
local I = require('openmw.interfaces')
local util = require('openmw.util')
local vfs = require('openmw.vfs')

-- Marker file at the root of ReAnimation's FBA Compatibility folder.
local FBA_MARKER = "ReAnimation_FBA_Compatibility.txt"

-- Status line of the Full Body Awareness Tweaks section: green when the compatibility folder is
-- loaded, yellow when it is not (and the section does nothing).
I.Settings.registerRenderer('DynamicCameraFBAStatus', function()
    local detected = vfs.fileExists(FBA_MARKER)
    return {
        template = I.MWUI.templates.textNormal,
        props = {
            text = detected and "Detected - this section works"
                or "Not detected - this section does nothing",
            textColor = detected and util.color.rgb(0.35, 0.9, 0.35) or util.color.rgb(1, 0.85, 0.2),
        },
    }
end)

return {}
