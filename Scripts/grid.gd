extends TileMap

enum cell_types { empty = -1, player, obstacle, object, note, stair}
var noteName
var reading = false
onready var dialogueBox = get_node("DialogueBox")
				
func get_note(coordinates):
	for node in get_children():
		if(node.get_class() == "Node2D"):
			if(world_to_map(node.position) == coordinates): noteName = node.name

func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		empty: return map_to_world(cell_target) + cell_size / 2
		stair: return map_to_world(cell_target) + cell_size / 2
		player: return map_to_world(cell_target) + cell_size / 2
		note:
			reading = true
			get_note(cell_target)
			return map_to_world(cell_target) + cell_size / 2

func update_actor(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, empty)
	return map_to_world(cell_target) + cell_size / 2

func read_note():
	dialogueBox.start(noteName)
	get_tree().paused = true
	
func _on_DialogueBox_end():
	get_tree().paused = false
	reading = false
#	if(not notes.empty()):
#		var object = objects.pop_front()
#		set_cellv(world_to_map(object.position), empty)
#		objects.pop_front().queue_free()
	

func _on_Player_finish():
	if(reading): read_note()
