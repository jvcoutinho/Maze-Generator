extends RigidBody

func _ready():
	bounce = 0.6

func _input(event):
	if event is InputEventKey and event.scancode == KEY_SPACE:
		set_axis_velocity(Vector3.UP * 10)

func _physics_process(delta):
	if Input.is_key_pressed(KEY_W):
		angular_velocity = Vector3.LEFT * delta * 400
	if Input.is_key_pressed(KEY_S):
		angular_velocity = Vector3.RIGHT * delta * 400
	if Input.is_key_pressed(KEY_D):
		angular_velocity = Vector3.FORWARD * delta * 400
	if Input.is_key_pressed(KEY_A):
		angular_velocity = Vector3.BACK * delta * 400