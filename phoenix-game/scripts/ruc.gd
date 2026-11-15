extends Node2D

@onready var sprite = $AnimatedSprite2D
@onready var phoenix = $"../../FenixPersonatge"
@export var velocitat_pajaro: float = 1.2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	sprite.position.x = screen_size.x/2
	sprite.position.y = screen_size.y/2.5

	sprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
