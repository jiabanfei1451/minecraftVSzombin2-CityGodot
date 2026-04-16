extends CanvasLayer
var key = "asd4156asd456as4d6sad"
func _ready() -> void:
	创建文件夹("set")
	_save()
	创建对话内容()
	await get_tree().create_timer(1).timeout
	_Load()
func _save() -> void:
	var savecolor = ConfigFile.new()
	savecolor.set_value("sett","color",1)
	savecolor.set_value("sett","name",2)
	savecolor.save_encrypted_pass("D:/sett.cfg",key)
	
	print("saved!")
func 创建对话内容() -> void:
	var 对话文件 = JSON.new()
	对话文件.data = {
		"dds" = 14,
		"sd" = Color(0.793, 0.0, 0.726, 1.0)
		}
	ResourceSaver.save(对话文件,"D:/json.json",ResourceSaver.FLAG_NONE)
	var 读取 : JSON = preload("D:/json.json")
	print(读取.data.dds)

func _Load() -> void:
	var config = ConfigFile.new()
	var err = config.load_encrypted_pass("D:/sett.cfg",key)
	if err == OK:
		print(config.get_value("sett","name"))
	else:
		printerr("无法读写原因：未识别到文件夹")
# 核心函数：创建文件夹
func create_game_folder(folder_path: String) -> bool:
	# 1. 获取目录访问器（使用用户数据目录，这是推荐的安全路径）
	# user:// 是 Godot 的特殊路径，表示游戏的用户数据目录（不同平台路径不同）
	# 如果要创建到游戏安装目录，可使用 res://，但注意：部分平台（如 Windows）安装目录可能无写入权限
	var dir = DirAccess.open("user://")
	if dir == null:
		print("错误：无法访问用户数据目录！")
		return false
	
	# 2. 拼接完整路径并创建文件夹（make_dir_recursive 会自动创建多级目录，比如 a/b/c）
	var full_path = "user://" + folder_path
	if not dir.file_exists(full_path):  # 先检查文件夹是否已存在，避免重复创建
		dir.make_dir_recursive(full_path)
		print("文件夹创建成功：", full_path)
		return true
	else:
		print("文件夹已存在：", full_path)
		return true
func playLoad(路径:String) -> void:
	var config = ConfigFile.new()
	var err = config.load_encrypted_pass("user://"+路径,key)
	if err == OK:
		pass
	else:
		printerr("无法读写原因：未识别到文件夹")

func 创建文件夹(folder_path: String) -> bool:
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
