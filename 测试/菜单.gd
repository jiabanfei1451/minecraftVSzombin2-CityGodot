extends Control
var q : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	收起(1000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ESC"):
		if q == false:
			收起(0.5)
		else:
			展开(0.5)
			
func 收起(速度:float):
	q = true
	var s = create_tween()
	var ww = create_tween()
	s.tween_property($".","size",Vector2(0,0),0.25/速度).set_trans(Tween.TRANS_CUBIC)
	ww.tween_property($".","position",Vector2(size.x/2,size.y/2),0.25/速度).set_trans(Tween.TRANS_SINE)
 
func 展开(速度:float):
	q = false
	var s = create_tween()
	var ww = create_tween()
	ww.tween_property($".","position",Vector2(0,0),0.25/速度).set_trans(Tween.TRANS_CUBIC)
	s.tween_property($".","size",Vector2(1152,648),0.25/速度).set_trans(Tween.TRANS_SINE)
