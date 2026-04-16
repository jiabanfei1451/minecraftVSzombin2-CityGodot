extends Control
@export_group("贴图")
@export var 提示文字 : Label
@export var 空卡槽贴图 : Texture2D = preload("res://UI/UI素材图/card(null).png")
@export var 卡槽默认贴图 : Texture2D = preload("res://UI/UI素材图/card.png")
@export var 卡槽边框默认贴图 : Texture2D = preload("res://UI/UI素材图/card 边框.png")
@export_group("卡槽状态")
@export var 启用 : bool = true
var 器械 : PackedScene
@export var 器械ID : int = -1
@export var 消耗 : int = 50
@export var 冷却 : float = 7.5
@export var 冷却中 : bool = false
@export var UI:CanvasLayer
@export_subgroup("选卡蓝图")
@export var _启用 : bool = false
@export_group("选用状态")
@export var 选用状态 : bool = false
@export_group("绑定快捷键")
@export_enum("1","2","3","4","5","6","7","8","9","0") var 绑定快捷键 : String = "1"
var shushu : bool = false
var 冷却渐变 : Tween

func _ready() -> void:
	visible = false
	await get_tree().create_timer(get_viewport().get_physics_process_delta_time()).timeout
	添加属性()
	设定卡槽状态()
	if _启用 == false:
		if get_tree().current_scene.当前状态 != "选卡":
			开始冷却()
		$"描述".visible = false
	else:
		$"描述".visible = false
	visible=true
	
func _process(delta: float) -> void:
	设定鼠标状态()
	设定卡槽状态()
	var jjj = int(绑定快捷键)
	if jjj == 0:
		jjj = 9
	if jjj > 全局变量.卡槽数量:
		visible = false
	else:
		visible = true
	if _启用 == false:
		添加属性()
		if 启用 == true and 器械ID > -1:
			if get_tree().current_scene.当前器械 == 器械 and get_tree().current_scene.来自 == $".": #定义器械选定状态
				modulate = Color(0.735, 0.735, 0.735, 1.0)
			else:
				modulate = Color(1.0, 1.0, 1.0, 1.0)
			if 判定选卡状态() == false:
				if Input.is_action_just_released("右键"): #如果器械选中时右键取消
					取消选定()
					
				if Input.is_action_just_released(绑定快捷键):
					被选中()

				if get_tree().current_scene.器械能 < 消耗:
					modulate = Color(0.5, 0.5, 0.5, 1.0)
				else:
					if get_tree().current_scene.当前器械 != 器械 and get_tree().current_scene.来自 != $".":
						modulate = Color(1.0, 1.0, 1.0, 1.0)
				if get_tree().current_scene.正在使用其他属性 == true:
					选用状态 = false
			$"裁剪节点".visible = 冷却中
	else:
		if get_tree().current_scene.来源.has($"."): #定义器械选定状态
			modulate = Color(0.735, 0.735, 0.735, 1.0)
		else:
			modulate = Color(1.0, 1.0, 1.0, 1.0)
		$"裁剪节点".visible = false

func _on_pressed() -> void: #点击时
	if _启用 == false:
		if 判定选卡状态() == false:
			被选中()
	else:
		if get_tree().current_scene.来源.has($".") == false:
			选卡()

func _on_button_down() -> void:
	if _启用 == false:
		if 判定选卡状态() == false:
			if 启用 == true:
				modulate = Color(1.825, 1.825, 1.825, 1.0)

func _on_button_up() -> void:
	if _启用 == false:
		if 判定选卡状态() == false:
			if 启用 == true:
				modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func _鼠标进入时() -> void:
	$"描述".visible = true

func _鼠标离开时() -> void:
	$"描述".visible = false

func 开始冷却():
	冷却中 = true
	$"裁剪节点/冷却".scale.y = 1
	var cd = create_tween()
	cd.tween_property($"裁剪节点/冷却","scale",Vector2(1,0),冷却)
	冷却渐变 = cd
	await 冷却渐变.finished
	冷却中 = false

