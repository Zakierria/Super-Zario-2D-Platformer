extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal coins_collected
var collected:= false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#making sure coins detect collision
	monitoring = true
	monitorable = true
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if collected:
		return
	#making sure only player can collect coins 
	if body.name == "Player":
		collected = true
		animated_sprite_2d.animation = "spinning"
		print("Coin touched!")
		# wanted to make sure teh coin signls were emitted 
		emit_signal("coins_collected")
		print("coin collected signal emitted")
		
		#removes cherry from game 
		queue_free()
