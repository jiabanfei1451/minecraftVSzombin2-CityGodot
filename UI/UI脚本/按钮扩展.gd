extends Button
signal 点击时(button:Button)
func _ready() -> void:
	pressed.connect(_on_pressed)
func _on_pressed() -> void:
	emit_signal("点击时",$".")
