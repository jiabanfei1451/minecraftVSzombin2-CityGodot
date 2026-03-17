extends Area2D
var FPS : float
var spell_targets = 0
@export_group("属性")
@export_enum("僵尸", "选项2", "选项3") var 选择AI类型: int
@export_group("属性/不可更改")
@export var 选定攻击 : Area2D
@export_group("属性")
@export var 攻击力 : float = 0.5
@export_group("移动组件")
@export var 速度 : float = 1
var 状态 :String
@export_group("绑定物理")
@export var 组件节点 : Node
@export_group("生命组件")
@export_group("生命组件/血量")
@export var 血量 : float = 15
@export var 最大血量 : float
@export var 自动设置最大血量 : bool = true
@export_group("生命组件/效果")
@export var 受击: Array[AudioStreamOggVorbis]
@export var 死亡 : AudioStreamOggVorbis
@export var 特效 : PackedScene
@export var 是否死亡 : bool = false
@export var 颜色持续时间 : float = 0
@export_group("额外脚本")
@export var 脚本 : Array[Script]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if 自动设置最大血量 == true:
		最大血量 = 血量
	组件节点.生成节点 = $"."
	初始化移动()
	开始播放动作()
func _process(delta: float) -> void: 
	FPS = delta
	if 选定攻击 == null:
		$"检测".visible = true
	else:
		$"检测".visible = false
	if 是否死亡 == false:
		if 颜色持续时间 > 0:
			颜色持续时间 -= delta
			$".".modulate = Color(1.0, 0.0, 0.0, 1.0)
		else:
			$".".modulate = Color(1.0, 1.0, 1.0, 1.0)
func 减少血量(数量:float):
	血量 -= 1
	if 血量 >= 1 and 是否死亡 == false:
		$"受击音效".stream = 受击.pick_random()
		$"受击音效".play()
		颜色持续时间 += 0.05
	else:
		$"腿部动画".stop()
		$"手部动画".stop()
		$"手部动画".play("死亡/死亡")
		是否死亡 = true
		$"受击音效".stream = 死亡
		$"受击音效".play()
		$".".modulate = Color(1.0, 0.0, 0.0, 1.0)
		await get_tree().create_timer(1.5).timeout
		var 特效dd = 特效.instantiate()
		特效dd.position = $".".position - Vector2(99,99)
		get_node(".").add_child(特效dd)
		queue_free()
		
func 初始化移动():
	while 是否死亡 == false:
		if 选定攻击 == null:
			position.x -= 20 * 速度 * FPS
		await get_tree().create_timer(FPS).timeout
func 开始播放动作():
	var 开始跑动 : bool
	while 是否死亡 == false:
		状态 = ""
		if 选定攻击 == null:
			if $"手部动画".is_playing() == false and 检测存在状态() == null:
				if 开始跑动 == false:
					$"手部动画".play("手（摆动）")
			if $"腿部动画".is_playing() == false and 检测存在状态() == null:
				if 开始跑动 == false:
					$"腿部动画".play("腿部（准备跑动）")
					开始跑动 = true
				if 开始跑动 == true:
					$"腿部动画".play("腿部_跑动")
		else:
				开始跑动 = false
				if $"手部动画".is_playing() == false:
					$"手部动画".play("手_挖掘")
				if $"腿部动画".is_playing() == false:
					if 状态 == "":
						$"腿部动画".play("腿部_挖掘")
						状态 = "挖掘"
				if 选定攻击 != null:
					选定攻击.减少血量(攻击力*FPS)
				else:
					选定攻击 = null
		await get_tree().create_timer(FPS).timeout
		
func 检测存在状态():
	if 选定攻击 == null:
		return null