func 被选中():
	if 启用 == true:
		if get_tree().current_scene.器械能 >= 消耗:
			if get_tree().current_scene.当前器械 != 器械:
				if 冷却中 == false:
					选定()
			else:
				取消选定()
		else:
			if 提示文字 != null:
				for d in 3:
					var sd = create_tween()
					sd.tween_property(提示文字,"theme_override_colors/font_color",Color(1.0, 0.0, 0.0, 1.0),0)
					get_tree().create_timer(0.1).timeout
					sd.tween_property(提示文字,"theme_override_colors/font_color",Color(0.0, 0.0, 0.0, 1.0),0)
					get_tree().create_timer(0.1).timeout

func 选定():
	if 启用 == true:
		get_tree().current_scene.当前器械ID = 器械ID
		get_tree().current_scene.禁用()
		get_tree().current_scene.来自 = $"."
		get_tree().current_scene.当前器械 = 器械
		$"选用".play()
	
func 取消选定():
	if 启用 == true:
		if 器械ID != -1:
			if get_tree().current_scene.当前器械 == 器械:
				$"取消".play()
				get_tree().current_scene.当前器械 = null

func 设定卡槽状态():
	if 器械ID > -1 and 启用 == true:
		$"消耗".text = str(消耗) #消耗显示
		visible = true
		添加名称描述(器械ID)
		modulate = Color(1.0, 1.0, 1.0, 1.0)
		$"贴图/背景板".texture = 卡槽默认贴图
		$"贴图/边框".texture = 卡槽边框默认贴图
		$"图片".visible = true
		$"消耗".visible = true
		$"裁剪节点".visible = true
		$"裁剪节点/冷却".modulate = Color(0.0, 0.0, 0.0, 0.502)
		器械 = 精灵图列表.Pack[器械ID]
		$"图片/显示图片".texture = 精灵图列表.img[器械ID]
	else:
		$"描述".visible = false
		$"贴图/背景板".texture = 空卡槽贴图
		$"贴图/边框".texture = null
		modulate = Color(1.0, 1.0, 1.0, 0.627)
		$"裁剪节点/冷却".modulate = Color(1.0,1.0,1.0,0)
		$"图片".visible = false
		$"消耗".visible = false
		$"裁剪节点".visible = false

func 已被放置():
	if 启用 == true:
		get_tree().current_scene.当前器械 = null
		get_tree().current_scene.器械能 -= 消耗
		开始冷却()

func 判定选卡状态():
	if get_tree().current_scene.当前状态 == "选卡" or 器械ID <= -1:
		return true
	else:
		return false

func 设定鼠标状态():
	if get_tree().current_scene.当前器械 == 器械 or 器械ID <= -1:
		$"贴图/触摸点".mouse_default_cursor_shape = 0
	else:
		$"贴图/触摸点".mouse_default_cursor_shape = 2
		
func 添加名称描述(列表取值:int):
	if 精灵图列表.名称.get(列表取值) != null:
		$"描述/名称".text = 精灵图列表.名称[列表取值]
	if 精灵图列表.描述.get(列表取值) != null:
		$"描述/描述".text = 精灵图列表.描述[列表取值]
	var ss = create_tween()
	var po =create_tween()
	if 器械ID != -1 and $"描述".visible == true:
		if $"描述/名称".size.x > $"描述/描述".size.x:
			ss.tween_property($"描述","size",Vector2($"描述/名称".size.x + 10,91.55),0.1) #$"描述".size.x =
		else:
			ss.tween_property($"描述","size",Vector2($"描述/描述".size.x + 10,91.5),0.1) #$"描述".size.x =
			#$"描述".size.x = 
	else:
		ss.tween_property($"描述","size",Vector2(0,91.5),0.1)
	if $"描述".size.x > 152:
		po.tween_property($"描述","position",Vector2i(((152 - $"描述".size.x) / 2) * 0.5,45.75),0.1)
		#$"描述".position.x = 

func 选卡():
	var id:int = 0
	var on:bool = true
	var 取数组值:Array[int] = get_tree().current_scene.已选卡
	while on == true and id < 10:
		print(取数组值[id])
		if 取数组值.get(id) == -1:
			get_tree().current_scene.来源[id] = $"."
			取数组值[id] = 器械ID
			print("选卡完成id值为 ",取数组值.get(id))
			on = false
		id += 1
			
func 添加属性():
	if 器械ID > -1:
		消耗 = 精灵图列表.消耗[器械ID]
		冷却 = 精灵图列表.冷却[器械ID]
