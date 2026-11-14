
extends Node2D

@export var tile_esquina: Texture2D = preload("res://assets/ponerLetras/parte_0.png")
@export var tile_esquina_2: Texture2D = tile_esquina
@export var tile_horizontal: Texture2D = preload("res://assets/ponerLetras/parte_1.png")
@export var tile_vertical: Texture2D = preload("res://assets/ponerLetras/parte_2.png")

@export var tam_tile: int = 64

# Escala de las texturas
@export var escala_tile: float = 2.0

# Proporción de pantalla que ocupará el menú
@export_range(0.1, 1.0) var proporcion: float = 0.5


func _ready():
	queue_redraw()


func _draw():
	if not tile_esquina or not tile_horizontal or not tile_vertical:
		return

	var pantalla = get_viewport_rect().size

	# Tamaño real de cada tile después de escalar
	var tam_real = tam_tile * escala_tile

	# Tamaño del menú
	var ancho = pantalla.x * proporcion
	var alto = pantalla.y * proporcion

	# Centrar menú
	var columnas = int(ancho / tam_real)
	var filas = int(alto / tam_real)

	# Evitar tamaños demasiado pequeños
	columnas = max(columnas, 2)
	filas = max(filas, 2)

	# Ajustar el menú a un número entero de tiles
	ancho = columnas * tam_real
	alto = filas * tam_real

	var inicio = Vector2(
		(pantalla.x - ancho) / 2,
		(pantalla.y - alto) / 2
	)

	# Esquina superior izquierda (0 grados)
	draw_texture_rect(tile_esquina,
		Rect2(inicio, Vector2(tam_real, tam_real)), false)

	# Esquina superior derecha (90 grados)
	draw_set_transform(
		inicio + Vector2(columnas * tam_real, 0),
		deg_to_rad(90),
		Vector2(escala_tile, escala_tile)
	)
	draw_texture(tile_esquina, Vector2.ZERO)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

	# Esquina inferior izquierda (270 grados)
	draw_set_transform(
		inicio + Vector2(0, filas * tam_real),
		deg_to_rad(270),
		Vector2(escala_tile, escala_tile)
	)
	draw_texture(tile_esquina, Vector2.ZERO)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

	# Esquina inferior derecha (180 grados)
	draw_set_transform(
		inicio + Vector2(columnas * tam_real, filas * tam_real),
		deg_to_rad(180),
		Vector2(escala_tile, escala_tile)
	)
	draw_texture(tile_esquina, Vector2.ZERO)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

	# Bordes superior e inferior
	for x in range(1, columnas - 1):
		draw_texture_rect(tile_horizontal,
			Rect2(inicio + Vector2(x * tam_real, 0),
			Vector2(tam_real, tam_real)), false)

		draw_texture_rect(tile_horizontal,
			Rect2(inicio + Vector2(x * tam_real,
			(filas - 1) * tam_real),
			Vector2(tam_real, tam_real)), false)

	# Bordes izquierdo y derecho
	for y in range(1, filas - 1):
		draw_texture_rect(tile_vertical,
			Rect2(inicio + Vector2(0, y * tam_real),
			Vector2(tam_real, tam_real)), false)

		draw_texture_rect(tile_vertical,
			Rect2(inicio + Vector2((columnas - 1) * tam_real,
			y * tam_real), Vector2(tam_real, tam_real)), false)
