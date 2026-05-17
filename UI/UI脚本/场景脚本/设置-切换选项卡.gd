extends TabContainer


func _on_tab_clicked(tab: int) -> void:
	$"../AudioStreamPlayer".play()
