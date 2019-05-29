extends TileMap

enum cell_types { empty = -1, player, obstacle, object, stair}
var objects = []

func get_objects():
	for node in get_children():
		if(node.get_class() == "Node2D"):
			if node.type == object:
				objects.append(node)

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	var cell_target_type = get_cellv(cell_target)
	print(cell_target_type)
	match cell_target_type:
		empty: return update_actor(pawn, cell_start, cell_target)
		stair: return map_to_world(cell_target) + cell_size / 2

func update_actor(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, empty)
	return map_to_world(cell_target) + cell_size / 2

func hiding(flag):
	if(flag): $Polygon2D.show()
	else: $Polygon2D.hide()
	get_tree().paused = flag

#func _ready():
#	hiding(true)
#	get_objects()
#	print(objects)