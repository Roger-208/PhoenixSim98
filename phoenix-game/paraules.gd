extends Label
@onready var timer: Timer = $Timer
@onready var aEscriure = ""
@onready var lletresPossibles: String = "abyeznoiuvptw"
@onready var numeroLletres: int = lletresPossibles.length()
@onready var speed = $"../../Background/Node2D"
var first: bool = true


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	timer.timeout.connect(_on_timeout)
	timer.start(0.1)

func _input(event):
	if aEscriure.length() > 0:
		if aEscriure[0] == "a" and event.is_action_pressed("alfa"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "b" and event.is_action_pressed("beta"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "y" and event.is_action_pressed("gamma"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "e" and event.is_action_pressed("sigma"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "z" and event.is_action_pressed("zeta"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "n" and event.is_action_pressed("eta"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "o" and event.is_action_pressed("theta"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "i" and event.is_action_pressed("iota"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "u" and event.is_action_pressed("mu"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "v" and event.is_action_pressed("nu"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "p" and event.is_action_pressed("rho"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "t" and event.is_action_pressed("tau"):
			aEscriure = aEscriure.substr(1)
		elif aEscriure[0] == "w" and event.is_action_pressed("omega"):
			aEscriure = aEscriure.substr(1)
		
		
func _process(delta: float) -> void:
	var testNou: String = ""
	for lletra in aEscriure:
		testNou += lletra + " "
	
	self.text = testNou


func _on_timeout() -> void:
	if first:
		if len(aEscriure) < 5:
			aEscriure += lletresPossibles[randi() % numeroLletres]
		else:
			first = false
	elif len(aEscriure) == 0:
		first = true
		speed.velocitat_pajaro += 100
		
		
