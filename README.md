# Project Structure

  2D top-down game built with Godot Engine, likely version 4.x given the .gdextension files and typical modern Godot project layout.

  Core Godot Files:

   * project.godot: The main project configuration file. Contains essential settings, autoloads,
     scene paths, and resource configurations.
   * export_presets.cfg: Configuration for exporting the game to different platforms (e.g.,
     Windows, Linux, Android).
   * icon.svg, icon.svg.import: The project's icon.
   * test.tscn: A scene file, possibly for testing specific features or mechanics.
   * Game.exe: An executable, likely a build of the game for Windows.

  Standard Godot Directories:

   * .godot/: This is an internal Godot cache directory. It stores imported assets, shader caches,
     editor settings, and other temporary files. You generally don't modify files directly in here.
   * autoload/: Contains global scripts (singletons) that are loaded at project startup and
     accessible from anywhere in the game.
       * ConfigUtils.gd: Likely handles game configuration settings.
       * PlayerData.gd: Probably manages player-specific data like stats, inventory, or progress.
       * Utils.gd: A general utility script with common functions.
       * server/: Might contain scripts related to network communication or backend interactions if
         this game has online features.
   * audio/: Stores all sound effects and music.
       * bgm/: Background music files.
       * bullet/: Bullet firing/impact sounds.
       * equip/: Equipment-related sounds (e.g., equipping an item).
       * Various .wav files: Individual sound effects for hits, movement, gunshots, etc.
   * fonts/: Custom font files used in the UI or game world.
   * game/: This seems to be the main game logic and scene directory.
       * BaseFrame.gd: A base script, possibly for defining common behavior for game frames or
         states.
       * Game.tscn: The main game scene where the core gameplay takes place.
       * attachments/, bullets/, equip/, guns/, hero/, items/, map/, monster/, npc/, other/,
         reward/, survival_effect/, survival_skill/: These subdirectories strongly suggest a
         modular organization for various game entities and systems. For example, hero/ for player
         character scripts/scenes, monster/ for enemy definitions, guns/ for weapon mechanics, map/
         for level data, and items/ for collectible objects.
   * joystick/: Contains resources for a virtual joystick, likely for touch input on mobile
     platforms or as an alternative input method.
   * shader/: Custom shaders used for visual effects.
       * Monster1.gdshader, Monster1.tres: A shader specific to monsters (e.g., for unique visual
         effects or highlighting).
       * SmoothPixel.shader, SmoothPixel.tres: A shader likely used to achieve a smooth pixel art
         look, possibly for scaling or anti-aliasing.
   * Sprites/: All image assets (textures, spritesheets).
   a
   * translation/: Contains files for game localization.
       * text.csv: Source for translated text.
       * text.en.translation, text.zh_CN.translation: Translated text files for English and
         Simplified Chinese, respectively.
   * ui/: User Interface scenes and scripts.
       * ControlUI.gd, ControlUI.tscn: A scene and script for general UI control.
       * GameUI.gd: Script for the in-game HUD or UI elements.
       * Inventory.gd, Inventory.tscn: Scene and script for the player's inventory system.
       * MainUI.gd, MainUI.tscn: The main menu or primary UI scene.
       * ModeSelect.gd, ModeSelect.tscn: A scene for selecting game modes.
       * ModUI.gd, ModUI.tscn: UI for modifying items or skills.
       * SettingUI.gd, SettingUI.tscn: UI for game settings.
       * theme.tres: The main UI theme resource, defining styles, fonts, and colors.
       * WeaponAmItem.gd: A script likely for handling weapon and ammunition UI items.
       * snow/: Possibly UI elements or effects related to snow (e.g., a snowy background for a
         menu).
       * widgets/: Reusable UI components.

  Addons:
   * addons/: External plugins or modules that extend Godot's functionality.
       * godotsteam/: An integration for Steamworks API, suggesting the game might use Steam
         features (achievements, leaderboards, etc.).
       * nklbdev.aseprite_importers/: An addon for importing Aseprite files directly into Godot,
         explaining the presence of .ase files in Sprites/.
       * scene_manager/: A custom scene management addon, possibly for easier transitions between
         scenes or loading/unloading game states.

  Other:

   * .git/, .gitattributes, .gitignore: Git version control files.
   * README.md: Project description and instructions.
   * steam_appid.txt: Used for testing Steam integration locally.
