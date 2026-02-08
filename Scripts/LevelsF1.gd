extends Node2D
@onready var levels_f_1: Node2D = $"."
@onready var texture_rect: TextureRect = $F1/TextureRect
@onready var texture_rect_2: TextureRect = $F2/TextureRect2
@onready var texture_rect_3: TextureRect = $F3/TextureRect3
@onready var texture_rect_4: TextureRect = $F4/TextureRect4
@onready var texture_rect_5: TextureRect = $F5/TextureRect5
@onready var texture_rect_6: TextureRect = $F6/TextureRect6


func _process(delta: float) -> void:
	if Global.F1_level1_pass == true:
		texture_rect.visible = true
	if Global.F1_level2_pass == true:
		texture_rect_2.visible = true
	if Global.F1_level3_pass == true:
		texture_rect_3.visible = true
	if Global.F1_level4_pass == true:
		texture_rect_4.visible = true
	if Global.F1_level5_pass == true:
		texture_rect_5.visible = true
	if Global.F1_level6_pass == true:
		texture_rect_6.visible = true
	
func _on_button_pressed() -> void:
	Global.clicksound()
	print("close")
	hide_popup(levels_f_1)

func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0
	)


func _on_button_f_1_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self,"level_1")


func _on_button_f_2_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self,"level_2")


func _on_button_f_3_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self,"level_3")


func _on_button_f_4_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self, "level_4")


func _on_button_f_5_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self, "level_5")
