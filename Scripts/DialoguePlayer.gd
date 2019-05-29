extends Node

signal finish()
signal start()

var dialogues = []
var index = 0
var dialogue = ""
	
func next():
	index = index + 1
	if(index < dialogues.size()):
		update()

func update():
	dialogue = dialogues[index]
	if(index == dialogues.size() - 1): emit_signal("finish")

func _on_Start_pressed():
	dialogues = DialogueDatabase.load_dialogue("start.json").values()
	index = 0
	dialogue = dialogues[index]
	emit_signal("start")