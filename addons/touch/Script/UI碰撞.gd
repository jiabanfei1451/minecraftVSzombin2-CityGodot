@tool
@icon("uid://dv7arjysyybky")
extends ReferenceRect
class_name UI碰撞箱

signal _UI进入时(UI:Control)
signal _UI离开时(UI:Control)

@export var 碰撞箱 : Shape2D
@export var 自设置碰撞箱:bool = true
@export var DEBUG:bool
@export var 除数:float = 2
var Body:CharacterBody2D
var collis:CollisionShape2D

var area:Area2D
var areacollis:CollisionShape2D
func _ready() -> void:
	add_to_group("UI判定")
	var iboad = CharacterBody2D.new()
	iboad.position = Vector2(0,0)
	iboad.add_to_group("UI判定")
	add_child(iboad)
	var co = CollisionShape2D.new()
	iboad.add_child(co)
	
	Body = iboad
	collis = co
	
	var areabo = Area2D.new()
	areabo.add_to_group("UI判定")
	add_child(areabo)
	var col = CollisionShape2D.new()
	areabo.add_child(col)

	areabo.body_entered.connect(_isui)
	areabo.body_exited.connect(_isexui)

	area = areabo
	areacollis = col
func _process(delta: float) -> void:
	if Body != null and collis != null:
		if 自设置碰撞箱 == true:
			var rec = RectangleShape2D.new()
			碰撞箱 = rec
			rec.size = size
		collis.shape = 碰撞箱
		Body.position = size / 除数
	if area != null and areacollis != null:
		if 自设置碰撞箱 == true:
			var rec = RectangleShape2D.new()
			碰撞箱 = rec
			rec.size = size
		areacollis.shape = 碰撞箱
		area.position = size / 除数
func _isui(body:Node2D):
	if body.get_node("..") != $".":
		if body.is_in_group("UI判定") == true:
			emit_signal("_UI进入时",body.get_node(".."))
			
func _isexui(body:Node2D):
	if body.get_node("..") != $".":
		if body.is_in_group("UI判定") == true:
			emit_signal("_UI离开时",body.get_node(".."))
