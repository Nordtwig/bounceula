extends Area3D

@export_file("*.tscn") var next_scene


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_scene)
