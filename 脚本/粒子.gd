extends Sprite2D
@export var 随机向量 : Vector2 = Vector2(50,50)
@export var 持续时间 : float = 0.3
var 最终向量:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	最终向量 = position + Vector2(randf_range(随机向量.x * -1,随机向量.x),randf_range(随机向量.y * -1,随机向量.y))
	await get_tree().create_timer(randf_range(1.5,2)).timeout
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var 补间 = create_tween()
	补间.tween_property($".","position",最终向量,持续时间)
