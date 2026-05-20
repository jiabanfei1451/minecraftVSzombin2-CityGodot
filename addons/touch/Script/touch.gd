@tool
@icon("uid://dittpp2ukt1lg")
extends Control
## 适用于可多指触控设备点击操作按钮
class_name Touchbutton
signal 按下时(name:String)
signal 抬起时(name:String)
signal 点击时(name:String)
signal 长按时(name:String)
signal 按下时void
signal 抬起时void
signal 点击时void
signal 长按时void

@export_group("触摸按钮")
@export var Shape : Shape2D
@export var 偏移 : Vector2
@export var 自动设置 : bool = true
@export var 短按阈值 : float = 0.2
@export var 长按阈值 : float = 1
@export_enum("矩形:0","圆形:1","圆形取Y:2","椭圆:3") var 自动设置形状 : int = 0
@export var 按下纹理 : StyleBoxTexture = preload("uid://c4ffe4u1spmqk")
@export var 抬起纹理 : StyleBoxTexture = preload("uid://ciadyrsksiodo")
@export_group("物体状态")
@export var 纹理物体 : Panel
@export var 物体纹理 : StyleBoxTexture
var pre : bool = false
var pretime : float = 0
var 触摸控制器 : TouchScreenButton
func _ready() -> void:
	var 生成触摸 = TouchScreenButton.new()
	add_child(生成触摸)
	生成触摸.position = Vector2(0,0)
	theme = preload("uid://dvka2rktyelip")
	生成触摸.pressed.connect(按下)
	生成触摸.released.connect(抬起)
	触摸控制器 = 生成触摸
	
	var 生成纹理物体 = Panel.new()
	生成纹理物体.add_theme_stylebox_override("panel",抬起纹理)
	add_child(生成纹理物体)
	纹理物体 = 生成纹理物体
	
func _process(delta: float) -> void:
	var 形状
	if pre == true:
		pretime += delta
	else:
		pretime = 0
	if 纹理物体 != null:
		纹理物体.size = size
		物体纹理 = 纹理物体.get_theme_stylebox("panel")
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
	pre = true
	emit_signal("按下时",name)
	emit_signal("按下时void")
	纹理物体.add_theme_stylebox_override("panel",按下纹理)
func 抬起():
	if pretime <= 短按阈值:
		emit_signal("点击时",name)
		emit_signal("点击时void")
	else:
		if pretime >= 长按阈值:
			emit_signal("长按时",name)
			emit_signal("长按时void")
	pre = false
	emit_signal("抬起时",name)
	emit_signal("抬起时void")
	纹理物体.add_theme_stylebox_override("panel",抬起纹理)
