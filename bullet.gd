extends Node2D
const speed = 100

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	position += transform.x * speed * delta


func _on_timer_timeout() -> void:
	pass # Replace with function body.
