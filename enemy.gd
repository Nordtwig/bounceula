extends Area3D

@export var _move_speed: float = 2.0
@export var move_direction: Vector3


var start_position: Vector3
var target_position: Vector3


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	start_position = global_position
	target_position = start_position + move_direction


func _process(delta) -> void:
	global_position = global_position.move_toward(target_position, _move_speed * delta)

	if global_position == target_position:
		if global_position == start_position:
			target_position = start_position + move_direction
		else:
			target_position = start_position
		

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.game_over()