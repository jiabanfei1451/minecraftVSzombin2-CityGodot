extends Area2D
var FPS : float
@export var 父节点 : Area2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	FPS = delta

func 重启检测器():
	position += Vector2(9999,9999)
	await get_tree().create_timer(FPS).timeout
	position -= Vector2(9999,9999)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("器械"):
		area.减少血量(1)
		父节点.检测到的器械数量 += 1


func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("器械"):
		父节点.检测到的器械数量 -= 1
