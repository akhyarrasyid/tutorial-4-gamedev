extends Area2D

@export var teleport_x: float = 0.0
@export var teleport_y: float = 0.0

var on_cooldown := false

func _ready() -> void:
	monitoring  = true
	monitorable = true
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.get_name() == "Player" and not on_cooldown:
		on_cooldown = true
		# Teleport di frame berikutnya supaya tidak langsung trigger lagi
		await get_tree().process_frame
		body.global_position = Vector2(teleport_x, teleport_y)
		await get_tree().create_timer(0.8).timeout
		on_cooldown = false
