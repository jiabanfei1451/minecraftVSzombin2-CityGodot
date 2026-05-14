extends Node
class_name SaveService

const SAVE_PATH: String = "user://game.save"
const SAVE_BAK1_PATH: String = "user://game.save.bak1"
const SAVE_BAK2_PATH: String = "user://game.save.bak2"
const SAVE_TMP_PATH: String = "user://game.save.tmp"

const PATHS: Array[String] = [SAVE_PATH, SAVE_BAK1_PATH, SAVE_BAK2_PATH]

const SAVE_VERSION: int = 1

func _ready() -> void:
	save_to_disk()
func _process(delta: float) -> void:
	if Input.is_action_just_released("DEBUG"):
		save_to_disk()
	if Input.is_action_just_released("LOAD"):
		load_from_disk()
#region save
func save_to_disk() -> void:
	var save_dict: Dictionary = _get_save_dict()
	
	# 将 Variant 变量转换为 JSON 文本并返回结果。\t 用于制表符缩进，或分别为每个缩进换行。
	var json_text: String = JSON.stringify(save_dict, "\t")
	if json_text.is_empty():
		return
	
	# 写入 json_text
	if not _write_file_atomic(json_text):
		return
	
	# 写入成功后，滚动备份
	_rotate_backups_and_commit()
	print("Game saved.")


func _get_save_dict() -> Dictionary:
	var save_dict: Dictionary = {
		"version": SAVE_VERSION,
		"save_time": Time.get_datetime_string_from_system(),
		"entries": []
	}
	
	var savable_nodes: Array[Node] = get_tree().get_nodes_in_group("savable")
	for node: Node in savable_nodes:
		# 若节点没有对应的方法，跳过该节点
		if not node.has_method("save_data"):
			continue
		
		var node_data: Variant = node.save_data()
		if not node_data is Dictionary:
			continue
			
		var entry: Dictionary = {
			"path": str(node.get_path()),
			"class": node.get_class(),
			"data": node_data
		}
		save_dict["entries"].append(entry)
	
	return save_dict


func _write_file_atomic(json_text: String) -> bool:
	# 暂时写入 tmp 文件
	var file: FileAccess = FileAccess.open(SAVE_TMP_PATH, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(json_text)
	file.close()
	return true


func _rotate_backups_and_commit() -> void:
	# 删除 bak2
	if FileAccess.file_exists(SAVE_BAK2_PATH):
		DirAccess.remove_absolute(SAVE_BAK2_PATH)
	# bak1 -> bak2
	if FileAccess.file_exists(SAVE_BAK1_PATH):
		DirAccess.rename_absolute(SAVE_BAK1_PATH, SAVE_BAK2_PATH)
	# save -> bak1
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.rename_absolute(SAVE_PATH, SAVE_BAK1_PATH)
	# tmp -> save
	DirAccess.rename_absolute(SAVE_TMP_PATH, SAVE_PATH)
	# 删除 tmp
	if FileAccess.file_exists(SAVE_TMP_PATH):
		DirAccess.remove_absolute(SAVE_TMP_PATH)
#endregion


#region Load
func load_from_disk() -> void:
	# 逐一对每个路径加载，若所有路径加载失败，则加载失败
	for path in PATHS:
		if _try_load_from_path(path):
			return



func _try_load_from_path(path: String) -> bool:
	# 如果文件不存在于给定路径中
	if not FileAccess.file_exists(path):
		return false
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	# 如果打开文件失败
	if file == null:
		return false
	
	# 以 String 形式返回整个文件，文本会按照 UTF-8 编码解析。
	var file_text: String = file.get_as_text()
	file.close()
	
	# 试图解析 file_text，并返回解析后的数据。
	var parsed_text: Variant = JSON.parse_string(file_text)
	# 如果解析后的数据不是 Dictionary（包含解析失败的情况）。
	if not parsed_text is Dictionary:
		return false
	
	var save_dict: Dictionary = parsed_text
	# 对每一项条目进行加载
	for entry in save_dict["entries"]:
		var node_path: String = str(entry.get("path", ""))
		var node_data: Dictionary = entry.get("data", {})
		# 如果预加载的节点不存在于给定路径中，或数据类型不是 Dictionary，跳过该节点。
		if node_path.is_empty() or not node_data is Dictionary:
			continue
		# 找到节点，并调用节点的 load_data() 方法
		var node: Node = get_tree().root.get_node_or_null(node_path)
		if node and node.has_method("load_data"):
			node.load_data(node_data)
	print("Game loaded.")
	return true
#endregion
