extends Window
var d :Vector2 = Vector2(150,150)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var c = create_tween()
	c.tween_property($".","d",Vector2(1152,648),2).set_trans(Tween.TRANS_QUART)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	size = d


func _on_close_requested() -> void:
	hide()
