extends Polygon2D

var continueDialog = "Press %s to continue."
var continueKey = "Spacebar"
var fullContinue = continueDialog % continueKey
onready var Grid = get_parent()

func _ready():
	$Label.text = fullContinue
	
func pageEnd(end):
	if(end): $Label.show()
	else: $Label.hide()

func dialogEnd(end):
	Grid.hiding(end)