return {
    capabilities = {
        general = {
            -- positionEncodings = { "utf-8", "utf-16", "utf-32" }  <--- this is the default
            positionEncodings = { "utf-16" }
        },
    },
    init_options = {
        settings = {
            lint = {
                ignore = { "E741" },
                extendSelect = { "W", "COM", "ICN" },
            },
        },
    },
}
