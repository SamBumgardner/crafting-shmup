extends Character

class_name Player

export var SPEED = 400
export var PROJECTILE_COOLDOWN_MAX = .1
export var PROJECTILE_VELOCITY = Vector2(0, -500)
export var COLLISION_MASK = 0b0110
export var COLLISION_LAYER = 0b0001
export var PROJECTILE_SPRITE_INDEX = 32

var SCREEN_SIZE
var WIDTH
var HEIGHT

var projectile_cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	SCREEN_SIZE = get_viewport_rect().size
	WIDTH = $CollisionShape2D.get_shape().get_extents().x
	HEIGHT = $CollisionShape2D.get_shape().get_extents().y
	collision_layer = COLLISION_LAYER
	collision_mask = COLLISION_MASK
	
	connect("area_shape_entered", self, "_on_area_shape_entered")

# Helper for moving the player according to input.
func move(delta):
	var velocity = Vector2(0, 0);
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED;
	
	position += velocity * delta;
	position.x = clamp(position.x, WIDTH, SCREEN_SIZE.x - WIDTH)
	position.y = clamp(position.y, HEIGHT, SCREEN_SIZE.y - HEIGHT)

# Helper for handling shoot logic
func shoot(delta):
	if Input.is_action_pressed("ui_accept"):
		if projectile_cooldown < 0:
			emit_signal("fired_projectile", position, PROJECTILE_VELOCITY, 
				COLLISION_MASK, PROJECTILE_SPRITE_INDEX)
			projectile_cooldown = PROJECTILE_COOLDOWN_MAX
		else:
			projectile_cooldown -= delta

func _on_area_shape_entered(_area_id, _area, _area_shape, _self_shape):
	print("ouch!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move(delta)
	shoot(delta)
