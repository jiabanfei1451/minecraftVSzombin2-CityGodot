extends Node2D
@export var DEBUG : bool = false
@export var 地图亮度 : float = 0
@export_group("使用属性")
@export var 使用星之碎片 : bool = false
@export var 使用稿子 : bool = false
@export var 使用器械能 : bool = false
var 正在使用其他属性 : bool = false
@export_group("草坪")
@export var 当前器械 : PackedScene
@export var 来自 : Button
@export_group("信息")
@export var 关卡信息 : String = "万圣夜"
@export var 器械能: int = 50
@export_subgroup("1145")
@export var 已选卡 : Array[PackedStringArray]
@export_group("属性")
@export_enum("白日","夜晚") var 天色 : String = "白日"
@export_enum("开启","关闭") var 夜色滤镜 : String = "开启"
@export var 滤镜节点 : Area2D
@export var 光源颜色 : Color
@export_range(0,1,0.01) var 光源强度 : float = 0.5
@export_range(0,1,0.01) var 滤镜强度 : float = 0.5
# Called when the node enters the scene tree for the first time.
# Load the custom images for the mouse cursor.
var arrow = load("res://arrow.png")
var beam = load("res://arrow(City).png")
var ui场景 : PackedScene = preload("res://UI/关卡UI.tscn")
var ui场景2 : PackedScene = preload("res://UI/信息显示.tscn")
func _ready():
	Save.mapSave("mapSave",关卡信息,器械能,0)
	已选卡.clear()
	var 阴影 = 场景生成("阴影",1)
	节点提供.阴影 = 阴影
	var 粒子 = 场景生成("粒子",1)
	节点提供.粒子 = 粒子
	var 器械 = 场景生成("器械",2)
	节点提供.器械 = 器械
	var 怪物 = 场景生成("怪物",2)
	节点提供.怪物 = 怪物
	var 粒子2 = 场景生成("粒子2",2)
	节点提供.粒子2 = 粒子2
	场景生成("射弹",3)
	var 光源 = 场景生成("光源",5)
	节点提供.光源 = 光源
	var 特效 = 场景生成("特效",5)
	节点提供.特效 = 特效
	Input.set_custom_mouse_cursor(arrow)
	Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)
	await get_tree().create_timer(30).timeout
	var ti : float = 30
	while true:
		怪物生成()
		await get_tree().create_timer(ti).timeout
		ti *= 0.8
		ti = clamp(ti,0.5,30)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#region 神秘的判定
	if get_node("光源") != null:
		$"光源".modulate = Color(1.0, 1.0, 1.0, 光源强度)
		if DEBUG == true:
			print("设定光源")
		
	if 夜色滤镜 == "开启":
		滤镜节点.visible = true
	else:
		滤镜节点.visible = false
	滤镜节点.modulate = Color(光源颜色.r, 光源颜色.g, 光源颜色.b, 滤镜强度)
	if not 使用稿子 and not 使用星之碎片 and not 使用器械能:
		正在使用其他属性 = false
	else: 正在使用其他属性 = true
	if Input.is_action_just_pressed("S") == true:
		print("按下")
	if Input.is_action_just_pressed("DEBUG"):
		if DEBUG == false:
			print("DEBUG模式已开启")
			DEBUG = true
		else:
			print("DEBUG模式已关闭")
			DEBUG = false
	if Input.is_action_just_pressed("F5"):
		get_tree().reload_current_scene()
	if Input.is_action_pressed("←"):
		rotation += 1 * delta
	if Input.is_action_pressed("→"):
		rotation -= 1 * delta
	if Input.is_action_just_released("·"):
		_使用器械能()
	if Input.is_action_just_released("W"):
		星之碎片()
	if Input.is_action_just_released("Q"):
		稿子()
#endregion
#region 常用函数
func 禁用():
	当前器械 = null
	使用星之碎片 = false
	使用稿子 = false
	使用器械能 = false

func 稿子():
	if 使用稿子 == false:
		禁用()
		$"音效/铲子".play()
		使用稿子 = true
	else:
		使用稿子 = false
		$"音效/取消".play()

func 星之碎片():
	if 使用星之碎片 == false:
		禁用()
		使用星之碎片 = true
	else:使用星之碎片 = false

func _使用器械能():
	if 使用器械能 == false:
		禁用()
		使用器械能 = true
	else:
		使用器械能 = false
#endregion
func 生成节点(节点:PackedScene,生成节点:Node2D):
	var 节点实列 = 节点.instantiate()
	生成节点.add_child(节点实列)
	return 节点实列

func 场景生成(名称:String,层级:int):
	if get_node(名称) == null:
		var node : Node2D
		node = Node2D.new()
		add_child(node)
		node.name = 名称
		node.y_sort_enabled = true
		node.z_as_relative = false
		node.z_index = 层级
		node.position = Vector2(0,0)
		print("[",Time.get_time_string_from_system(),"]",name,"生成场景","“",名称,"”")
		return node
	else:
		print("[",Time.get_time_string_from_system(),"]",name,"无法生成场景","“",名称,"”","场景已存在")
		
func 怪物生成():
	var scone : PackedScene = preload("res://物体/怪物/僵尸.tscn")
	var sx = scone.instantiate()
	sx.position = Vector2(500,30+(80 * int(randf_range(3,-3))))
	$"怪物".add_child(sx)
