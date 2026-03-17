extends Node2D
@export var key : String = "quanyvjiabanfei is key"
@export var namer : LineEdit
@export var playcolor : ColorPickerButton

func _ready() -> void:
	create_game_folder("mapSave")
	create_game_folder("playerSaves")

func mapSave(路径:String,地图名称:String,剩余器械能:float,剩余星之碎片:int) -> void:
	var save = ConfigFile.new()
	save.set_value("地图","地图名称",地图名称)
	save.set_value("地图","器械能",剩余器械能)
	save.set_value("地图","星之碎片",剩余星之碎片)
	save.save_encrypted_pass("user://"+路径,key)
	print("地图完成储存")

func playSave(路径:String) -> void:
	var savecolor = ConfigFile.new()
	savecolor.set_value("sett","color","sadasdsad")
	savecolor.set_value("sett","name","namer.text")
	savecolor.save_encrypted_pass("user://"+路径,key)
	
	print("saved!")

func playLoad(路径:String) -> void:
	var config = ConfigFile.new()
	var err = config.load_encrypted_pass("user://"+路径,key)
	if err == OK:
		pass
	else:
		printerr("无法读写原因：未识别到文件夹")

func create_game_folder(folder_path: String) -> bool:
	# 1. 获取目录访问器（使用用户数据目录，这是推荐的安全路径）
	# user:// 是 Godot 的特殊路径，表示游戏的用户数据目录（不同平台路径不同）
	# 如果要创建到游戏安装目录，可使用 res://，但注意：部分平台（如 Windows）安装目录可能无写入权限
	var dir = DirAccess.open("user://")
	if dir == null:
		printerr("错误：无法访问用户数据目录！")
		return false
	
	# 2. 拼接完整路径并创建文件夹（make_dir_recursive 会自动创建多级目录，比如 a/b/c）
	var full_path = "user://" + folder_path
	if not dir.file_exists(full_path):  # 先检查文件夹是否已存在，避免重复创建
		dir.make_dir_recursive(full_path)
		print("文件夹创建成功：", full_path)
		return true
	else:
		printerr("文件夹已存在：", full_path)
		return true
