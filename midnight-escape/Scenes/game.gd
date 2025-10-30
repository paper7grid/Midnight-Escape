extends Node
#obstacles scenes: 
var blob_scene = preload("res://Scenes/enemyblob.tscn")
var grave_scene = preload("res://Scenes/grave.tscn")
var crow_scene = preload("res://Scenes/crow.tscn")
var obstacles_t := [blob_scene, grave_scene]
var obst : Array
var crow_he := [200, 390]

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
var ground_height : int 
var screen_size : Vector2i
var game_run : bool
var last_ob 
# Called when the node  enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
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
			
		#Obstacles
		generate_obs()
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

func generate_obs():
	#grnd obs 
	if obst.is_empty():
		var obs_type = obstacles_t[randi() % obstacles_t.size()]
		var obs
		obs = obs_type.instantiate()
		var obs_height = obs.get_node("Sprite2D").texture.get_height()
		var obs_scale = obs.get_node("Sprite2D").scale
		var obs_x : int = screen_size.x + score + 150
		var obs_y : int = screen_size.y - ground_height - (obs_height * obs_scale.y / 2) + 5
		last_ob = obs
		obs.position = Vector2i(obs_x, obs_y)
		
		add_child(obs)
		obst.append(obs)
		
	

func show_score():
	$txt1.get_node("Score_label").text = "SCORE: " + str(score / score_m)
