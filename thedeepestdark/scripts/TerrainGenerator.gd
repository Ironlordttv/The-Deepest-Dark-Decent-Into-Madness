extends Node2D

# Parameters for the procedural generation (renamed 'seed' to avoid conflict)
@export var random_seed: int = 0  # Renamed from 'seed' to 'random_seed'
@export var noise_scale: float = 0.1
@export var map_width: int = 1000
@export var map_height: int = 1000

# TileMapLayer reference
@onready var tilemap = $TileMapLayer

# FastNoiseLite instance
var noise = FastNoiseLite.new()

func _ready():
	# Set up the noise generator
	noise.seed = random_seed  # Use the renamed variable
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale

	# Generate the terrain
	generate_terrain()

func generate_terrain():
	print("Generating terrain...")
	for x in range(map_width):
		for y in range(map_height):
			var value = noise.get_noise_2d(x, y)
			# Normalize noise value to range 0 to 1
			value = (value + 1) / 2
			# Set tiles based on noise value (using indices 0, 1, 2)
			if value > 0.75:
				tilemap.set_cell(Vector2i(x, y), 0, Vector2i(32, 21), 0)  # High terrain (index 2)
				print("Setting tile at (", x, ",", y, ") to high terrain")
			elif value > 0.5:
				tilemap.set_cell(Vector2i(x, y), 0, Vector2i(1, 0), 0)  # Medium terrain (index 1)
				print("Setting tile at (", x, ",", y, ") to medium terrain")
			else:
				tilemap.set_cell(Vector2i(x, y), 0, Vector2i(0, 0), 0)  # Low terrain (index 0)
				print("Setting tile at (", x, ",", y, ") to low terrain")
	print("Terrain generation complete.")
