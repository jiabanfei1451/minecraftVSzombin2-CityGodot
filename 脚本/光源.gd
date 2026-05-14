extends Area2D
@export var 绑定物体 : Area2D
@export var 绑定偏移 : Vector2
@export var 绑定缩放 : Vector2
@export var 绑定颜色 : Color
@export var 无需绑定 : bool = false
var 完成绑定 : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if 无需绑定 == false:
		visible = false
		scale = 绑定缩放
		modulate = 绑定颜色
	else:pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if 无需绑定 == false:
		if 绑定物体 != null:
			visible = true
			完成绑定 = true
			position = 绑定物体.position + 绑定偏移
			scale = 绑定缩放
			modulate = 绑定颜色
		else:
			if 完成绑定 == true:
				queue_free()
