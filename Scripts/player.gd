extends "pawn.gd"

signal finish()

onready var Grid = get_parent()
var looking_direction = Vector2()

# TODO: Update function for the animation when the character turns #

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func _process(delta):
	var input_direction = get_input_direction()
	if(not input_direction): return
	looking_direction = input_direction
	var target_position = Grid.request_position(self, input_direction, "move")
	var direction = player_direction(input_direction)
	update_direction(direction)
	if(target_position): move_to(target_position, direction)

func _input(event):
	if(Input.is_action_just_pressed("ui_accept")):
		if(looking_direction): Grid.request_position(self, looking_direction, "interact")
#		if(direction): Grid.request_position(self, direction, "interact")
	
func player_direction(input_direction):
	var direction
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
	
	# Move the node to the target position and the Pivot to the previous position #
	position = target_position
	$Pivot.position = - move_direction * 64
	
	# Animate the movement from the previous position to the target position #
	$Tween.interpolate_property($Pivot, "position", $Pivot.position, Vector2(),
	$AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	
	# Yields the process to the animation player.
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
	emit_signal("finish")