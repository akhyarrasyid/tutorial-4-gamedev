extends Node2D

@export var obstacle : PackedScene 
@export var spawn_delay : float = 3.0 

func _ready():
	start_spawning()

func start_spawning():
	spawn_fish()
	await get_tree().create_timer(spawn_delay).timeout
	start_spawning()

func spawn_fish():
	if obstacle:
		var fish_instance = obstacle.instantiate()
		# Taruh ikan di dalam level
		get_parent().add_child(fish_instance)
		
		var pos = global_position
		pos.x += randf_range(-800, 800)
		fish_instance.global_position = pos
