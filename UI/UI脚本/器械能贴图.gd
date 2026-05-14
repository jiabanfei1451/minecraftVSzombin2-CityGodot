extends "res://UI/UI脚本/texture_rect.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += 5 * delta
	if get_tree().current_scene.使用器械能 == true:
		visible = true
		position = get_viewport().get_mouse_position() + Vector2(-20,-20)
	else: visible = false
	if Input.is_action_just_pressed("右键"):
		if get_tree().current_scene.使用器械能 == true:
			get_tree().current_scene.使用器械能 = false
