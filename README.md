# MVP specification

1. Core gameplay Binding of Isaac (BoI)
2. 2D only for MVP
2. Player go through dungeon stages to fight enemy. The dungeons are larger than BoI, instead of rooms, it will be floors.
3. Enemy mechanics 99% similar to BoI, all behaviour and sprites are similar
4. No shooting
5. Shooting is replaced with attacks and skill shots/placements.


## Pacing

A game sessions is 1-1.5 hours for experienced player, or 2-3 for beginners or when learning the game. This is a casual game.
Each floor is 10-15 minutes. Each stage has 2-4 floors.


# Current task list
**Create an MVP similar to BoI**
    
All tasks below includes:
- uses Godot 4.5
- setting up gdscript, tscn scene file, assigning assets and integrating them together
- all scripts are modular for imports and extensible for modification, ie: if currently enemy can only chase and damage player by collision, we can add enemy shooting projectile to the current enemy gdscript.
- setting up placeholder graphics and sprites
- the work results in a godot 4.5 project with no runtime or compile errors.

1. **Setup enemy - setup all behaviours similar to BoI enemy**
  - enemy state machine
    - idle
    - patrol
    - agro
    - chase
    - attack (damage by collission)
    - hit
    - dead
  - enemy navigation mesh
  - enemy sprite including for each state above
  - enemy attack
  - enemy hp
  - enemy spawn (random)

2. **Setup player**
  - player state machine (extendable for other states)
    - idle
    - walk (run)
    - attack
    - hit
    - dead
    - invul
    - action (skill 1,2,3,n)
    - action (special 1,2,3,n)
  - player attack
  - player hp
  - player invul frame and animation (simple blink)
  - player stats
    - hp
    - mp
    - gold (current)
  - access to player save profile state  
  
3. **Setup objects**  
  - object spawn (random)
  - object sprite
  - object state machine
    - idle
    - destroyed
  - object collision
    
3. **Setup stage (single floor)**
  - Tile Set and Tile Map
    - assign tile set via gdscript
  - Tile collision
  - Wall collision
  - Navigation2D and NavigationMesh
  
4. **Setup camera**
  - follow player
  - zoom in and out

5. **Setup controls**
  - wasd
  - click to attack
  - mouse scroll for zoom
  
6. **Setup global game state**
  - Global state
  - Stage/map state
    - gold
    - enemy killed
  - Player save profiles/states (multiple, JSON)
  - Save game (state)
  
  {
    "profile_name": "Player1",
    "level": 5,
    "score": 12345,
    "inventory": ["sword", "shield", "potion"],
    "settings": {
      "volume": 75,
      "difficulty": "normal"
    },
    "last_save_time": "2025-12-14T15:30:00"
  }    

6. **Setup UI**
  - Start
  - Restart
  - Save
  - Exit (close)
  
Below is project structure from chatgpt, please follow this as a general guideline  
  
  root
  │
  ├── assets/              # All your game assets (textures, sounds, music, etc.)
  │   ├── characters/
  │   ├── environment/
  │   ├── ui/
  │   ├── tiles/
  │   └── sounds/
  │
  ├── scenes/              # All your game scenes
  │   ├── main_menu/       # Main menu scenes (start, options, profile selection)
  │   ├── gameplay/        # Gameplay scenes (gameplay, levels)
  │   ├── game_over/       # Game over or win scenes
  │   └── hud/             # HUD-related scenes (UI elements)
  │
  ├── scripts/             # All your game scripts
  │   ├── game_states/     # Game state management scripts
  │   ├── profiles/        # Player profile scripts (save/load, profile management)
  │   ├── ui/              # UI management scripts
  │   ├── player/          # Player character scripts
  │   ├── enemies/         # Enemy AI scripts
  │   ├── items/           # Item-related scripts
  │   └── utils/           # Utility scripts (helpers, constants, etc.)
  │   └── data/            # Store JSONs
  │
  ├── savegames/           # Player profile save files (json, sqlite, etc.)
  │   ├── profile1.json    # Save file for profile 1
  │   ├── profile2.json    # Save file for profile 2
  │   └── settings.json    # Global game settings
  │
  └── global/              # Global data and state
      ├── global.gd        # Global script (e.g., managing singleton or auto-loaded data)
      └── constants.gd     # Global constants (e.g., game modes, difficulty levels)
