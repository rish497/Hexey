extends Control
@onready var wizard: Node2D = $Wizard
@onready var WizardAnimation: AnimatedSprite2D = $Wizard/Wizard

func _ready() -> void:
	WizardAnimation.play("Idle")
