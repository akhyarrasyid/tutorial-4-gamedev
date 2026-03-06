extends RigidBody2D

@export var sceneName: String = "Level1"

# Hubungkan signal body_entered dari tab Signals ke fungsi ini
func _on_body_entered(body):
	if body.name == "Player":
		# Kalau kena player, ulang level
		get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
	else:
		# Kalau kena lantai, ikannya hilang biar nggak menumpuk dan bikin lag
		queue_free()
