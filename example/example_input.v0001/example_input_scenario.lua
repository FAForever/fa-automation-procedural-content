version = 3 -- Lua Version. Dont touch this
ScenarioInfo = {
    name = "Rally Point Survival",
    description = "",
    preview = '',
    map_version = 1,
    type = 'skirmish',
    starts = true,
    size = {1024, 1024},
    reclaim = {432985.5, 0},
    map = '/maps/example_input.v0001/example_input.scmap',
    save = '/maps/example_input.v0001/example_input_save.lua',
    script = '/maps/example_input.v0001/example_input_script.lua',
    norushradius = 40,
    Configurations = {
        ['standard'] = {
            teams = {
                {
                    name = 'FFA',
                    armies = {'ARMY_1', 'ARMY_2', 'ARMY_3', 'ARMY_4'}
                },
            },
            customprops = {
                ['ExtraArmies'] = STRING( 'ARMY_17 NEUTRAL_CIVILIAN Civilians' ),
            },
        },
    },
}
