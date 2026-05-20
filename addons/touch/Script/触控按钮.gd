@tool
@icon("uid://chmpegjqy4btn")
## 可触摸的超链接按钮
extends Touchbutton
class_name LinkTouch
@export var URL : String = "https://space.bilibili.com/3546884492757767"

func _on_点击时void() -> void:
	OS.shell_open(URL)
