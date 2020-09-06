extends Reference

class_name EnemyPool

var random = RandomNumberGenerator.new()
var parent_node
var enemies

func init(parent):
	random.randomize()
	parent_node = parent
	enemies = preload("res://characters/enemy/Enemy.tscn")

func _on_spawn_enemy():
	var enemy = enemies.instance()
	# clean up tight coupling between projectile pool and enemy pool below.
	enemy.connect("fired_projectile", parent_node.projectile_pool, 
		"_on_fired_projectile")
	var init_position = Vector2(random.randf_range(100, 500), 150)
	enemy.init(init_position)
	parent_node.add_child(enemy)
