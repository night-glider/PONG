tool
extends EditorPlugin

var dock:Control

func _enter_tree():
	dock = preload("res://addons/pong/dock.tscn").instance()
	add_control_to_bottom_panel(dock, "PONG!")


func _exit_tree():
	remove_control_from_bottom_panel(dock)
	dock.queue_free()
