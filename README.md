# Dune: Imperium ultimate organizer

[Русская версия](README_RU.md)

This organizer for the "Dune: Imperium" board game is designed to accommodate the base game as well as the expansions "Immortality" and "Rise of Ix," along with various community expansions.

## Modules and their placement in the organizer

### Base Game

1. Player tokens and starting cards are placed in the player box.
2. Empire cards are placed in the empire card box, which can be used during the game.
3. Intrigue cards are placed in the intrigue card box, which can be used during the game.
4. Alliance tokens, the Mentat token, and Baron tokens are placed in the "Setup" box.
5. Hagal house cards are placed in the "Hagal" tray, which can be used during the game.
6. Conflict cards are placed in the "Conflict" tray.
7. The cards "The Spice Must Flow," "Folded Space," and "Arrakis Liason" are placed in the corresponding sections of the triple tray for permanent market cards.

## The Rise of the Ix

1. Additional player tokens and starting cards are placed in the player boxes.
2. Additional empire and intrigue cards are placed in the corresponding boxes and separated by the "Ix" divider.
3. Technology tokens are placed in the "Ix tech" tray, which can be used on the game board.

## Immortality

1. Additional player tokens and starting cards are placed in the player boxes.
2. Additional empire and intrigue cards are placed in the corresponding boxes and separated by the "Im" divider.
3. Tleilaxu market cards and the "Research Station" token are placed in the "Tleilaxu market" tray, which can be used during the game.

### Fifth Player
Can be used in multiple modules. Placed in a separate box like the main players.

### M1: Community expansion

[Expansion discussion](https://boardgamegeek.com/thread/2589878/dune-imperium-community-expansion)

1. The board is placed on top of the main board.
2. Cards are placed in the empire card box and separated by the M1 divider.
3. Intrigue cards are placed in the intrigue card box and separated by the M1 divider.
4. Replacement starting cards are placed in the player boxes.
5. Additional cubes are placed in the player boxes in the Flags section.
6. The distorted Mentat token, faction alliance tokens, and Baron tokens are placed in the setup box.

### M2: 5p. variant

[Expansion discussion](https://boardgamegeek.com/thread/2935395/5p-variant-v2/page/1)

1. Cell tokens are placed in the empire card box and separated by the M2 divider.
2. A garrison token for the 5th player can also be placed here.

### M3: Leaders 
Several sources

1. Leader boards are placed in the leader board box.
2. For leader boards with 100-micron protectors, a bottomless box is provided, as there was not enough space. In the absence of protectors, the standard version of the box can be used.

### M4: Chausumea
[Expansion discussion](https://boardgamegeek.com/thread/2726109/di-expansion-chausumea)

1. Starting cards are placed in the player boxes.
2. Empire cards are placed in the empire card box and separated by the M4 divider.
3. The Forgiving Argument) is placed in the corresponding tray.

### M5: Arrakeen scouts

[Expansion discussion](https://boardgamegeek.com/filepage/230587/arrakeen-scout-mode-card-conversion)

1. Event and deal cards, etc., are placed in the Events box.
2. Round tokens are placed in the "Round tokens" section of the round and prophecy tokens tray.

### M6: Subcommitties

[Expansion discussion](https://boardgamegeek.com/filepage/277259/subcommitties-card-deck-variant)

1. Committee tokens are placed in the "Committee" tray.

### M7: Fulfillment of Prophecies

1. Prophecy cards are placed in the "Prophecies" section of the round and prophecy tokens tray.

### M8: Weather on Arrakis
1. Harvest prohibition tokens are placed in the WEATHER section of the weather and conflict cards tray.
2. Weather cards are placed in the WEATHER section on top of the tokens.

### M9: Spice Cards: New Card Deck for Making Spice Harvesting Dangerous

[Expansion discussion](https://boardgamegeek.com/filepage/221389/spice-cards-new-card-deck-for-making-spice-harvest)

1. Spice cards are placed in the "Spice harvest" tray.

### Tear-off Notebook

Placed somewhere

### Shai-Hulud Token

1. The worm token is placed in the empire card box.

## Build

For build, the make-like tool [oak-build](https://github.com/kirillsulim/oak-build) is used.

```sh
oak build
```

.stl files will be in the `./build` directory.

However, there is a problem with the separation of some trays, causing them to break into several parts. 
Therefore, manual import from OpenSCAD is recommended for problematic components.

## Acknowledgments

This project uses:

1. The OpenSCAD library [The-Boardgame-Insert-Toolkit](https://github.com/dppdppd/The-Boardgame-Insert-Toolkit).
2. The font [Dune Rise](https://fontmeme.com/fonts/dune-rise-font/).
