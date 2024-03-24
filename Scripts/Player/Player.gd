extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	GameManager.player = self

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x)
			
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	update_animation()
	move_and_slide()
	
	if position.y >= 300:
		die()

func update_animation():
	if velocity.x != 0:
		animation.play("Movement")
	else:
		animation.play("Idle")
		
	if velocity.y < 0:
		animation.play("Jump")
	elif velocity.y > 0:
		animation.play("Fall")
		
func die():
	GameManager.respawn_player()
