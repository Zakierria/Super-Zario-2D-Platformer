extends CanvasLayer

signal restart_pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/Button.pressed.connect(_on_restart_pressed)
	hide() #hides until player dies 
	
func show_game_over():
	show()
	
func _on_restart_pressed():
	emit_signal("restart_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
