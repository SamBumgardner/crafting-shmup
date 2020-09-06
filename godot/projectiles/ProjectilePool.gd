extends Reference

class_name ProjectilePool

var parent_node
var projectiles

func init(parent):
	parent_node = parent
	projectiles = preload("res://projectiles/Projectile.tscn")

func _on_fired_projectile(position, velocity, collision_mask, sprite_frame):
	var projectile = projectiles.instance()
	projectile.init(position, velocity, collision_mask, sprite_frame)
	parent_node.add_child(projectile)
