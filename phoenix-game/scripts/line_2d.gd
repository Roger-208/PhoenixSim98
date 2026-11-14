extends Line2D

@export var radi: float = 200.0
@export var punts: int = 64

func _ready() -> void:
	texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
	texture_mode = Line2D.LINE_TEXTURE_TILE
	closed = true
	for i in punts:
		var angle := TAU * i / punts
		add_point(Vector2(radi, 0).rotated(angle))
