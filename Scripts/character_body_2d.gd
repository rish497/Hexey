extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed := 200


func _physics_process(delta):
	var input_vector := Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()

	if input_vector != Vector2.ZERO:
		_update_animation(input_vector)

func _update_animation(direction: Vector2):
	var angle := rad_to_deg(direction.angle())
	if angle < 0:
		angle += 360

	var anim := ""

	if angle >= 337.5 or angle < 22.5:
		anim = "E"
	elif angle >= 22.5 and angle < 67.5:
		anim = "SE"
	elif angle >= 67.5 and angle < 112.5:
		anim = "S"
	elif angle >= 112.5 and angle < 157.5:
		anim = "SW"
	elif angle >= 157.5 and angle < 202.5:
		anim = "W"
	elif angle >= 202.5 and angle < 247.5:
		anim = "NW"
	elif angle >= 247.5 and angle < 292.5:
		anim = "N"
	elif angle >= 292.5 and angle < 337.5:
		anim = "NE"
	else:
		anim = "IDLE"
	if sprite.animation != anim:
		sprite.animation = anim
		sprite.play()
