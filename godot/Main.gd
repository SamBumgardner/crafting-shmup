extends Node

var projectile_pool
var enemy_pool

func _ready():
	enemy_pool = preload("res://characters/enemy/EnemyPool.gd").new()
	enemy_pool.init(self)
	projectile_pool = preload("res://projectiles/ProjectilePool.gd").new()
	projectile_pool.init(self)
	
	$Player.connect("fired_projectile", projectile_pool, "_on_fired_projectile")
	$EnemySpawnTimer.connect("timeout", enemy_pool, "_on_spawn_enemy")
