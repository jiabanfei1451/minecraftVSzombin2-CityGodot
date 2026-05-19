@tool
@icon("uid://dittpp2ukt1lg")
extends Control
## 适用于可多指触控设备点击操作按钮
class_name 触控按钮
signal 按下时(name:String)
signal 抬起时(name:String)

@export var Shape : Shape2D
@export var 偏移 : Vector2
@export var 自动设置 : bool = true
@export_enum("矩形:0","圆形:1","圆形取Y:2","椭圆:3") var 自动设置形状 : int = 0
var 触摸控制器 : TouchScreenButton

func _ready() -> void:
	var 生成触摸 = TouchScreenButton.new()
	add_child(生成触摸)
	生成触摸.position = Vector2(0,0)
	
	生成触摸.pressed.connect(按下)
	生成触摸.released.connect(抬起)
	
	触摸控制器 = 生成触摸

func _process(delta: float) -> void:
	var 形状
	if 自动设置 == true:
		if 自动设置形状 == 0:
			形状 = RectangleShape2D.new()
			形状.size = size
		elif 自动设置形状 == 1:
			形状 = CircleShape2D.new()
			形状.radius = size.x
		elif 自动设置形状 == 2:
			形状= CircleShape2D.new()
			形状.radius= size.y
		elif 自动设置形状 == 3:
			形状= CapsuleShape2D.new()
			形状.radius= size.x
			形状.height= size.y
		if 触摸控制器 != null:
			触摸控制器.shape = 形状
			偏移 = size / 2
			触摸控制器.position = 偏移
	else:
		触摸控制器.position = 偏移
		触摸控制器.shape = Shape

func 按下():
	emit_signal("按下时",name)
func 抬起():
	emit_signal("抬起时",name)
