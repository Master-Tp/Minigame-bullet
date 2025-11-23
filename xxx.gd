extends Node2D
var Health = 3
const SPEED = 300.0
var health = 3
@onready var bullet_scene = preload("res://Bulleet.tscn")
@export var shoot_cooldown = 3
var shoot_timer = 2
var hearts_list: Array[TextureRect]
func _ready() -> void:
	var hearts_parent = $CanvasLayer/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	print(hearts_list)

func _process(delta: float) -> void:
	shoot_timer = shoot_timer - delta
	self.position =get_global_mouse_position()
	if Input.is_action_just_released("Shoot") and shoot_timer <=0:
		shoot_bullet()
		shoot_timer = shoot_cooldown
func shoot_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = position - Vector2(150,400)
	get_tree().current_scene.add_child(bullet)
	





func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.is_in_group("bull"):
		take_damage()
		
func take_damage():
	health = health - 1
	update_heart_display()
	if health <=0:
		game_over()
func game_over():
	print("over")
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i< health
	
