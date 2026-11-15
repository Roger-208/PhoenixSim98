extends Control

var pausa3 = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pausa3 =  not pausa3
		
		
	if pausa3 == true:
		get_tree().paused = true
		self.visible = true
	else:
		self.visible = false
		get_tree().paused = false
