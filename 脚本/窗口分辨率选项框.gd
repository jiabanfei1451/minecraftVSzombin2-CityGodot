extends Control
var 展开 : bool = true
func _ready() -> void:
	var d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = str(DisplayServer.screen_get_size())
	d.pressed.connect(_屏幕分辨率)
	d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = "1920x1080"
	d.pressed.connect(_x1920x1080)
	d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = "1680x900"
	d.pressed.connect(_x1680x900)
	d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = "1280x720"
	d.pressed.connect(_x1280x720)
	d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = "1152x648"
	d.pressed.connect(_x1152x648)
	d = Button.new()
	d.theme = preload("res://UI/UI主题/MC主题.tres")
	$VBoxContainer.add_child(d)
	d.text = "800x600"
	d.pressed.connect(_x800x600)
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
		te.tween_property($".","size",Vector2(134.667,27),0.5).set_trans(Tween.TRANS_QUART)
		te2.tween_property($Button,"modulate",Color(1.0, 1.0, 1.0, 1.0),0.75).set_trans(Tween.TRANS_SINE)
		展开 = true
	else:
		te.tween_property($".","size",$VBoxContainer.size + $VBoxContainer.position + Vector2(2,2),0.5).set_trans(Tween.TRANS_QUART)
		te2.tween_property($Button,"modulate",Color(1.0, 1.0, 1.0, 0.5),0.75).set_trans(Tween.TRANS_SINE)
		展开 = false
