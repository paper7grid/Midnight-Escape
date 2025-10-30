extends CharacterBody2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var run_col: CollisionShape2D = $Run_col

const GRAVITY : int = 6200
const JUMP_SPEED : int = -1800

func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if not get_parent().game_run:
			$AnimatedSprite2D.play("Idle")
		else:
			$Run_col.disabled = false
			if Input.is_action_just_pressed("ui_accept"):
				velocity.y = JUMP_SPEED
				#$AudioStreamPlayer2D.play()
			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("Duck?")
				$Run_col.disabled = true
			else: 
				$AnimatedSprite2D.play("Walk")
	else:
		$AnimatedSprite2D.play("Idle")
	
	move_and_slide()
	
	
