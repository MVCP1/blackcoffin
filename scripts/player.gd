extends RigidBody


# Declare member variables here. Examples:
var sensitivity = -0.001
var force = 500

var fuel = 1.000
var contact = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#FUEL LEVEL CONTROL
	fuel = clamp(fuel + (0.2*delta), 0.000, 1.000)
	get_node("Sprite2").modulate = Color(1.000-fuel,fuel,0,1)
	get_node("Sprite2").rotation_degrees = 360 - (360*fuel)
	
	#GRAB SPRITE CONTROL
	if contact:
		if Input.is_action_pressed("rmouse"):
			get_node("Sprite").modulate = Color(0,0,1,1)
			fuel = 1.000
		else:
			get_node("Sprite").modulate = Color(0,1,0,1)
	else:
		get_node("Sprite").modulate = Color(1,0,0,1)
		
	#MOUSE VISIBILITY
	if Input.is_action_just_pressed("alt"):
		if Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	pass


func _input(event):
	#CAMERA ROTATION
	if event is InputEventMouseMotion:
		get_node("Camera").set_rotation(get_node("Camera").get_rotation() + Vector3(event.relative.y * sensitivity,event.relative.x * sensitivity, 0))


func _physics_process(delta):
	#IMPULSE
	if Input.is_action_just_pressed("space") and not Input.is_action_pressed("rmouse") and fuel == 1.000:
		fuel = 0.000
		add_central_force((get_node("Camera").get_node("Position3D").get_global_transform().origin - get_translation()) * force)
	#GRAB
	if contact:
		if Input.is_action_pressed("rmouse"):
			set_linear_velocity(Vector3(0,0,0))
			get_node("Sprite").modulate = Color(0,1,0,1)
			
	get_node("Camera").get_node("RayCast").force_raycast_update()
	if get_node("Camera").get_node("RayCast").is_colliding():
		$Sprite3.modulate = Color(1,1,1,1)
		$Obj.text = get_node("Camera").get_node("RayCast").get_collider().to_string()
	else:
		$Sprite3.modulate = Color(0,0,0,1)
		$Obj.text = "null"
		
	if Input.is_action_pressed("lmouse") and get_node("Camera").get_node("RayCast").is_colliding():
		get_node("Camera").get_node("RayCast").get_collider().free()
	pass



func _on_Area_body_entered(body):
	contact = true
	pass # Replace with function body.

func _on_Area_body_exited(body):
	contact = false
	pass # Replace with function body.
