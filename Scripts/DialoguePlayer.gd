extends Node

signal start()
signal finish(status)

var dialogues = []
var index = 0
var dialogue = ""
	
func next():
	index = index + 1
	if(index < dialogues.size()): dialogue = dialogues[index]
	
func startDialogue(note):
	dialogues = DialogueDatabase.load_dialogue(note + ".json").values()
	index = 0
	dialogue = dialogues[index]
	emit_signal("start")

func _on_Text_finish():
	if(index == dialogues.size() - 1): emit_signal("finish", "done")
	else: emit_signal("finish", "continue")
