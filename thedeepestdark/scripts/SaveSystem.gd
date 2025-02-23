extends Node

@export var save_file_path: String = "user://save_game.dat"

func save_game(player_data: Dictionary, terrain_data: Dictionary):
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	var save_data = {
		"player": player_data,
		"terrain": terrain_data
	}
	file.store_var(save_data)
	file.close()

func load_game() -> Dictionary:
	if not FileAccess.file_exists(save_file_path):
		return {}

	var file = FileAccess.open(save_file_path, FileAccess.READ)
	var save_data = file.get_var()
	file.close()

	return save_data
