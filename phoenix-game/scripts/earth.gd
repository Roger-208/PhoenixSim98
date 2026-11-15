extends Node2D


@onready var fenix = $"../../FenixPersonatge"
@onready var ruc= $"../../pivot_ruc/Ruc"
@onready var pivot_ruc = $"../../pivot_ruc"
@onready var pivot_checkpoint_detras = $"../../pivot_checkpoints_detras"
@onready var pivot_checkpoint_delante = $"../../pivot_checkpoints_delante"
@onready var timer = $"../Planeta/Label"


@onready var pivot_ruc_icona = $"../pivot_ruc"
@onready var pivot_fenix_icona = $"../pivot_phoenix"


@export var temps_gir: float = 720.0

var rem_time_to_str = ""
var fenix_pos = 0
var ruc_pos = 0

var fenix_completion = 0
var ruc_completion = 0

var time = 0
var remaining_time = 0
var goback = false
var start_from_checkpoint = false
var last_checkpoint = 0
var rand_lounge_timer = randi_range(4,7)
var voltes = 0
var limit_vel_ruc = 1.2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func random_bird_lounge() -> void: 
	if rand_lounge_timer <= 0:
		rand_lounge_timer = randi_range(4,7)
		ruc.velocitat_pajaro += 3
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	voltes = int(fenix_completion/360)
	limit_vel_ruc = (voltes*0.1)+1.2
	print(voltes)
	rand_lounge_timer -= delta
	random_bird_lounge()
	
	time += delta
	remaining_time = int(360 - time)
	
	if remaining_time%60 > 9:
		rem_time_to_str = str(remaining_time/60) + ":" + str(remaining_time%60) 
	else:
		rem_time_to_str = str(remaining_time/60) + ":0" + str(remaining_time%60) 
	timer.text = rem_time_to_str
	
	if goback:
		fenix.velocitat_pajaro = (last_checkpoint*90 - fenix_completion)*4
		ruc.velocitat_pajaro = (last_checkpoint*90 - ruc_completion)*4
		
		if int(fenix_completion*10) == int(ruc_completion*10):
			fenix.velocitat_pajaro = 1
			ruc.velocitat_pajaro = 1.2
			goback = false

	fenix_pos += delta * fenix.velocitat_pajaro
	ruc_pos += delta * ruc.velocitat_pajaro


	ruc_completion = (ruc_pos/temps_gir)*360
	fenix_completion = (fenix_pos/temps_gir)*360


	pivot_fenix_icona.rotation_degrees = -fenix_completion
	pivot_ruc_icona.rotation_degrees = -ruc_completion


	
	if  Input.is_action_pressed("¡"):
		fenix.velocitat_pajaro *= 1.1

	#rotation_degrees += (360 / (temps_gir / fenix.velocitat_pajaro)) * delta
	rotation_degrees = fenix_completion
	pivot_checkpoint_detras.rotation_degrees = fenix_completion
	pivot_checkpoint_delante.rotation_degrees = fenix_completion

	pivot_ruc.rotation_degrees = fenix_completion - ruc_completion

	if int(ruc_completion/90) > 0 && (int(ruc_completion/90) > int(fenix_completion)/90):
		goback = true
		last_checkpoint = int(fenix_completion/90)

	if fenix.velocitat_pajaro > 1 && not goback:
		fenix.velocitat_pajaro *= 0.995
		
	if ruc.velocitat_pajaro > limit_vel_ruc && not goback:
		ruc.velocitat_pajaro *= 0.995
