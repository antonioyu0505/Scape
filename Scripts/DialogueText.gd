extends RichTextLabel

signal finish()

func setText(text):
	set_bbcode(text)
	set_visible_characters(0)
	
func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if(visible_characters > get_total_character_count()):
		emit_signal("finish")
