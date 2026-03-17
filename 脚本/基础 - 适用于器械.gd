#region
extends Area2D
@export_group("属性")
@export var 缩放 : Vector2 = Vector2(1,1)
@export var 坐标校准 : Vector2
@export_range(0,0.5,0.01) var 校准延迟 : float = 0.01
@export_group("光源")
@export var 光源节点 : Node2D
@export var 光源数组 : Array[PackedScene]
@export var 光源生成偏移 : Array[Vector2]
@export var 光源颜色 : Array[Color]
@export var 光源缩放 : Array[Vector2]
@export_group("生命组件")
@export var 血量 : float = 15
var 是否死亡 : bool = false
@export_group("生命组件/效果")
@export var 粒子效果颜色 : Array[Color] = [Color(1.0, 1.0, 1.0, 1.0)]
@export var 粒子数量 : int = 15
@export var 死亡音效 : Array[AudioStreamOggVorbis]
@export var 放置音效 : Array[AudioStreamOggVorbis] = [preload("res://音效/石头挖掘音效/stone1.ogg"),preload("res://音效/石头挖掘音效/stone2.ogg"),preload("res://音效/石头挖掘音效/stone3.ogg"),preload("res://音效/石头挖掘音效/stone4.ogg")]
@export_group("攻击组件")
@export_group("攻击组件/攻击AI")
@export_enum("发射器","熔炉") var 攻击类型 : String = "发射器"
@export_enum("发射器","熔炉") var 大招类型 : String = "发射器" 
@export_enum("发射器","熔炉") var 器械AI : String = "发射器"
@export var 使用老动画 : bool = false
var 判断 : String = $".".name
var xun : int = 0
@export var 特效 : PackedScene
@export_group("攻击组件/攻击属性")
@export var 发射物 : PackedScene
@export var 向量 : Vector2 = Vector2(-12,-15)
@export var 后坐力_ : float = 1
@export var 射速 : Vector2 = Vector2(1.2,1.7)
@export var 射弹节点 : Node2D
@export_group("攻击组件")
var 开始攻击 : bool = false
var 已检测到的怪物数量 : int = 0
var 帧间 : float = 0
var 大招 : bool = false
@export_group("物理")
@export var 物理节点 : Node
#endregion
func _ready() -> void:
	visible = false
	物理节点.生成节点 = $"."
	var 一次性音效 = preload("res://物体/一次性音效.tscn")
	var 一次性音效i = 一次性音效.instantiate()
	get_tree().current_scene.add_child(一次性音效i)
	一次性音效i.stream = 放置音效.pick_random()
	一次性音效i.play()
	await get_tree().create_timer(物理节点.开始延迟 + 校准延迟).timeout
	visible = true
	物理节点.初始高度 += 坐标校准.y
	position.x += 坐标校准.x
	光源节点 = get_tree().current_scene.get_node("光源")
	var 循环取值 : int = 0
	for i in 光源数组.size(): 
		var 实列化光源 = 光源数组[循环取值].instantiate()
		实列化光源.绑定偏移 = 光源生成偏移[循环取值]
		实列化光源.绑定颜色 = 光源颜色[循环取值]
		实列化光源.绑定缩放 = 光源缩放[循环取值]
		实列化光源.绑定物体 = $"."
		光源节点.add_child(实列化光源)
		实列化光源.z_index = 4
		循环取值 += 1
#position = get_viewport().get_mouse_position() - $"..".position
func _process(delta: float) -> void: #检测
	if 射弹节点 == null:
		生成日志("完成赋值")
		射弹节点 = get_tree().current_scene.get_node("射弹")
	if $"碰撞".获得焦点 == true and Input.is_action_just_released("左键") and get_tree().current_scene.使用星之碎片 == true and 大招 == false:
		触发大招(大招类型)
	if $"碰撞".获得焦点 == true and Input.is_action_just_released("左键") and get_tree().current_scene.使用稿子:
		死亡()
	帧间 = delta
	if 已检测到的怪物数量 > 0:
		开始攻击 = true
	else: 开始攻击 = false
	if 血量 <= 0: #检测血量状态
		死亡()
	$".".scale = 缩放
	
	if 缩放.x > 0: #设置缩放
		判断 = ">"
	else:
		判断 = "<"

#region 发射器
func 发射器后坐力(houzuoli:int): #新后坐力动画
	$AnimationPlayer.play("发射")

func 发射器后坐力_老(houzuoli:int): #老后坐力动画
	$Sprite2D.position.x -= houzuoli*20
	var 动画 : int = 0 #后退循环20次
	while 动画 <= 19:
		动画 += 1
		$Sprite2D.position += Vector2(houzuoli,0)
		await get_tree().create_timer(帧间).timeout


