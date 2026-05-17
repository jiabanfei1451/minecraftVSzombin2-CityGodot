extends Control
var 展开 : bool = true
@export var 触摸控制器列表 : Array[触摸控制器] = []
func _ready() -> void:
	for i in 触摸控制器列表:
		i.启用 = false
func _xnxn():
	pass
func _x800x600() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,80)
	get_window().size = Vector2i(800,600)
func _x1152x648() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,80)
	get_window().size = Vector2i(1152,648)
func _x1280x720() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,80)
	get_window().size = Vector2i(1280,720)
func _x1680x900() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,80)
	get_window().size = Vector2i(1680,900)
func _x1920x1080() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,80)
	get_window().size = Vector2i(1920,1080)
func _屏幕分辨率() -> void:
	$"../../../AudioStreamPlayer".play()
	get_window().position = Vector2i(0,0)
	get_window().size = DisplayServer.screen_get_size()



func _展开() -> void:
	$"../../../AudioStreamPlayer".play()
	var te = create_tween()
	var te2 = create_tween()
	if 展开 == false:
		te2.tween_property($"展开","modulate",Color(1.0, 1.0, 1.0, 1.0),0.75).set_trans(Tween.TRANS_SINE)
		te.tween_property($".","size",Vector2(138,26.08),0.75).set_trans(Tween.TRANS_QUART)
		展开 = true
		for i in 触摸控制器列表:
			i.启用 = false
	else:
		te2.tween_property($"展开","modulate",Color(1.0, 1.0, 1.0, 0.0),0.75).set_trans(Tween.TRANS_SINE)
		te.tween_property($".","size",$VBoxContainer.position + $VBoxContainer.size,0.75).set_trans(Tween.TRANS_QUART)
		展开 = false
		for i in 触摸控制器列表:
			i.启用 = true
	print(展开)
