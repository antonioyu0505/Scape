extends Position2D

onready var parent = get_parent()

func _ready():
	update_angle()

func _physics_process(delta):
	update_angle()

func update_angle():
	rotation = parent.looking_direction.angle()
