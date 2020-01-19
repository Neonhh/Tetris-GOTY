extends Label

export (int) var paddingLength = 4

var start_value = 10

var value = 0

func _ready() -> void:
	update()
	
func reset():
	value = 0
	update()
	
func adjust(adjustment):
	value += adjustment
	update()
	
func update():
	$Value.text = ("%0*d" % [paddingLength, value])