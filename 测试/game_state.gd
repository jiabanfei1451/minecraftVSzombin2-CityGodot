extends Node
class_name GameState

signal coin_changed

var coin_count: int = 0: set = _set_coin_count


func _set_coin_count(value: int) -> void:
	coin_count = value
	coin_changed.emit()
