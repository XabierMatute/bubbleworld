# BubbleWorld: Protogamejam

## Overview

**BubbleWorld: Protogamejam** is a game developed during the **Global Game Jam 2025**. It is a creative and technical endeavor that combines gameplay mechanics, visual design, and audio processing to deliver an engaging experience. The project was built using the **Godot Engine**, leveraging its scripting capabilities with GDScript and integrating web technologies for deployment.

The game revolves around a player navigating a bubble-themed world, interacting with various elements such as hooks, bullets, and environmental objects. The mechanics include movement, dashing, shooting, and dynamic interactions with other entities in the game world.

## Features

### Gameplay Mechanics
- **Player Movement**: Includes walking, jumping, and dashing, with air consumption mechanics tied to actions.
- **Combat**: Shooting bullets and interacting with enemies using hooks.
- **Health System**: Healing and damage mechanics, with visual feedback through animations.
- **Dynamic Scaling**: Bubble size changes based on air percentage, affecting gameplay.

### Visual Design
- **Animated Sprites**: Smooth animations for player actions like walking, dashing, and getting hit.
- **Environmental Interactions**: Reactive objects like walls and fish that respond to player actions.

### Audio Integration
- **Music Management**: Dynamic switching between soft and hard music based on game events.
- **Sound Effects**: Feedback for actions like hitting and healing.

### Web Deployment
- **HTML and JavaScript Integration**: A custom web interface for running the game, including status overlays and progress indicators.
- **Audio Worklet**: Advanced audio processing using JavaScript for seamless sound playback.

## Code Structure

### Core Gameplay
- **Player Logic**: [`player.gd`](bubbleworld/protogamejam/player.gd) handles movement, animations, health, and interactions.
- **Bullet Mechanics**: [`bullet.gd`](bubbleworld/protogamejam/bullet.gd) defines bullet behavior, including collision detection and damage application.
- **Hook System**: [`gancho.gd`](bubbleworld/protogamejam/gancho.gd) implements hook mechanics for environmental interaction.

### Environmental Objects
- **Reactive Walls**: [`y_mwallreactive.gd`](bubbleworld/protogamejam/placeholders/y_mwallreactive.gd) responds to player actions like dashing.
- **Fish Entities**: [`ballon_fish.gd`](bubbleworld/protogamejam/ballon_fish.gd) introduces dynamic enemy behavior.

### UI and Scene Management
- **HUD**: [`HUB.gd`](bubbleworld/protogamejam/HUB.gd) manages the user interface for starting and exiting the game.
- **Progress Bar**: [`barra.gd`](bubbleworld/protogamejam/barra.gd) visualizes bubble air percentage.

### Web Integration
- **Audio Worklet**: [`index.audio.worklet.js`](bubbleworld/protogamejam/build/web/index.audio.worklet.js) processes audio buffers for smooth playback.
- **HTML Interface**: [`index.html`](bubbleworld/protogamejam/build/web/index.html) provides the structure for the web-based game interface.

## Competencies Involved

### Technical Skills
- **Game Development**: Proficiency in Godot Engine and GDScript for creating gameplay mechanics.
- **Web Technologies**: HTML, CSS, and JavaScript for deploying the game on the web.
- **Audio Processing**: Implementing advanced audio systems using Audio Worklets.

### Creative Skills
- **Visual Design**: Crafting animations and sprites to enhance player immersion.
- **Level Design**: Designing interactive environments and challenges.

### Problem-Solving
- **Collision Detection**: Implementing robust systems for interactions between entities.
- **Resource Management**: Optimizing air consumption mechanics to balance gameplay.

### Collaboration
- **Teamwork**: Coordinating with other developers, artists, and designers during the Global Game Jam.
- **Time Management**: Delivering a functional game within the limited timeframe of the event.

## How to Run

1. Clone the repository.
2. Open the project in **Godot Engine**.
3. Run the main scene or deploy the game using the provided web interface.

## Play or Download

You can play or download the game at **[https://recursivelover.itch.io/youdrown](https://recursivelover.itch.io/youdrown)**.

## Game Jam Page

Visit the official **Global Game Jam 2025** page for this project at **[https://globalgamejam.org/games/2025/you-drown-7](https://globalgamejam.org/games/2025/you-drown-7)**.

## Acknowledgments

This project was created as part of the **Global Game Jam 2025**. Special thanks to the Godot Engine community for their support and resources.

Special thanks to:
- **Maia Lorente** for her incredible art.
- **Mikel Asla** for his help with the code and music. You can find his GitHub profile at **[https://github.com/masla-la](https://github.com/masla-la)**.
- **Jacob Lightfoot** for his creative direction and contributions to the music.