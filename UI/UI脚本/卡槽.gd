extends Button
@export_group("卡槽状态")
var 器械 : PackedScene
@export var 器械ID : int
@export var 消耗 : int = 50
@export var 冷却 : float = 7.5
@export var 冷却中 : bool = false
@export var UI:CanvasLayer
@export_group("选用状态")
@export var 选用状态 : bool = false
@export_group("绑定快捷键")
@export_enum("1","2","3","4","5","6","7","8","9","0") var 绑定快捷键 : String = "1"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	开始冷却()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"消耗".text = str(消耗)
	器械 = 精灵图列表.Pack[器械ID-1]
	$"图片/显示图片".texture = 精灵图列表.img[器械ID-1]
	if get_tree().current_scene.当前器械 == 器械:
		modulate = Color(0.735, 0.735, 0.735, 1.0)
	else:modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	if Input.is_action_just_released("右键") and get_tree().current_scene.当前器械 != 器械:
		取消选定()
		
	if Input.is_action_just_released(绑定快捷键):
		被选中()

	if get_tree().current_scene.器械能 < 消耗:
		modulate = Color(0.5, 0.5, 0.5, 1.0)
	else:
		if get_tree().current_scene.当前器械 != 器械:
			modulate = Color(1.0, 1.0, 1.0, 1.0)
	if get_tree().current_scene.正在使用其他属性 == true:
		选用状态 = false
		
	$"冷却".visible = 冷却中

func _on_pressed() -> void:
	被选中()


func _on_button_down() -> void:
	modulate = Color(1.825, 1.825, 1.825, 1.0)


func _on_button_up() -> void:
	modulate = Color(1.0, 1.0, 1.0, 1.0)
	
func 开始冷却():
	冷却中 = true
	$"冷却".scale.y = 1
	var cd = create_tween()
	cd.tween_property($"冷却","scale",Vector2(1,0),冷却)
	await get_tree().create_timer(冷却).timeout
	冷却中 = false
func 被选中():
	if get_tree().current_scene.器械能 >= 消耗:
		if get_tree().current_scene.当前器械 != 器械:
			if 冷却中 == false:
				选定()
		else:
			取消选定()
func 选定():
	get_tree().current_scene.禁用()
	get_tree().current_scene.来自 = $"."
	get_tree().current_scene.当前器械 = 器械
	$"选用".play()

func 取消选定():
	get_tree().current_scene.当前器械 = null
	$"取消".play()
func 已被放置():
	get_tree().current_scene.当前器械 = null
	get_tree().current_scene.器械能 -= 消耗
	开始冷却()
