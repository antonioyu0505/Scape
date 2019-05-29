extends Control

onready var dialogue_player = get_node("DialoguePlayer")
onready var button_next = get_node("Panel/HBoxContainer/Next")
onready var button_done = get_node("Panel/HBoxContainer/Done")
onready var text = get_node("Panel/Text")
onready var timer = get_node("Timer")

func _on_Next_pressed():
	dialogue_player.next()
	text.setText(dialogue_player.dialogue)
	timer.start()
	button_next.hide()

func _on_Text_finish():
	timer.stop()
	button_next.show()

func _on_DialoguePlayer_start():
	text.setText(dialogue_player.dialogue)
	timer.start()
	button_next.hide()
	button_done.hide()

func _on_DialoguePlayer_finish():
	button_next.hide()
	button_done.show()
	print("hello")
