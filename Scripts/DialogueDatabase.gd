extends Node

#export (String, FILE, "*.json") var dialogue_file_path
const DIALOGUE_PATH = "res://Dialogues/"

func load_dialogue(file_path):
	var file = File.new()
	assert file.file_exists(DIALOGUE_PATH + file_path)
	
	file.open(DIALOGUE_PATH + file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue
