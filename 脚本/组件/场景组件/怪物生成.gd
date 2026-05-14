extends "res://脚本/组件/场景组件/场景初始化.gd"
signal 怪物生成前(物体:Area2D)
signal 怪物生成后(物体:Area2D)
signal 开始生成()
signal 计时开始时()
signal 计时完成后()
signal 条件判断为真()

@export_group("生成")
var 最大波数 : int
var 当前波数 : int
@export var 生成列表 : Array[Array]
@export var 生成数量 : Array[int]
@export var 开始倒计时 : int = 30
@export var 剩余数量 : Array[Area2D]
@export var 下一波倒计时 : float = 45
@export_subgroup("生成延迟")
@export var 生成延迟 : float = 0.02
@export var 生成坐标 : Vector2 = Vector2(500,45)
@export var 生成倍率 : float = 80
@export var 生成线路 : Vector2 = Vector2(3,-3)
var 生成中 : bool = false
var 剩余计时 = 0
var 暂停生成 : bool = false
var FPS : float
var 正在排除中 : bool = false

func _ready() -> void:
	level_ready2()
func _process(delta: float) -> void:
	level_process2(delta)
	
func level_ready2():
	level_ready()
func level_process2(delta: float):
	level_process(delta)
	FPS = delta
	排除空数组()
	条件()
func 生成开始():
	生成中 = true
	emit_signal("开始生成")
	while 生成中 and 当前波数 <= 生成数量.size():
		if 当前波数 < 生成数量.size():
			生成波(当前波数)
		当前波数 += 1
		await 条件判断为真
		await get_tree().create_timer(FPS).timeout

func 生成波(波:int):
	if 生成数量[波] != null:
		for i in 生成数量[波]:
			怪物生成(波)

func 条件():
	if 剩余数量.size() == 0 and 暂停生成 == false:
		emit_signal("条件判断为真")
func 怪物生成(列表ID:int):
	var scone : PackedScene = 精灵图列表.怪物数组[生成列表[列表ID].pick_random()]
	var sx = scone.instantiate()
	sx.position = Vector2(500,45+(80 * int(randf_range(3,-3))))
	emit_signal("怪物生成前",sx)
	$"怪物".add_child(sx)
	剩余数量.append(sx)
	emit_signal("怪物生成后",sx)
func 排除空数组():
	if 正在排除中 == false:
		正在排除中 = true
		if 剩余数量.size() != 0:
			for i in 剩余数量.size():
				if i <= 剩余数量.size() -1 and 剩余数量[i] == null:
					剩余数量.remove_at(i)
					print("排除成功")
				await get_tree().create_timer(FPS).timeout
		正在排除中 = false

func 添加波(数量:int = 1,arr:Array[int] = []):
	var siz = 生成列表.size()
	生成列表.append([])
	生成数量.append(数量)
	siz = 生成列表.size()
	生成列表[siz - 1].append_array(arr)
