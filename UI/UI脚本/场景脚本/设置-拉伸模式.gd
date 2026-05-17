extends Control
var 展开 : bool = true
@export var 触摸控制 : Array[触摸控制器]
func _展开() -> void:
	$"../../../AudioStreamPlayer".play()
	var te = create_tween()
	var te2 = create_tween()
	if 展开 == false:
		te.tween_property($".","size",Vector2(150,26.08),0.5).set_trans(Tween.TRANS_QUART)
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 1.0),0.75).set_trans(Tween.TRANS_SINE)
		展开 = true
	else:
		te.tween_property($".","size",$VBoxContainer.size + $VBoxContainer.position + Vector2(2,2),0.5).set_trans(Tween.TRANS_QUART)
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 0.5),0.75).set_trans(Tween.TRANS_SINE)
		展开 = false

func _on__抬起时(event: InputEvent, 控制器: 触摸控制器) -> void:
	$"../../../AudioStreamPlayer".play()
	if 控制器.name == "1":
		全局变量.窗口拉伸模式 = 0
	if 控制器.name == "2":
		全局变量.窗口拉伸模式 = 1
	if 控制器.name == "3":
		全局变量.窗口拉伸模式 = 2
