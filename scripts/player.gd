extends RigidBody


# Declare member variables here. Examples:
var sensitivity = -0.001
var force = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("alt"):
		if Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Input.is_action_just_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("space"):
		add_central_force((get_node("Camera").get_node("Position3D").get_global_transform().origin - get_translation()) * force)
	pass

func _input(event):
	if event is InputEventMouseMotion:
		get_node("Camera").set_rotation(get_node("Camera").get_rotation() + Vector3(event.relative.y * sensitivity,event.relative.x * sensitivity, 0))
