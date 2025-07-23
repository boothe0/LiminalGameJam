extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func transition():
	color_rect.visible = true
	animation_player.play("fade_to_normal")

func _on_animation_finished(anim_name):
	Emitter.on_transition_finished.emit()
	color_rect.visible = false
