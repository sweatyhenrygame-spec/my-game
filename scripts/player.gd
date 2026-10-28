extends AnimatedSprite2D

const SPEED := 300.0

var _last_dir := Vector2.DOWN

func _ready() -> void:
	animation_finished.connect(_on_animation_finished)
	play("idle")

func _process(delta: float) -> void:
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if dir == Vector2.ZERO:
		if animation != "idle":
			play("idle")
		return
	position += dir.normalized() * SPEED * delta
	# выбор направления с приоритетом последней оси
	if absf(dir.x) >= absf(dir.y):
		_last_dir = Vector2(signf(dir.x), 0)
	else:
		_last_dir = Vector2(0, signf(dir.y))
	var anim := _anim_for(_last_dir)
	if animation != anim:
		play(anim)

func _anim_for(d: Vector2) -> String:
	if d.x < 0.0:
		return "walk_left"
	if d.x > 0.0:
		return "walk_right"
	if d.y < 0.0:
		return "walk_up"
	return "walk_down"
