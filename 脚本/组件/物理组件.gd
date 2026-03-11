extends Node
@export_range(0,0.5,0.01) var 开始延迟 : float = 0.02
@export var 初始高度 : float
@export var 高度 : Vector2
@export var 阴影缩放 : Vector2 = Vector2(0.15,0.06)
@export var 阴影生成向量 : Vector2 = Vector2(0,20)
@export var 阴影 : PackedScene
@export var 生成节点 : Area2D
@export var 高度偏移 : bool = false
@export var 高度偏移向量 : Vector2
var 帧间隔 : float
var 阴影物体 : Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if 开始延迟 > 0 and 生成节点 == null:
		await get_tree().create_timer(开始延迟).timeout
	if 高度偏移 == true:
		var 向量偏移 : float = randf_range(高度偏移向量.x,高度偏移向量.y)
		$"..".position.y += randf_range(高度偏移向量.x,高度偏移向量.y)
		阴影生成向量.y += 向量偏移
	生成阴影()
	初始高度 = $"..".position.y
	开启物理($"..")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	帧间隔 = delta
	
func 开启物理( 物体:Area2D ):
	var 下降速度 : float
	while true:
		if 高度.x < 0 :
			下降速度 += 10
			高度.x += 下降速度 * 帧间隔
		else:
			高度.x = 0
			下降速度 = 0
		物体.position.y = 初始高度 + 高度.x + 高度.y
		await get_tree().create_timer(帧间隔).timeout

func 生成阴影():
	var 阴影ss = 阴影.instantiate() 
	var xun : int = 2
	while xun >= 1:
		阴影ss.绑定物体 = $".."
		阴影ss.缩放 = 阴影缩放
		阴影ss.坐标偏移 = 阴影生成向量
		节点提供.阴影.add_child(阴影ss)
		xun -= 1
