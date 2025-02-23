extends Control

# Reference to the Player scene
@export var player_scene: PackedScene
# Reference to the Terrain scene
@export var terrain_scene: PackedScene

# Player instance
var player: CharacterBody2D

func _ready():
	# Initialize the game world
	initialize_game_world()

func initialize_game_world():
	# Instance and add the player to the game world
	player = player_scene.instantiate()
	$GameWorld.add_child(player)
	player.position = Vector2(0, 0) # Set initial player position

	# Instance and add the terrain to the game world
	var terrain = terrain_scene.instantiate()
	$GameWorld.add_child(terrain)
