extends TileMap

var gridSize: int   = 8
var dic: Dictionary = {}
enum Direction{UP, DOWN}
var matrix: Array[Variant] = []
var rows: int              = 8
var cols: int              = 8
var vaihto: bool           = false


func _ready():

	for x in gridSize:
		for y in gridSize:
			dic[str(Vector2(x, y))] = Direction.UP
			set_cell(0, Vector2(x, y), 0, Vector2i(0, 0), 0)

	for i in range(rows):
		var row: Array[Variant] = []
		for j in range(cols):
			row.append(0)  # Initialize with 0 or any default value
		matrix.append(row)


func _process(delta):
	randomize()
	var random_x: int = randi() % 9
	var random_y: int = randi() % 9

	if vaihto:
		set_cell(0, Vector2(random_x, random_y), 0, Vector2i(0, 0), 0)
		vaihto = false
	else:
		set_cell(0, Vector2(random_x, random_y), 0, Vector2i(0, 0), 2)
		vaihto = true

	var tile: Vector2i = local_to_map(get_global_mouse_position())

	for x in gridSize:
		for y in gridSize:
			erase_cell(1, Vector2(x, y))

	if dic.has(str(tile)):
		if dic[str(tile)] == Direction.UP:
			set_cell(1, tile, 0, Vector2i(0, 0), 1)
		if dic[str(tile)] == Direction.DOWN:
			set_cell(1, tile, 0, Vector2i(0, 0), 3)


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var tile: Vector2i = local_to_map(event.position)
		print("Mouse Click at: ", local_to_map(event.position))

		if dic.has(str(tile)):
			if dic[str(tile)] == Direction.UP:
				set_cell(0, tile, 0, Vector2i(0, 0), 2)
				dic[str(tile)] = Direction.DOWN
			elif dic.has(str(tile)):
				if dic[str(tile)] == Direction.DOWN:
					set_cell(0, tile, 0, Vector2i(0, 0), 0)
					dic[str(tile)] = Direction.UP
