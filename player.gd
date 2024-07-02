extends CharacterBody3D

@export var _move_speed: float = 4.0 
@export var _jump_force: float = 8.0
@export var gravity: float = 20.0

var _facing_angle: float
var score: int

@onready var model: MeshInstance3D = get_node("Model")
@onready var score_label: Label = get_node("ScoreLabel")


func _process(_delta) -> void:
	# if character is below a certain y value, run game over
	if global_position.y < -8:
		game_over()


func _physics_process(delta) -> void:
	# assign gravity if character is in the air
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# if jump action pressed assign jump force
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = _jump_force

	# get keyboard input and calculate move direction
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = Vector3(input.x, 0, input.y)

	# assign that direction to velocity
	velocity.x = direction.x * _move_speed
	velocity.z = direction.z * _move_speed
	
	# apply velocity
	move_and_slide()

	# if we are moving, set facing direction
	if input.length() > 0:
		_facing_angle = Vector2(input.y, input.x).angle()
	
	# rotate model to facing direction
	model.rotation.y = lerp_angle(model.rotation.y, _facing_angle, 0.5)


func game_over() -> void:
	# reload current scene
	get_tree().reload_current_scene()


func add_score(amount: int) -> void:
	score += amount
	score_label.text = "Score: " + str(score)
