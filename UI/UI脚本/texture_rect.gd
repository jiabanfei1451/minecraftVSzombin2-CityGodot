extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_tree().current_scene.使用星之碎片 == true:
		visible = true
		position = get_viewport().get_mouse_position() + Vector2(-20,-20)
	else: visible = false
	if Input.is_action_just_pressed("右键"):
		if get_tree().current_scene.使用星之碎片 == true:
			get_tree().current_scene.使用星之碎片 = false
