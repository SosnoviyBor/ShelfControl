# Shelf Control (OpenMW)

Book ownership actually matters now. Paid books need to be bought. Strangers won't let you browse their shelves for free.

_Formerly known as "No Money, No Books"._

I rarely buy books in shops unless it's for a quest. And Jobasha? He has way too many skill books just sitting there, waiting. That's 1275 gold (mercantile tax not included) you're robbing from him.

Also - you wouldn't appreciate it if a stranger barged into your home, grabbed a book off the shelf, and sat there for hours reading it. Let's change it.

## Features

### Shops Are Not Libraries

In book shops you need to actually buy books before reading them.  
A book is considered buyable if:

- It has a living NPC owner (unloaded NPCs don't count)
- The owner sells books

By default the only option to read a buyable book is to actually buy it, but you can enable an additional disposition check in the settings. Then if your disposition with bookseller is high enough, he might allow you to read it.

### Other People's Homes Are Not Libraries

Regular people won't charge you. They also won't let you touch their personal shelves. Maybe if you befriend them, they'll be less restrictive?

A book is considered owned if:

- OR it has a living NPC owner (unloaded NPCs don't count as owners)
  - It will be available to read if owner's disposition is high enough (configurable, 80 by default)
- OR it is faction-owned
  - It will be available to read only when you advance far enough in the faction that it becomes free for you (vanilla behavior, unaffected by the mod)

### Libraries Might Actually Be Libraries

It wouldn't make sense if you couldn't read in places that encourage reading. These include:

- **Libraries** - cell name contains `library`
- **Temples** - cell name contains `temple`
- **Imperial cult shrines, chapels, etc**
  - OR cell name contains `chapel`
  - OR cell name contains `shrine`
  - OR the book is owned by a member of the Imperial Cult faction / a `Priest` class NPC AND the cell has an Imperial shrine (any activator with `shrineimperial` script)

### Context-sensitive In-Game Messages

Vendors will yell at you!  
You will question your actions!  
Ordinators will call you scum for a reason now!  
And so much more...

## Requirements

You need to play on one of the supported languages:

- English

If you want to add support for other languages, you need to translate only the `ShelfControl_cells` part of localization (which is just a couple lines long - messages are completely optional for the core functionality).

## Compatibility

Books with scripts attached to them are ignored by default, so it shouldn't conflict with any mwscripts. Though, it's toggleable if you feel particularly risky.

Might conflict with other lua mods that alter owned book activation (similar to this mod). Though I haven't encountered any yet.

Confirmed to be compatible:

- [OpenMW Animated Pickup and Shop Around](https://www.nexusmods.com/morrowind/mods/54585) by **taitechnic** - Doesn't affect books at all
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Alters only unowned books

## Known Issues

Since you can no longer open buyable books, to steal them you'll need to do it with open inventory using the cursor. And due to current limitations of Lua API this cannot be changed yet. The best I can offer is an option to disable restrictions for scrolls so far.

## Other Mods to Enhance Your Reading Experience

- [trav's OpenMW Books Enhanced](https://www.nexusmods.com/morrowind/mods/55126) by **trav** - Replaces the book/scroll in-game UI with a custom one mimicking the vanilla look, but with additional features like adjustable size.
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Lets you pick up a book without opening it first.
- [Dead Mer Tell No Tales](https://www.nexusmods.com/morrowind/mods/57431) by **Sosnoviy Bor (me 😳)** - Clears object ownership if their owner suddenly ceases to exist.
- [The Spell Tomes - Magic Books of Morrowind to Study and Cast to](https://www.nexusmods.com/morrowind/mods/57432) by **Hyancinth** - Adds spell tomes that you can use for learning spells.

## Credits

**Sosnoviy Bor** - Author  
**BCEMXAXA** - Cover artwork  
**Hyancinth** - Message writing