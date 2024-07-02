extends Area3D

var _spin_speed: float = 2.0
var bob_height: float = 0.2
var bob_speed: float = 5.0

var time: float = 0.0

@onready var start_y: float = global_position.y


func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta) -> void:
	rotate(Vector3.UP, _spin_speed * delta)

	time += delta
	var d = (sin(time * bob_speed) + 1) / 2
	global_position.y = start_y + (d * bob_height)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		body.add_score(1)
		queue_free()