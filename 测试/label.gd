extends CanvasLayer

func _process(delta):
   var mouse_position = get_viewport().get_mouse_position()
   print("鼠标绝对位置: ", mouse_position)
