extends Node2D
@onready var distancia: int = 0
@onready var sprite = $AnimatedSprite2D
@onready var fenix = $"../FenixPersonatge"
var velocitat: int = 5

func _ready():
	sprite.play("default")
	position = get_viewport_rect().size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("ruc: ", self.distancia)
	distancia += velocitat
	if (fenix.distancia > self.distancia):
		self.visible = false
	else:
		self.visible = true
