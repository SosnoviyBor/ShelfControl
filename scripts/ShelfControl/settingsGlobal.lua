local I = require('openmw.interfaces')

I.Settings.registerGroup {
    key = 'ShelfControl_buyable',
    page = 'ShelfControl',
    l10n = 'ShelfControl',
    name = 'buyable_groupName',
    permanentStorage = true,
    order = 1,
    settings = {
        {
            key = 'supressBuyable',
            name = 'supressBuyable_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'buyableMinimumDisposition',
            name = 'buyableMinimumDisposition_name',
            renderer = 'number',
            integer = true,
            default = 101,
            min = 0,
            max = 101,
        },
    }
}

I.Settings.registerGroup {
    key = 'ShelfControl_owned',
    page = 'ShelfControl',
    l10n = 'ShelfControl',
    name = 'owned_groupName',
    permanentStorage = true,
    order = 2,
    settings = {
        {
            key = 'supressOwned',
            name = 'supressOwned_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'ownedMinimumDisposition',
            name = 'ownedMinimumDisposition_name',
            renderer = 'number',
            integer = true,
            default = 80,
            min = 0,
            max = 101,
        },
    }
}

I.Settings.registerGroup {
    key = 'ShelfControl_misc',
    page = 'ShelfControl',
    l10n = 'ShelfControl',
    name = 'misc_groupName',
    permanentStorage = true,
    order = 3,
    settings = {
        {
            key = 'enableMessages',
            name = 'enableMessages_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'ignoreBooksWithMWScripts',
            name = 'ignoreBooksWithMWScripts_name',
            renderer = 'checkbox',
            default = true,
        },
    }
}