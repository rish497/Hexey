extends Node
var position = false
var level_amount
var folder_collected = 0
var total_folder_collected = 0
var last_position_state := false
var max_z
var player_top_z := 100000
var profile_name: String
var email_animation_played := false
var goal := 500
var custom_cursor = preload("res://Assets/New Piskel-5.png (1).png")
var hand_cursor = preload("res://Assets/New Piskel-5.png (1).png")
var Display_level = false
var last_completed_level := 0
var F1_level1_pass=false
var F1_level2_pass=false
var F1_level3_pass=false
var F1_level4_pass=false
var F1_level5_pass=false
var F1_level6_pass=false
var level_pass = false
var bit := 0
@onready var audio_stream_player_12: AudioStreamPlayer = $AudioStreamPlayer12
func collectsound():
	audio_stream_player_11.play()
@onready var audio_stream_player_11: AudioStreamPlayer = $AudioStreamPlayer11
func buildup():
	audio_stream_player_11.play()
@onready var audio_stream_player_9: AudioStreamPlayer = $AudioStreamPlayer9
func tpsound():
	audio_stream_player_9.play()
@onready var audio_stream_player_10: AudioStreamPlayer = $AudioStreamPlayer10
func shieldsound():
	audio_stream_player_10.play()
func shieldsoundstop():
	audio_stream_player_10.stop()
@onready var audio_stream_player_8: AudioStreamPlayer = $AudioStreamPlayer8
func throwsound():
	audio_stream_player_8.play()
@onready var audio_stream_player_7: AudioStreamPlayer = $AudioStreamPlayer7
func mouthsound():
	audio_stream_player_7.play()
func moutsoundstop():
	audio_stream_player_7.stop()
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
func clicksound():
	audio_stream_player_3.play()
@onready var audio_stream_player_4: AudioStreamPlayer = $AudioStreamPlayer4
func explosionsound():
	audio_stream_player_4.play()
func letter_in():
	audio_stream_player_2.play()
@onready var audio_stream_player_6: AudioStreamPlayer = $AudioStreamPlayer6
func aliensound():
	audio_stream_player_6.play()
func aliensoundstop():
	audio_stream_player_6.stop()
var collected := false
var collect_playing := false
@onready var audio_stream_player_13: AudioStreamPlayer = $AudioStreamPlayer13
func error():
	audio_stream_player_13.play()
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
var bgmusic := false
@onready var audio_stream_player_14: AudioStreamPlayer = $AudioStreamPlayer14
func teleport():
	audio_stream_player_14.play()
@onready var audio_stream_player_15: AudioStreamPlayer = $AudioStreamPlayer15
func money():
	audio_stream_player_15.play()
	
func _process(_delta: float) -> void:
	if bgmusic and not audio_stream_player.playing:
		audio_stream_player.play()
	if collected and not collect_playing:
		collect_playing = true
		play_collect_sound()
func play_collect_sound() -> void:
	$AudioStreamPlayer12.play()
	await $AudioStreamPlayer12.finished
	collected = false
	collect_playing = false
var dragging_tile: Node = null

func set_cursor(cursor):
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW) 
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_POINTING_HAND)

func set_hex_covered(hex_sprite: Sprite2D, covered: bool, top_height: int, full_height: int) -> void:
	if not hex_sprite or not hex_sprite.texture:
		return

	hex_sprite.region_enabled = true

	if covered:
		# Show only the green top
		hex_sprite.region_rect = Rect2(
			Vector2(0, 0),
			Vector2(hex_sprite.texture.get_width(), top_height)
		)
	else:
		# Show full sprite
		hex_sprite.region_rect = Rect2(
			Vector2.ZERO,
			Vector2(hex_sprite.texture.get_width(), full_height)
		)
	
