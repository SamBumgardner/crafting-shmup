extends Character

class_name Enemy

export var PROJECTILE_COOLDOWN_MAX = .5
export var PROJECTILE_VELOCITY = Vector2(0, 300)
export var COLLISION_MASK = 0b0101
export var COLLISION_LAYER = 0b0010
export var PROJECTILE_SPRITE_INDEX = 34

func _ready():
	$ShotCooldown.connect("timeout", self, "shoot")
	$ShotCooldown.wait_time = PROJECTILE_COOLDOWN_MAX
	$ShotCooldown.start();
	
	connect("area_shape_entered", self, "_on_area_shape_entered")
	collision_layer = COLLISION_LAYER
	collision_mask = COLLISION_MASK

func init(init_position):
	position = init_position

func shoot():
	emit_signal("fired_projectile", position, PROJECTILE_VELOCITY, 
		COLLISION_MASK, PROJECTILE_SPRITE_INDEX)

func _on_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	visible = false;
	$CollisionShape2D.set_deferred("disabled", true)
	queue_free()
	
