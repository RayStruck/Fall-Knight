extends Node2D

export var key = "k"
onready var anim = $AnimatedSprite

func _ready():
	anim.play(key)
	anim.stop()

func _on_Area2D_body_entered(_body):
	anim.play(key)


func _on_Area2D_body_exited(_body):
	anim.stop()
