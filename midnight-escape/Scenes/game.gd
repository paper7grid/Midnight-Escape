extends Node
@onready var skeleton: CharacterBody2D = $Skeleton
@onready var ground: StaticBody2D = $Ground

@onready var bg: ParallaxBackground = $Bg
@onready var camera_2d: Camera2D = $Camera2D

const SKELETON_START_POS := Vector2i(167, 541)
const CAM_START_POS := Vector2i(461, 398)
var score : int
var speed : float 
const start_speed : float = 8.0
const max_speed : int = 25
var screen_size : Vector2i
# Called when the node  enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	new_game()
	
func new_game():
	score = 0
	$Skeleton.position = SKELETON_START_POS
	$Skeleton.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(-3, -159)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed = start_speed
	
	#move skeleton and camera
	$Skeleton.position.x += speed
	$Camera2D.position.x += speed
	
	score += speed
	print(score)
	
	#updated ground pos
	
	if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
		$Ground.position.x += screen_size.x
