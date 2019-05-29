extends RichTextLabel

onready var box = get_parent()
var dialogs = Dialogs.getDialog()
func _ready():
	set_bbcode(dialogs1[page])
	set_visible_characters(0)

func _input(event):
	if(Input.is_action_just_pressed("ui_accept")):
		if(get_visible_characters() > get_total_character_count()):
			if(page < dialogs1.size() - 1):
				page = page + 1
				set_bbcode()
				set_visible_characters(0)
			else: box.dialogEnd(false)
		else: set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	if(get_visible_characters() > get_total_character_count()): box.pageEnd(true)
	else: box.pageEnd(false)
