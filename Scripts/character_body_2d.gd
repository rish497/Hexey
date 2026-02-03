extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var speed := 200
var teleported := false
var last_position_state := false

var cached_flag_position: Vector2
var flag_found := false

func _ready():
	self.visible = false
	get_tree().node_added.connect(_on_node_added)

	var flag := get_tree().get_first_node_in_group("flag_group")
	if flag:
		_connect_flag(flag)

func _on_node_added(node: Node):
	if node.is_in_group("flag_group"):
		_connect_flag(node)
		get_tree().node_added.disconnect(_on_node_added)

func _connect_flag(flag: Node):
	flag.position_ready.connect(_on_flag_position_ready)
	cached_flag_position = flag.global_position
	flag_found = true

func _on_flag_position_ready(pos: Vector2):
	if teleported:
		return

	cached_flag_position = pos

	if Global.position == true:
		global_position = cached_flag_position
		z_index = 4000
		teleported = true


func _process(delta: float) -> void:
	if Global.position == false:
		self.visible = false
func _physics_process(_delta):
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")


	if Global.position and not last_position_state:
		global_position = cached_flag_position
		z_index = 4000
		visible = true

	
	if not Global.position and last_position_state:
		visible = false

	last_position_state = Global.position

	if not Global.position:
		return

	velocity = input_vector * speed
	move_and_slide()

	if input_vector != Vector2.ZERO:
		_update_animation(input_vector)
	else:
		sprite.play("IDLE")
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

	if sprite.animation != anim:
		sprite.animation = anim
		sprite.play()
