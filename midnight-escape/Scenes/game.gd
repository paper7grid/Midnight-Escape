extends Node
#obstacles scenes: 
var blob_scene = preload("res://Scenes/enemyblob.tscn")
var grave_scene = preload("res://Scenes/grave.tscn")
var crow_scene = preload("res://Scenes/crow.tscn")


@onready var skeleton: CharacterBody2D = $Skeleton
@onready var ground: StaticBody2D = $Ground
@onready var txt_1: CanvasLayer = $txt1
@onready var bg: ParallaxBackground = $Bg
@onready var camera_2d: Camera2D = $Camera2D

const SKELETON_START_POS := Vector2i(167, 541)
const CAM_START_POS := Vector2i(461, 398)
var score : int
const score_m : int = 10
var speed : float 
const start_speed : float = 9.0
const max_speed : int = 25
const speed_m : int = 5000
var screen_size : Vector2i
var game_run : bool
# Called when the node  enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	new_game()
	
func new_game():
	score = 0
	show_score()
	game_run = false
	$Skeleton.position = SKELETON_START_POS
	$Skeleton.velocity = Vector2i(0,0)
	$Camera2D.position = CAM_START_POS
	$Ground.position = Vector2i(-3, -159)
	$txt1.get_node("Start").show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_run:
		speed = start_speed + score / speed_m
		if speed > max_speed: 
			speed = max_speed
			
		#move skeleton and camera
		$Skeleton.position.x += speed
		$Camera2D.position.x += speed
		
		score += speed
		show_score()
		
		#updated ground pos
		
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else: 
		if Input.is_action_just_pressed("ui_accept"):
			game_run = true
			$txt1.get_node("Start").hide()

func show_score():
	$txt1.get_node("Score_label").text = "SCORE: " + str(score / score_m)
