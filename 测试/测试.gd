extends Sprite2D

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	texture = 精灵图列表.img[0]
func _process(delta: float) -> void:
	texture = 精灵图列表.img.pick_random()
