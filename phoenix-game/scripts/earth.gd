extends Node2D

@export var velocitat_pajaro: float = 1.0
@export var temps_gir: float = 720.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if  Input.is_action_just_pressed("space"):
		velocitat_pajaro += 0.5
	
	print("temps rotacio: " + str((temps_gir/velocitat_pajaro)/60).substr(0, 4) + " min")
	rotation_degrees += (360 / (temps_gir / velocitat_pajaro)) * delta

	if velocitat_pajaro > 1:
		velocitat_pajaro *= 0.998
