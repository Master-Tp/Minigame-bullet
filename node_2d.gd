extends Node2D

const BulletScene = preload("res://bullet.tscn")
@onready var shoot_timer: Timer = $ShootTimer
@onready var rotater: Node2D = $Rotater
var health = 20
const rotate_speed := 100.0
const shooter_timer_wait_time := 0.2
const spawn_point_count := 5
const radius := 100.0

func _ready() -> void:
	# Connect timer signal in Godot 4
	shoot_timer.timeout.connect(_on_ShootTimer_timeout)

	var step = TAU / spawn_point_count

	for i in range(spawn_point_count):
		var spawn_point := Node2D.new()
		var pos := Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)

	shoot_timer.wait_time = shooter_timer_wait_time
	shoot_timer.start()


func _process(delta: float) -> void:
	var new_rotation := rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360.0)


func _on_ShootTimer_timeout() -> void:
	for s in rotater.get_children():
		var bullet := BulletScene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.global_position = s.global_position
		bullet.global_rotation = s.global_rotation
		


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("wave"):
		take_damage()
		
		
func take_damage():
	health = health - 1
	if health <=0:
		game_over()
func game_over():
	print("win")
