extends Control
var 展开中 : bool = false

func _process(delta: float) -> void:
	var shp = RectangleShape2D.new()
	shp.size = size
	$TouchScreenButton.position = size / 2
	$TouchScreenButton.shape = shp


func _on_button_点击时(button: Button) -> void:
	var ints = int(button.name)
	if ints == 0:
		展开()
	if ints == 1:
		rande
	if ints == 2:
		全局变量.窗口模式 = 4
	if ints == 3:
		全局变量.窗口模式 = 1
	if ints == 4:
		全局变量.窗口模式 = 2
	if ints == 5:
		全局变量.窗口模式 = 3
func _on_touch_screen_button_pressed() -> void:
	展开()

func 展开():
	var te = create_tween()
	var te2 = create_tween()
	if 展开中 == false:
		展开中 = true
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 0.0),0.5).set_trans(Tween.TRANS_QUINT)
		te.tween_property($".","size",$VBoxContainer.size+$VBoxContainer.position,0.5).set_trans(Tween.TRANS_QUINT)
	else:
		展开中 = false
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 1.0),0.5).set_trans(Tween.TRANS_QUINT)
		te.tween_property($".","size",Vector2(85,26),0.5).set_trans(Tween.TRANS_QUINT)
