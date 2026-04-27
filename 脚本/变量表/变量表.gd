extends Node
static var 卡槽提示词动画 : bool
@export_range(0,10,0.4) var 卡槽数量 : int = 6
@export var 版本 : StringName = "beta0.0.5"
@export var 标题提示语 : Array[String] = [
"看什么？",
"快去试试《Terraria》吧！",
"本作是Cuerzor制作的《MVZ2》的同人游戏",
"给这个同人作者打赏？认真的？",
"知道吗？该版本之前还只是创游上的小游戏而已",
"神权",
"(DEBUG)",
"/kill @e[name=!steve]",
"",
"幽匿天下！！！",
"Fabric",
"NeoFoger",
"Foger",
"DIE",
"有只僵尸在你的草评上",
"如有器械侵权？请反馈！",
OS.get_user_data_dir(),
"MVM vs MVZ = MMVMZ",
"1+1=3",
str(Time.get_time_string_from_system()),
"我把你户口开了你的IP是：" + "127.0.0.1",
]

func _input(event: InputEvent) -> void:
	if event.is_released() and event.as_text() == "P":
		重置标题语()
func _ready() -> void:
	重置标题语()
	if 存档.读取数据("config.cfg","设置","卡槽动画") != null:
		卡槽提示词动画 = 存档.读取数据("config.cfg","设置","卡槽动画")
func 重置标题语():
	if OS.get_name() == "Windows":
		get_window().title = "MinecraftVSZombies2-CityGodot " + 版本 + " " + 标题提示语.pick_random()
		
func is_windows_admin() -> bool:
	var dir = OS.get_environment("WINDIR") + "\\System32"
	var test_path = dir + "\\test.tmp"
	var file = FileAccess.open(test_path, FileAccess.WRITE)
	if file:
		file.close()
		DirAccess.remove_absolute(test_path)
		return true
	return false
