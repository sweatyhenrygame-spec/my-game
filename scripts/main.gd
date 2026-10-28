extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		print("Key pressed: ", event.keycode)
		get_tree().quit()
