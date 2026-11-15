extends Control

var esta_pausado = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		esta_pausado =  not esta_pausado
		
		
	if esta_pausado == true:
		get_tree().paused = true
		self.visible = true
	else:
		self.visible = false
		get_tree().paused = false
