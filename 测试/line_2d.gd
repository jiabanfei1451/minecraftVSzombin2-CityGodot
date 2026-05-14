extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	add_point($"..".position)
	position = $"..".position * -1
	print(points.get(20))
	if get_point_count() > 20:
		remove_point(01)
		
