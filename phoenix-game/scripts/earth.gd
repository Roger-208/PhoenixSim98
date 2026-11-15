extends Node2D


@onready var fenix = $"../../FenixPersonatge"
@onready var ruc= $"../../pivot_ruc/Ruc"
@onready var pivot_ruc = $"../../pivot_ruc"

@export var temps_gir: float = 720.0

var fenix_pos = 0
var ruc_pos = 0

var fenix_completion = 0
var ruc_completion = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	fenix_pos += delta * fenix.velocitat_pajaro
	ruc_pos += delta * ruc.velocitat_pajaro

	ruc_completion = (ruc_pos/temps_gir)*360
	fenix_completion = (fenix_pos/temps_gir)*360

	
	if  Input.is_action_just_pressed("space"):
		fenix.velocitat_pajaro += 0.5
	
	print("Fenix: %.2f   Ruc: %.2f" %[fenix_completion, ruc_completion])
	
	#rotation_degrees += (360 / (temps_gir / fenix.velocitat_pajaro)) * delta
	rotation_degrees = fenix_completion
	pivot_ruc.rotation_degrees = fenix_completion - ruc_completion


	if fenix.velocitat_pajaro > 1:
		fenix.velocitat_pajaro *= 0.99
