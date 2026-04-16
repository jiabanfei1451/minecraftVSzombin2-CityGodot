extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect.visible = true
	d()# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func d():
	await get_tree().create_timer(1).timeout
	var dsss = create_tween()
	dsss.tween_property($ColorRect,"modulate",Color(0.0, 0.0, 0.0, 0.0),1).set_trans(Tween.TRANS_SINE)
	await dsss.finished
	printerr("huh?")
