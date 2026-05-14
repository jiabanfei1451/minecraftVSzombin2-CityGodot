extends Button


@export var arrow = load("res://arrow.png")
var beam = load("res://arrow(City).png")


func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow)

	# Changes a specific shape of the cursor (here, the I-beam shape).
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	Input.set_custom_mouse_cursor(arrow)
