extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	开始过度()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func 开始过度():
	var x = create_tween()
	$"蓝图展示".position.y = 700
	$"卡槽".position.y = -109
	$"完成选卡".position.y = 700
	var 动画 = create_tween()
	var d = create_tween()
	x.tween_property($"完成选卡","position",Vector2(969,592),1).set_trans(Tween.TRANS_EXPO)
	动画.tween_property($"蓝图展示","position",Vector2(0,110),1.0).set_trans(Tween.TRANS_EXPO)
	d.tween_property($"卡槽","position",Vector2(0,0),1.0).set_trans(Tween.TRANS_EXPO)

func 完成选卡():
	var x = create_tween()
	var 动画 = create_tween()
	var d = create_tween()
	x.tween_property($"完成选卡","position",Vector2(969,700),1).set_trans(Tween.TRANS_EXPO)
	动画.tween_property($"蓝图展示","position",Vector2(0,700),1.0).set_trans(Tween.TRANS_EXPO)
	d.tween_property($"卡槽","position",Vector2(0,-1000),1.0).set_trans(Tween.TRANS_EXPO)
	await get_tree().create_timer(1).timeout
	get_tree().current_scene.get_node("选卡动画").play("选卡完成")
	await get_tree().create_timer(1.5).timeout
	$"准备开始".scale = Vector2(0.35,0.35)
	$"准备开始".text = "好"
	音效()
	await get_tree().create_timer(0.5).timeout
	$"准备开始".scale = Vector2(0.3,0.3)
	$"准备开始".text = "准备"
	var xc = create_tween()
	xc.tween_property($"准备开始","scale",Vector2(0.45,0.45),0.5).set_trans(Tween.TRANS_SINE)
	await get_tree().create_timer(0.5).timeout
	$"准备开始".text = "安放器械！"
	$"准备开始".scale = Vector2(0.6,0.6)
	await get_tree().create_timer(2).timeout
	get_tree().current_scene.get_node("音效/音乐").音乐选项 = 0
	get_tree().current_scene.生成节点(preload("res://UI/关卡UI.tscn"),$"..")
	get_tree().current_scene.生成节点(preload("res://UI/信息显示.tscn"),$"..")
	$".".queue_free()

func 音效():
	$"准备开始/播放音效".play()
func _on_完成选卡_pressed() -> void:
	pass # Replace with function body.