func 发射器发射(): #发射
	$"发射音效".play()
	if 大招 == false:
		if 使用老动画 == false:
			发射器后坐力(后坐力_)
		else: 发射器后坐力_老(后坐力_)
	var 发射物int = 发射物.instantiate()
	发射物int.position = position + Vector2(向量)
	射弹节点.add_child(发射物int)

#endregion

func _on_timer_timeout() -> void: #倒计时
	$Timer.wait_time = randf_range(射速.x,射速.y)
#region 发射器攻击
	if 攻击类型 == "发射器":
		if 大招 == false:
			if get_tree().current_scene.DEBUG == true:
				生成日志("发射器攻击" + " 可否攻击:" + str(开始攻击) + " 攻击向量:" + str(向量)+ " 后坐力:" + str(后坐力_) + " 已检测到的怪物数量:" + str(已检测到的怪物数量))
			if 开始攻击 == true:
				发射器发射()
#endregion
#region 熔炉
	if 攻击类型 == "熔炉":
		print("攻击")
		$AnimationPlayer.play("熔炉生产")
		await get_tree().create_timer(2).timeout
		$AnimationPlayer.play("熔炉产出")
		$Timer.wait_time = randf_range(15,25)
		$Timer.start()
#endregion

#region 检测
func _on_检测_area_离开时(area: Area2D) -> void: #碰撞检测
	if area.is_in_group("怪物") == true:
		if get_tree().current_scene.DEBUG == true:
			print("离开")
		已检测到的怪物数量 -= 1

func _on_检测_area_碰到时(area: Area2D) -> void: #碰撞检测2
	if area.is_in_group("怪物"):
		if get_tree().current_scene.DEBUG == true:
			print("true")
		if not area.is_in_group("判定"):
			if get_tree().current_scene.DEBUG == true:
				print("true")
				print("pass",area.name)
			if area.position.x > $".".position.x or 判断 == ">" and area.position.x < $".".position.x or 判断 == "<":
				if get_tree().current_scene.DEBUG == true:
					print(name,area.name)
				已检测到的怪物数量 += 1
		else:
			if get_tree().current_scene.DEBUG == true:
				print("你认真的？")
#endregion
#region 生命
func 减少血量(减少血量:float): 
	血量 -= 减少血量
	print(血量)

func 死亡():
	if 是否死亡 == false:
		是否死亡 = true
		var 节点音效 = preload("res://物体/一次性音效.tscn").instantiate()
		节点音效.stream = 死亡音效.pick_random()
		get_tree().current_scene.add_child(节点音效)
		节点音效.play()
		var 随机值 : float = 0
		for i in 粒子数量:
			随机值 = randf_range(0,100)
			var 粒子 : PackedScene = preload("res://物体/粒子/粒子.tscn")
			var 粒子实例化 = 粒子.instantiate()
			粒子实例化.modulate = 粒子效果颜色.pick_random()
			粒子实例化.position = position
			if 随机值 > 50:
				节点提供.粒子.add_child(粒子实例化)
			else:
				节点提供.粒子2.add_child(粒子实例化)
		queue_free()
#endregion

func 触发大招(大招类型:String):
#region 大招初始化
	var 循环数 : int = 0
	$"大招音效".play()
	var 特效dd = 特效.instantiate()
	特效dd.position = $".".position + Vector2(14,0)
	$"../..".get_node("特效").add_child(特效dd)
#endregion

#region 发射器
	if 大招类型 == "发射器":
		大招 = true
		$AnimationPlayer.play("大招(开启中)")
		while 循环数 <= 60:
			循环数 += 1
			发射器发射()
			后坐力_ = 0.3
			await get_tree().create_timer(0.06).timeout
		$AnimationPlayer.play("发射")
#endregion

#region 熔炉
	if 大招类型 == "熔炉":
		大招 = true
		while 循环数 <= 6:
			$"发射音效/开大产出".play()
			循环数 += 1
			await get_tree().create_timer(0.25).timeout
		$AnimationPlayer.play("发射")
#endregion
	大招 = false
func _on_color_rect_mouse_entered() -> void:
	if get_tree().current_scene.正在使用其他属性 == true:
		$".".modulate = Color(1.353, 1.353, 1.353, 1.0)

func _on_color_rect_mouse_exited() -> void:
	$".".modulate = Color(1.0, 1.0, 1.0, 1.0)

func 生成日志(日志: String):
	var dataTime : String = Time.get_datetime_string_from_system()
	if get_tree().current_scene.DEBUG == true:
		print("[",dataTime,"]",name,日志)
