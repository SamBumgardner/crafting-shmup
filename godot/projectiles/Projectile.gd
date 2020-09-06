extends Area2D

var SCREEN_SIZE

var velocity = Vector2();

func _ready():
	SCREEN_SIZE = get_viewport_rect().size

# Note: sprite_frame references an index in the (temporary) image atlas.
func init(spawn_position, spawn_velocity, spawn_collision_mask, sprite_frame):
	position = spawn_position
	velocity = spawn_velocity
	collision_layer = 0
	collision_mask = spawn_collision_mask
	$AnimatedSprite.frame = sprite_frame
	connect("area_shape_entered", self, "_on_area_shape_entered")

func isOutOfBounds():
	if position.x < 0 or position.x > SCREEN_SIZE.x or position.y < 0 or position.y > SCREEN_SIZE.y:
		return true
	else:
		return false

func _physics_process(delta):
	position += velocity * delta
	if isOutOfBounds():
		free()

func _on_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	visible = false;
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
