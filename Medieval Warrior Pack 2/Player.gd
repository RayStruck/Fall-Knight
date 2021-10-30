extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 120
const GRAVITY = 200
const JUMPHEIGHT = 200

var velocity = Vector2.ZERO
var stats = PlayerStats

onready var animp = $AnimatedSprite

onready var anims = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/SwordHitbox/collisionshape2d
onready var hitboxpivot = $hitboxpivot
onready var hurtbox = $hurtbox


func _ready():
	randomize()


func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = false
		hitboxpivot.rotation_degrees =0
		if(is_on_floor()):
			animp.play("running")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = true
		hitboxpivot.rotation_degrees =180
		if(is_on_floor()):
			animp.play("running")
	elif Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
		animp.play("attack")
		swordhitbox.disabled = false
		velocity.x = velocity.x/1.25
		velocity.y = velocity.y/1.25
	elif is_on_floor(): 
		velocity.x = move_toward(velocity.x, 0,FRICTION*delta)
		animp.play("idle")
		swordhitbox.disabled = true
		
	if Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
		animp.play("attack")
		if(animp.frame == 1 || animp.frame == 2):
			swordhitbox.disabled = false
		else:
			swordhitbox.disabled = true
		velocity = velocity/1.25
	elif Input.is_action_pressed("jump") && is_on_floor():
		animp.play("jump")
		velocity.y = -JUMPHEIGHT
	elif velocity.y > 0:
		animp.play("falling")

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	hurtbox.start_invincibility(1)

