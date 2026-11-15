extends Control
var esta_pausado = false
var escape = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		esta_pausado =  not esta_pausado
		
	print(esta_pausado)
	if esta_pausado == true:
		get_tree().paused = esta_pausado
		
		self.visible = true
	else:
		self.visible = false
		get_tree().paused = esta_pausado
