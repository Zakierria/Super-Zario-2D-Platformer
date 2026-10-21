extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 350.0
const JUMP_VELOCITY = -700.0
var alive := true
var score := 0
var score_label

func _ready():#fixed score label to coreectly show collected cherry points 
	score_label = get_node_or_null("/root/Main/ScoreUI/ScoreLabel")
	
	if score_label:
		print("ScoreLabel found")
		update_score_ui()
	else:
		print("error: ScoreLabel not found, check the scene path.")
		
func _physics_process(delta: float) -> void:
	if !alive:
		velocity += get_gravity() * delta
		move_and_slide()
		return
		
	if abs(velocity.x) > 1:
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		
#score functions 
func _on_coin_collected():
	score += 100
	print("Coin Collected", score)
	update_score_ui()
	
func update_score_ui():
	if is_instance_valid(score_label):
		score_label.text = "Score: " + str(score)
		print("score updated", score)
	else:
		print("error, score label not found")
		
#enemy death and collision
func die() -> void:
	if alive: 
		alive = false
		animated_sprite_2d.animation = "dying"
		collision_layer = 0
		collision_mask = 0
		
		await get_tree().create_timer(0.4).timeout
		velocity.y = 600
		
		get_tree().current_scene._on_player_died(self)
		
func enemy_collision(enemy):
	if velocity.y > 0:
		enemy.die()
		score +=200
		update_score_ui()
		velocity.y = JUMP_VELOCITY / 2
	else:
		die()

		
		
		
		


func _on_coins_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
