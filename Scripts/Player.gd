extends KinematicBody2D

const ACCELARATION = 1500
const MAX_SPEED = 300
const JUMP_POWER = -800
const FRICTION = 1
const GRAVITY = 2400
const AIR_RESISTANCE = 0.4

var motion = Vector2.ZERO

onready var sprite = $Sprite

func _physics_process(delta):
	
	#var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	var x_input = 0
	if Input.is_action_pressed("right"):
		x_input = 2.5
	if Input.is_action_pressed("left"):
		x_input = -2.5
	
	
	if x_input!=0:
		motion.x+=x_input*ACCELARATION*delta
		motion.x = clamp(motion.x,-MAX_SPEED,MAX_SPEED)
		sprite.flip_h = x_input < 0
	
	if is_on_floor():
		if x_input==0:
			motion.x = lerp(motion.x,0,FRICTION)
	
		if Input.is_action_just_pressed("jump"):
			motion.y = JUMP_POWER
	
	else:
		if Input.is_action_just_released("jump") and motion.y<JUMP_POWER/2:
			motion.y = JUMP_POWER/2
	
		if x_input==0:
			motion.x = lerp(motion.x,0,AIR_RESISTANCE)
	
	motion.y += GRAVITY*delta
	
	motion = move_and_slide(motion, Vector2.UP)
	
