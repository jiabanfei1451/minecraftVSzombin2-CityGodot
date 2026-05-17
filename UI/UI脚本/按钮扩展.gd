extends 触摸控制器
signal _点击(button:触摸控制器)
func _ready() -> void:
	抬起时void.connect(_on_pressed)
func _on_pressed() -> void:
	emit_signal("点击时",$".")
