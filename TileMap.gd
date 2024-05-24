extends TileMap

var gridSize = 8
var dic = {}

enum Direction{UP, DOWN}

func _ready():
	
	for x in gridSize:
		for y in gridSize:
			dic[str(Vector2(x, y))] = Direction.UP
			set_cell(0, Vector2(x,y), 0,Vector2i(0,0) ,0)
			
	print(dic)

func _process(delta):
	#print(1 / delta, " FPS")
	var tile = local_to_map(get_global_mouse_position())
	
	for x in gridSize:
		for y in gridSize:
			erase_cell(1, Vector2(x,y))
	
	if dic.has(str(tile)):
		if dic[str(tile)] == Direction.UP:
			set_cell(1, tile, 0, Vector2i(0,0), 1)
		if dic[str(tile)] == Direction.DOWN:
			set_cell(1, tile, 0, Vector2i(0,0), 3)
		 
func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var tile = local_to_map(event.position)
		print("Mouse Click at: ", local_to_map(event.position))
		
		if dic.has(str(tile)):
			if dic[str(tile)] == Direction.UP:
				set_cell(0, tile, 0, Vector2i(0,0), 2)
				dic[str(tile)] = Direction.DOWN
			elif dic.has(str(tile)):
				if dic[str(tile)] == Direction.DOWN:
					set_cell(0, tile, 0, Vector2i(0,0), 0)
					dic[str(tile)] = Direction.UP
