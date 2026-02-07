extends Node2D
@onready var mouse: AnimatedSprite2D = $Mouse
@onready var d: Sprite2D = $D
@onready var s: Sprite2D = $S
@onready var a: Sprite2D = $A
@onready var w: Sprite2D = $W
@onready var pressed_w: Label = $PressedW
@onready var pressed_s: Label = $PressedS
@onready var pressed_a: Label = $PressedA
@onready var pressed_d: Label = $PressedD
@onready var level_block: Node2D = $LevelBlock
@onready var cursor: Sprite2D = $Cursor
@onready var sprite: AnimatedSprite2D = $LevelBlock/AnimatedSprite2D

func _ready() -> void:
	mouse.play("NotClicked")
	w.visible = true
	a.visible = true
	s.visible = true
	d.visible = true	
	pressed_a.visible = false
	pressed_d.visible = false
	pressed_s.visible = false
	pressed_w.visible = false
	level_block.position = Vector2(-2,27)
	cursor.position = Vector2(4,65)
	start_sequence()

func start_sequence() -> void:
	while true:
		move_to(cursor,Vector2(-131,65))
		mouse.play("NotClicked")
		await get_tree().create_timer(1).timeout
		mouse.play("Clicked")
		move_to(level_block,Vector2(127,27))
		move_to(cursor,Vector2(4,65))
		await get_tree().create_timer(1).timeout
		mouse.play("NotClicked")
		await get_tree().create_timer(.4).timeout
		w.visible = false
		pressed_w.visible = true
		sprite.play("N")
		await get_tree().create_timer(.5).timeout
		d.visible = false
		pressed_d.visible = true
		sprite.play("NE")
		await get_tree().create_timer(.5).timeout
		w.visible = true
		pressed_w.visible = false
		sprite.play("E")
		await get_tree().create_timer(.5).timeout
		s.visible = false
		pressed_s.visible = true
		sprite.play("SE")
		await get_tree().create_timer(.5).timeout
		d.visible = true
		pressed_d.visible = false
		sprite.play("S")
		await get_tree().create_timer(.5).timeout
		a.visible = false
		pressed_a.visible = true
		sprite.play("SW")
		await get_tree().create_timer(.5).timeout
		s.visible = true
		pressed_s.visible = false
		sprite.play("W")
		await get_tree().create_timer(.5).timeout
		w.visible = false
		pressed_w.visible = true
		sprite.play("NW")
		await get_tree().create_timer(.5).timeout
		w.visible = true
		a.visible = true
		s.visible = true
		d.visible = true
	
		pressed_a.visible = false
		pressed_d.visible = false
		pressed_s.visible = false
		pressed_w.visible = false
		sprite.stop()
		await get_tree().create_timer(.5).timeout
		mouse.play("Clicked")
		move_to(cursor,Vector2(-131,65))
		move_to(level_block,Vector2(-2,27))
		await get_tree().create_timer(1).timeout
		mouse.play("NotClicked")
		move_to(cursor,Vector2(4,65))
		await get_tree().create_timer(1).timeout
		
func move_to(panel, target_pos: Vector2, duration := .6):
	var t := create_tween()
	t.tween_property(
		panel,
		"position",
		target_pos,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


func _on_button_pressed() -> void:
	hide_popup(self)
	
func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0)
