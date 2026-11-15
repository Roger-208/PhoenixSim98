
extends Label

@onready var timer: Timer = $Timer
@onready var aEscriure = ""

@onready var pi = "3141592653589793238462643383279502884197169399375105820974944592307816406286208998628034825342117067982148086513282306647093844609550582231725359408128481117450284102701938521105559644622948954930381964428810975665933446128475648233786783165271201909145648566923460348610454326648213393607260249141273724587006606315581748184881520920962829254091715364367892590360011330530548820466521384146951941511609"

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
	"pi": preload("res://images/Alfabeto/pi.png"),
	"z": preload("res://images/Alfabeto/zeta.png")
}

@onready var numeroLletres: int = lletresPossibles.length()
@onready var fenix = $"../../FenixPersonatge"

var first: bool = true

# MODE ESPECIAL PI
var mode_pi: bool = false
var probabilitat_pi: float = 0.12
var posicio_pi: int = 0

# CONTROL DE RISTRES NORMALS
var ristra_correcta: bool = true


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	timer.timeout.connect(_on_timeout)
	timer.start(0.1)


func _input(event):
	if not event is InputEventKey:
		return

	if not event.pressed or event.echo:
		return

	# =================================
	# MODE ESPECIAL PI
	# =================================

	if mode_pi:
		var digit_premut = -1

		if event.keycode >= KEY_0 and event.keycode <= KEY_9:
			digit_premut = event.keycode - KEY_0

		elif event.keycode >= KEY_KP_0 and event.keycode <= KEY_KP_9:
			digit_premut = event.keycode - KEY_KP_0

		if digit_premut == -1:
			return

		var digit_correcte = int(pi[posicio_pi])

		if digit_premut == digit_correcte:

			# Mini boost per cada dígit correcte
			fenix.velocitat_pajaro += 1.5

			posicio_pi += 1

			# Preparar el següent dígit
			if posicio_pi >= pi.length():
				posicio_pi = 0

			aEscriure = pi.substr(posicio_pi, 1)

		else:
			# Error: acabar esdeveniment PI
			mode_pi = false
			aEscriure = ""
			first = true
			ristra_correcta = true

		return

	# =================================
	# MODE NORMAL
	# =================================

	if aEscriure.length() > 0:

		var lletra_correcta = false

		if aEscriure[0] == "a" and event.is_action_pressed("alfa"):
			lletra_correcta = true
		elif aEscriure[0] == "b" and event.is_action_pressed("beta"):
			lletra_correcta = true
		elif aEscriure[0] == "y" and event.is_action_pressed("gamma"):
			lletra_correcta = true
		elif aEscriure[0] == "e" and event.is_action_pressed("sigma"):
			lletra_correcta = true
		elif aEscriure[0] == "z" and event.is_action_pressed("zeta"):
			lletra_correcta = true
		elif aEscriure[0] == "n" and event.is_action_pressed("eta"):
			lletra_correcta = true
		elif aEscriure[0] == "o" and event.is_action_pressed("theta"):
			lletra_correcta = true
		elif aEscriure[0] == "i" and event.is_action_pressed("iota"):
			lletra_correcta = true
		elif aEscriure[0] == "u" and event.is_action_pressed("mu"):
			lletra_correcta = true
		elif aEscriure[0] == "v" and event.is_action_pressed("nu"):
			lletra_correcta = true
		elif aEscriure[0] == "p" and event.is_action_pressed("rho"):
			lletra_correcta = true
		elif aEscriure[0] == "t" and event.is_action_pressed("tau"):
			lletra_correcta = true
		elif aEscriure[0] == "w" and event.is_action_pressed("omega"):
			lletra_correcta = true

		var accions = [
			"alfa", "beta", "gamma", "sigma", "zeta",
			"eta", "theta", "iota", "mu", "nu",
			"rho", "tau", "omega"
		]

		for accio in accions:

			if event.is_action_pressed(accio):

				if lletra_correcta:
					aEscriure = aEscriure.substr(1)

				else:
					# Error en mode normal
					ristra_correcta = false

				break


func _draw() -> void:
	var tamany: Vector2 = Vector2(64, 64)
	var separacio: float = 10.0

	if mode_pi:

		var textura: Texture2D = lletraToTextura["pi"]

		var amplada_total = tamany.x
		var inici_x = (size.x / 2.0 - amplada_total / 2.0)

		var posicio = Vector2(
			inici_x,
			(size.y - tamany.y * 1.9)
		)

		draw_texture_rect(
			textura,
			Rect2(posicio, tamany),
			false
		)

	else:

		var amplada_total = aEscriure.length() * (tamany.x + separacio) - separacio
		var inici_x = (size.x / 2.0 - amplada_total / 2.0)

		for i in range(aEscriure.length()):

			var lletra = aEscriure[i]
			var textura: Texture2D = lletraToTextura[lletra]

			var posicio = Vector2(
				inici_x + i * (tamany.x + separacio),
				(size.y - tamany.y * 1.9)
			)

			draw_texture_rect(
				textura,
				Rect2(posicio, tamany),
				false
			)


func _process(_delta: float) -> void:
	queue_redraw()


func _on_timeout() -> void:

	# Si estem en mode PI, no generar lletres normals
	if mode_pi:
		return

	if first:

		# Comprovar PI nomes al començar una ristra nova
		if aEscriure.is_empty():

			if randf() < probabilitat_pi:

				mode_pi = true
				posicio_pi = 0
				aEscriure = pi.substr(posicio_pi, 1)
				first = false
				return

		if len(aEscriure) < 5:

			aEscriure += lletresPossibles[randi() % numeroLletres]

		else:
			first = false

	elif len(aEscriure) == 0:

		# Boost de la ristra normal
		if ristra_correcta:
			fenix.velocitat_pajaro += 100

		# Preparar una nova ristra
		ristra_correcta = true
		first = true
