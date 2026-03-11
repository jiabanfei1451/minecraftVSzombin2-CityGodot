extends CanvasLayer
@export var 选定器械 : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	选定器械 = get_tree().current_scene.当前器械
	if 选定器械 != null:
		$"选定的卡槽".visible = true
		$"选定的卡槽".position = get_viewport().get_mouse_position()
	else:
		$"选定的卡槽".visible = false
