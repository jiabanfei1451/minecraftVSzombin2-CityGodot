extends Control
var 展开中 : bool = false
@export var 触摸控制器列表 : Array[触摸控制器] 
func _process(delta: float) -> void:
	var shp = RectangleShape2D.new()
	shp.size = size

func _on_touch_screen_button_pressed() -> void:
	展开()

func 展开():
	var te = create_tween()
	var te2 = create_tween()
	if 展开中 == false:
		展开中 = true
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 0.5),0.5).set_trans(Tween.TRANS_QUINT)
		te.tween_property($".","size",$VBoxContainer.size+$VBoxContainer.position,0.5).set_trans(Tween.TRANS_QUINT)
		for i in 触摸控制器列表:
			i.启用 = true
		
	else:
		展开中 = false
		te2.tween_property($"0","modulate",Color(1.0, 1.0, 1.0, 1.0),0.5).set_trans(Tween.TRANS_QUINT)
		te.tween_property($".","size",Vector2(138,26.08),0.5).set_trans(Tween.TRANS_QUINT)
		for i in 触摸控制器列表:
			i.启用 = false
func one():
	全局变量.窗口模式 = 0

func tuo():
	全局变量.窗口模式 = 4

func t2():
	全局变量.窗口模式 = 1

func t3():
	全局变量.窗口模式 = 2

func t4():
	全局变量.窗口模式 = 3

func _on___点击(button: 触摸控制器) -> void:
	$"../../../AudioStreamPlayer".play()
	var ints = int(button.name)
	if ints == 0:
		展开()
	if ints == 1:
		全局变量.窗口模式 = 0
	if ints == 2:
		全局变量.窗口模式 = 4
	if ints == 3:
		全局变量.窗口模式 = 1
	if ints == 4:
		全局变量.窗口模式 = 1
	if ints == 5:
		全局变量.窗口模式 = 3


func _on__抬起时void() -> void:
	pass # Replace with function body.
