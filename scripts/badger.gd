extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_died

const SPEED = 100.0
var direction = -1.0

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += direction * SPEED * delta  #maintain steady moving speed
	
func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	#exclamation means opposite in this case

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.enemy_collision(self)# hit enemy from sie = die, hit enemy from top = enemy die

func die():
	#wait before falling 
	await get_tree().create_timer(0.3).timeout
	
	#falling down 
	position.y += 600
