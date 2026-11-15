extends Control
@export var esta_pausado = false

func _process(delta: float) -> void:
	
		
	print(esta_pausado)
	if esta_pausado == true:
		get_tree().paused = esta_pausado
		
		self.visible = true
	else:
		self.visible = false
		get_tree().paused = esta_pausado
