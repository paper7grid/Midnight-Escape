extends CharacterBody2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_SPEED
		$AudioStreamPlayer2D.play()
		
	
