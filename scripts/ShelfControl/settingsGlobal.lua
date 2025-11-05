local I = require('openmw.interfaces')

I.Settings.registerGroup {
    key = 'ShelfControl_buyable',
    page = 'ShelfControl',
    l10n = 'ShelfControl_settings',
    name = 'buyable_groupName',
    description = 'buyable_groupDescription',
    permanentStorage = true,
    order = 1,
    settings = {
        {
            key = 'supress',
            name = 'supressBuyable_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'minDisposition',
            name = 'buyableMinimumDisposition_name',
            description = 'buyableMinimumDisposition_description',
            renderer = 'number',
            integer = true,
            default = 101,
            min = 1,
            max = 101,
        },
    }
}

I.Settings.registerGroup {
    key = 'ShelfControl_owned',
    page = 'ShelfControl',
    l10n = 'ShelfControl_settings',
    name = 'owned_groupName',
    description = 'owned_groupDescription',
    permanentStorage = true,
    order = 2,
    settings = {
        {
            key = 'supress',
            name = 'supressOwned_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'minDisposition',
            name = 'ownedMinimumDisposition_name',
            description = 'ownedMinimumDisposition_description',
            renderer = 'number',
            integer = true,
            default = 80,
            min = 1,
            max = 101,
        },
    }
}

I.Settings.registerGroup {
    key = 'ShelfControl_messages',
    page = 'ShelfControl',
    l10n = 'ShelfControl_settings',
    name = 'messages_groupName',
    description = 'messages_groupDescription',
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
            key = 'buyableLowDisposition',
            name = 'buyableLowDisposition_name',
            renderer = 'number',
            integer = true,
            default = 30,
            min = -1,
        },
        {
            key = 'buyableGenericMsgWeight',
            name = 'buyableGenericMsgWeight_name',
            renderer = 'number',
            default = 30,
            min = 0,
        },
        {
            key = 'buyableUnlockableMsgWeight',
            name = 'buyableUnlockableMsgWeight_name',
            renderer = 'number',
            default = 1,
            min = 0,
        },
        {
            key = 'buyableRacialMsgWeight',
            name = 'buyableRacialMsgWeight_name',
            renderer = 'number',
            default = 10,
            min = 0,
        },
        {
            key = 'buyableFactionMsgWeight',
            name = 'buyableFactionMsgWeight_name',
            renderer = 'number',
            default = 10,
            min = 0,
        },
        {
            key = 'buyableSpecificMsgWeight',
            name = 'buyableSpecificMsgWeight_name',
            renderer = 'number',
            default = 100,
            min = 0,
        },
    }
}

I.Settings.registerGroup {
    key = 'ShelfControl_misc',
    page = 'ShelfControl',
    l10n = 'ShelfControl_settings',
    name = 'misc_groupName',
    permanentStorage = true,
    order = 100,
    settings = {
        {
            key = 'modEnabled',
            name = 'modEnabled_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'enableMessages',
            name = 'enableMessages_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'enableCellWhitelist',
            name = 'enableCellWhitelist_name',
            description = 'enableCellWhitelist_description',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'ignoreBooksWithMWScripts',
            name = 'ignoreBooksWithMWScripts_name',
            renderer = 'checkbox',
            default = true,
        },
        {
            key = 'ignoreScrolls',
            name = 'ignoreScrolls_name',
            renderer = 'checkbox',
            default = false,
        },
        {
            key = 'enableDebug',
            name = 'enableDebug_name',
            renderer = 'checkbox',
            default = false,
        },
    }
}