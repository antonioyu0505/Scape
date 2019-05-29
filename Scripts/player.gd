extends "pawn.gd"

onready var Grid = get_parent()

# TODO: Update function for the animation when the character turns #

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _process(delta):
	# Puts the pivot position on the node position #
	$Pivot.position = Vector2()
	var input_direction = get_input_direction()
	if not input_direction: return
	var target_position = Grid.request_move(self, input_direction)
	var direction = player_direction(input_direction)
	update_direction(direction)
	if(target_position): move_to(target_position, direction)
	
func player_direction(input_direction):
	var direction = "right"
	if(input_direction.x == 1): direction = "right"
	elif(input_direction.x == -1): direction = "left"
	elif(input_direction.y == 1): direction = "down"
	elif(input_direction.y == -1): direction = "up"
	return direction
	
func update_direction(direction):
	$AnimationPlayer.play("idle_" + direction)

func move_to(target_position, direction):
	set_process(false)
	$AnimationPlayer.play("walk_" + direction)
	# Calculates the position to which the sprite will move #
	var move_direction = (target_position - position).normalized()
	# Animate the movement from the current position to the target position #
	$Tween.interpolate_property($Pivot, "position", Vector2(), move_direction * 64,
	$AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)

	$Tween.start()
	# Yields the process to the animation player.
	yield($AnimationPlayer, "animation_finished")
	# Move the sprite instantly to the target position #
	position = target_position
	#yield($Pivot/AnimatedSprite, "animation_finished")
	set_process(true)