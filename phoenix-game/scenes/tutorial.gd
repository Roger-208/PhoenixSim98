extends Control



func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menú.tscn") # Replace with function body.


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
