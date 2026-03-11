extends Node
class_name 精灵图列表
static var img : Array[Texture2D]
static var Pack : Array[PackedScene]

func _ready() -> void:
	img.append(preload("res://物体/素材图/精灵图/僵尸.png"))
	Pack.append(preload("res://物体/怪物/僵尸.tscn"))
	img.append(preload("res://物体/素材图/精灵图/发射器.png"))
	Pack.append(preload("res://物体/器械/发射器.tscn"))
	img.append(preload("res://物体/素材图/精灵图/熔炉.png"))
	Pack.append(preload("res://物体/器械/熔炉.tscn"))
	print(img)
