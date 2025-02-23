extends Node2D

# Parameters for the procedural generation
@export var seed: int = 0
@export var noise_scale: float = 0.1
@export var map_width: int = 1000
@export var map_height: int = 1000

# TileMap reference
var tilemap: TileMapLayer

# FastNoiseLite instance
var noise = FastNoiseLite.new()

func _ready():
	# Set up the noise generator
	noise.seed = seed
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale

	# Generate the terrain
	generate_terrain()

func generate_terrain():
	tilemap = $TileMapLayer

	for x in range(map_width):
		for y in range(map_height):
			var value = noise.get_noise_2d(x, y)
			if value > 0.5:
				tilemap.set_cell(x, y, 1) # Set to a specific tile index
			else:
				tilemap.set_cell(x, y, 0) # Set to another tile index
