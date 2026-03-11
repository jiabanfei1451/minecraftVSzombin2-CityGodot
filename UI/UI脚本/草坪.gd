extends ColorRect
var 触碰到鼠标 : bool = false
@export var 生成节点 : Node2D
@export var 怪物生成节点 : Node2D
@export var 器械 : PackedScene
@export var Y偏移 : float = 0
@export var X偏移 : float = 0
@export var 绑定器械 : Area2D = null
@export_group("属性")
@export_group("坐标")
@export var 坐标 : Vector2
@export_enum("是","否",) var 是否自动更改 : String = "否"
func _ready() -> void:
	$".".color = Color(0.0, 0.0, 0.0, 0.0)
	await get_tree().create_timer(0.2).timeout
	if get_tree().current_scene.get_node("器械") != null:
		生成节点 = get_tree().current_scene.get_node("器械")
	if get_tree().current_scene.get_node("怪物") != null:
		怪物生成节点 = get_tree().current_scene.get_node("怪物")
func _process(delta: float) -> void:
	器械 = get_tree().current_scene.当前器械
	if 是否自动更改 == "是":
		position.x = -452 - (坐标.x * 81 * -1)
		position.y = 121.0 - (坐标.y * 79)
	visible =! get_tree().current_scene.正在使用其他属性
	if Input.is_action_just_pressed("左键") and 触碰到鼠标 == true:
		if 绑定器械 == null and 器械 != null:
			get_tree().current_scene.来自.已被放置()
			var 器械实列 = 器械.instantiate()
			器械实列.position = position + pivot_offset + Vector2(pivot_offset.x * X偏移,pivot_offset.y * Y偏移)
			if 器械实列.is_in_group("怪物") == true:
				怪物生成节点.add_child(器械实列)
			else:
				生成节点.add_child(器械实列)
			绑定器械 = 器械实列
		if 绑定器械 != null and 绑定器械.is_in_group("器械") == false:
			绑定器械 = null

		

func _on_鼠标来了() -> void:
	触碰到鼠标 = true
	if 绑定器械 == null and get_tree().current_scene.当前器械 != null:
		$".".color = green()
	else:
		if get_tree().current_scene.当前器械 != null: 
			color = red()
	
func green():
	return Color(0.0, 1.0, 0.0, 1.0)
func red():
	return Color(1.0, 0.0, 0.0, 1.0)

func _on_鼠标走了() -> void:
	触碰到鼠标 = false
	$".".color = Color(0.0, 1.0, 0.017, 0.0)
