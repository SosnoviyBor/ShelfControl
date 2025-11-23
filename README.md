# Shelf Control (OpenMW)

Book ownership actually matters now. Paid books need to be bought. Strangers won't let you browse their shelves for free.

_Formerly known as "No Money, No Books"._

I rarely buy books in shops unless it's for a quest. And Jobasha? He has way too many skill books just sitting there, waiting. That's 1275 gold (mercantile tax not included) you're robbing from him.

Also - you wouldn't appreciate it if a stranger barged into your home, grabbed a book off the shelf, and sat there for hours reading it. Let's change it.

## Features

### Shops Are Not Libraries

In bookshops, you actually need to buy books before reading them.  
A book is considered buyable if:

- It has a living NPC owner (unloaded NPCs don't count)
- The owner sells books

By default, the only way to read a buyable book is to purchase it, but you can enable an additional disposition check in the settings. If your disposition with the bookseller is high enough, they may allow you to read it.

### Other People's Homes Are Not Libraries

Regular folks won't charge you, but they also won't let you touch their personal shelves. Maybe if you befriend them, they'll be less restrictive?

A book is considered owned if:

- It has a living NPC owner (unloaded NPCs don't count)
  - It becomes readable if the owner's disposition is high enough (configurable, 80 by default)
- OR it is faction-owned and someone from that faction is nearby
  - It becomes readable only when your rank is high enough for the faction to treat its items as free for you (vanilla behavior, unchanged)
  - Books owned by Temple and Imperial Cult are free to read. All PT factions are supported too.

### Libraries Might Actually Be Libraries

It wouldn't make sense if you couldn't read in places designed for reading. These include:

- **Libraries** - cell name contains `library`
- **Temples** - cell name contains `temple`
- **Imperial cult shrines, chapels, etc.**
  - Cell name contains `chapel` or `shrine`
  - OR the cell has an Imperial shrine (any activator with the `shrineimperial` script) **and** the book is owned by an Imperial Cult member or a `Priest`-class NPC

### Context-sensitive In-Game Messages

Vendors will yell at you!  
You will question your actions!  
Ordinators will call you scum - for a reason this time!  
And much more...

## Requirements

You need to play in one of the supported languages:

- English

If you want to add support for more languages, you only need to translate the `ShelfControl_cells` part of the localization (which is just a few lines).

## Compatibility

Books with scripts attached to them are ignored by default, so it shouldn't conflict with any mwscripts. Though, it's toggleable if you feel particularly brave.

Might conflict with other lua mods that alter owned book activation (similar to this mod). Though I haven't encountered any yet.

Confirmed compatible:

- [OpenMW Animated Pickup and Shop Around](https://www.nexusmods.com/morrowind/mods/54585) by **taitechnic** - Doesn't affect books at all
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Alters only unowned books
- TR, SHotN, PC by **Project Tamriel Team** - Explicit support for factions and classes added by these mods
- - [trav's OpenMW Books Enhanced](https://www.nexusmods.com/morrowind/mods/55126) by **trav** - Read indicator doesn't appear if access to the book is denied

## Known Issues

Since you can no longer open certain owned books, you'll need to steal them via open inventory using the cursor. Due to current Lua API limitations, this cannot be changed yet. The best I can offer for now is an option to disable restrictions for scrolls/paper/newsletters/etc.

## Other Mods to Enhance Your Reading Experience

- [trav's OpenMW Books Enhanced](https://www.nexusmods.com/morrowind/mods/55126) by **trav** - Replaces the book/scroll in-game UI with a custom one mimicking the vanilla look, but with additional features like adjustable size.
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Lets you pick up a book without opening it first.
- [Dead Mer Tell No Tales](https://www.nexusmods.com/morrowind/mods/57431) by **Sosnoviy Bor (me 😳)** - Clears object ownership if their owner suddenly ceases to exist.
- [The Spell Tomes - Magic Books of Morrowind to Study and Cast to](https://www.nexusmods.com/morrowind/mods/57432) by **Hyacinth** - Adds spell tomes that you can use for learning spells.

## Credits

**Sosnoviy Bor** - Author  
**BcemXaxa** - Cover artwork  
**Hyacinth** - Message writing
