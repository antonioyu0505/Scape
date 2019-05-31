extends RichTextLabel

signal finish()

func setText(text):
	set_bbcode(text)
	set_visible_characters(0)
	
func _input(event):
	if(Input.is_action_just_pressed("ui_accept") or event is InputEventMouseButton):
		if(visible_characters < get_total_character_count()): 
			set_visible_characters(get_total_character_count())
	
func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if(visible_characters > get_total_character_count()): emit_signal("finish")
