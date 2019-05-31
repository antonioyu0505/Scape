extends TileMap

enum cell_types { empty = -1, player, obstacle, object, note, stair}
var noteName
var reading = false
var changeScene = false
onready var dialogueBox = get_node("CanvasLayer/DialogueBox")
export (String, FILE, "*.tscn") var world_scene

func get_note(coordinates):
	for node in get_children():
		if(node.get_class() == "Node2D"):
			if(world_to_map(node.position) == coordinates): 
				noteName = node.name
				if("Trap" in noteName): noteName = "Trap"

func request_position(pawn, direction, request):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	var cell_target_type = get_cellv(cell_target)
	if(request == "move"):
		match cell_target_type:
			empty: return map_to_world(cell_target) + cell_size / 2
			stair: 
				changeScene = true
				return map_to_world(cell_target) + cell_size / 2
			player: return map_to_world(cell_target) + cell_size / 2
			note:
				get_note(cell_target)
				reading = true
				return map_to_world(cell_target) + cell_size / 2
				
	elif(request == "interact"):
		match cell_target_type:
			obstacle:
				get_note(cell_target)
				read_note()

func read_note():
	dialogueBox.start(noteName)
	get_tree().paused = true

func _on_DialogueBox_end():
	get_tree().paused = false
	reading = false
	if("Correct" in noteName):
		if(self.has_node("Wall")):
			set_cellv(world_to_map($Wall.position), empty)
			$Wall.queue_free()
	elif("Trap" in noteName):
		get_tree().reload_current_scene()

func _on_Player_finish():
	if(reading): read_note()
	elif(changeScene): get_tree().change_scene(world_scene)

func _ready():
	if(get_parent().name == "World1"):
		noteName = "start"
		read_note()
