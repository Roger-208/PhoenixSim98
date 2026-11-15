extends Label

@onready var timer: Timer = $Timer
@onready var aEscriure = ""
@onready var lletresPossibles: String = "abyeznoiuvptw"
@onready var lletraToTextura: Dictionary = {
	"a": preload("res://images/Alfabeto/alpha.png"),
	"b": preload("res://images/Alfabeto/beta.png"),
	"n": preload("res://images/Alfabeto/eta.png"),
	"y": preload("res://images/Alfabeto/gamma.png"),
	"i": preload("res://images/Alfabeto/iota.png"),
	"u": preload("res://images/Alfabeto/mu.png"),
	"v": preload("res://images/Alfabeto/nu.png"),
	"w": preload("res://images/Alfabeto/omega.png"),
	"p": preload("res://images/Alfabeto/rho.png"),
	"e": preload("res://images/Alfabeto/sigma.png"),
	"t": preload("res://images/Alfabeto/tau.png"),
	"o": preload("res://images/Alfabeto/theta.png"),
	"z": preload("res://images/Alfabeto/zeta.png")
}

@onready var numeroLletres: int = lletresPossibles.length()
@onready var fenix = $"../../FenixPersonatge"
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

func _draw() -> void:
	var tamany: Vector2 = Vector2(64, 64)
	var separacio: float = 10.0

	var amplada_total = aEscriure.length() * (tamany.x + separacio) - separacio
	var inici_x = (size.x / 2.0 - amplada_total / 2.0)

	for i in range(aEscriure.length()):
		var lletra = aEscriure[i]
		var textura: Texture2D = lletraToTextura[lletra]

		var posicio = Vector2(
			inici_x + i * (tamany.x + separacio),
			(size.y - tamany.y*1.9)
		)

		draw_texture_rect(
			textura,
			Rect2(posicio, tamany),
			false
		)

func _process(_delta: float) -> void:
	queue_redraw()

func _on_timeout() -> void:
	if first:
		if len(aEscriure) < 5:
			aEscriure += lletresPossibles[randi() % numeroLletres]
		else:
			first = false
	elif len(aEscriure) == 0:
		first = true

		fenix.velocitat_pajaro += 100
