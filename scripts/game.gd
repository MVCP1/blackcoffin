extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_main():
	return get_tree().get_root().get_node("main")
	pass

func get_player():
	return get_tree().get_root().get_node("main").get_node("player")
	pass