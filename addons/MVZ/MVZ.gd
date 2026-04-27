@tool
extends EditorPlugin
var conrl : PackedScene = preload("res://addons/MVZ/114514.tscn")
var coi : int
var col : Control

func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	var con = conrl.instantiate()
	con.name = "114514"
	col = con
	add_control_to_dock(DOCK_SLOT_RIGHT_BL,con)


func _exit_tree() -> void:
	remove_control_from_docks(col)
	conrl.queue_free()
