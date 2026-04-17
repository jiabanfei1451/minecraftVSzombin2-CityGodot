extends Node
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
]

func _ready() -> void:
	get_window().title = "Minecraft VS Zombies 2 CityGodot - " + 版本 + " " + 标题提示语.pick_random()
