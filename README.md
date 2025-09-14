# Shelf Control (OpenMW)

Book ownership actually matters now. Paid books need to be bought. Strangers won't let you browse their shelves for free.

_Formerly known as "No Money, No Books"._

I rarely buy books in shops unless it's for a quest. And Jobasha? He has way too many skill books just sitting there, waiting. That's 1275 gold (mercantile tax not included) you're robbing from him.

Also - you wouldn't appreciate it if a stranger barged into your home, grabbed a book off the shelf, and sat there for hours reading it. Let's change it.

## Features

### Shops Are Not Libraries

In book shops you need to actually buy books before reading them.  
A book is considered buyable if:

- It has a living NPC owner (unloaded NPCs don't count as owners)
- The owner sells books
- It is not faction-owned

### Other People's Homes Are Not Libraries

Regular people won't charge you. They also won't let you touch their personal shelves. Maybe if you befriend them, they'll be less restrictive?

A book is considered owned if:

- It is faction-owned, OR
- It has a living NPC owner (unloaded NPCs don't count as owners)

### Libraries Might Actually Be Libraries

It wouldn't make sense if you couldn't read in places that encourage reading. These include:

- **Libraries** - cell name contains `library`
- **Temples** - cell name contains `temple`
- **Imperial cult shrines, chapels, etc**
  - cell name contains `chapel`
  - cell name contains `shrine`
  - OR the book is owned by a member of the Imperial Cult faction / a `Priest` class NPC AND the cell has an Imperial shrine (any activator with `shrineimperial` script)

### Context-sensitive In-Game Messages

[TODO]

## Requirements

OpenMW, duh.

## Installation

Install like any other OpenMW mod.

## Compatibility

Books with scripts attached to them are ignored by default, so it shouldn't conflict with any mwscripts.

Might conflict with other lua mods that alter owned book activation (similar to this mod). Though I haven't encountered any yet.

Confirmed to be compatible:

- [OpenMW Animated Pickup and Shop Around](https://www.nexusmods.com/morrowind/mods/54585) by **taitechnic** - Doesn't affect books
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Alters only unowned books

## Known Issues

Since you can no longer open buyable books, to steal them you'll need to do it with open inventory using the cursor.  
Yes, this is intended.  
No, it will not be changed (sneak status is not exposed to the Lua API yet).

## Other Mods to Enhance Your Reading Experience

- [trav's OpenMW Books Enhanced](https://www.nexusmods.com/morrowind/mods/55126) by **trav** - Replaces the book/scroll in-game UI with a custom one mimicking the vanilla look, but with additional features like adjustable size.
- [Book Pickup](https://www.nexusmods.com/morrowind/mods/46625) by **NullCascade and Zackhasacat** - Lets you pick up a book without opening it first
- [Dead Mer Tell No Tales](https://www.nexusmods.com/morrowind/mods/57431) by **Sosnoviy Bor (me 😳)** - Clears object ownership if their owner suddenly ceases to exist

## Credits

**Sosnoviy Bor** - Author  
**BCEMXAXA** - Cover artwork
