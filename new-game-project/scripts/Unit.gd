## /scripts/Unit.gd (FINÁLNÍ VERZE S PLACEHOLDEREM A KOLIZÍ)
#extends CharacterBody2D 
#
#signal died(unit)
#
#var unit_data: Dictionary = {}
#var team: int = 0 
#var current_tile_pos: Vector2i 
#
#func init(data: Dictionary, unit_team: int, initial_tile_pos: Vector2i):
	#unit_data = data.duplicate()
	#team = unit_team
	#name = unit_data.id
	#
	#
	## --- VIZUÁL: Polygon2D (HEXAGON PLACEHOLDER) ---
	## Vytvoříme Polygon2D pro kreslení geometrie (HEXAGON)
	#var poly = Polygon2D.new()
	#var size = 25.0
	#var points: PackedVector2Array = [
		#Vector2(size, 0),
		#Vector2(size / 2.0, -size * 0.866),
		#Vector2(-size / 2.0, -size * 0.866),
		#Vector2(-size, 0),
		#Vector2(-size / 2.0, size * 0.866),
		#Vector2(size / 2.0, size * 0.866),
	#]
	#poly.polygon = points
	## Barva podle týmu
	#poly.color = Color.DODGER_BLUE if team == 0 else Color.ORANGE_RED
	#add_child(poly)
	#
	#
	## --- INTERAKCE: CollisionShape2D (PRO KLIKÁNÍ) ---
	#var collision_shape = CollisionShape2D.new()
	#var shape = CircleShape2D.new() 
	#shape.radius = 30.0 
	#collision_shape.shape = shape
	#add_child(collision_shape)
	#
	#
	#set_world_position(initial_tile_pos)
	#
## Přesun na pixelovou pozici podle mřížky
#func set_world_position(tile_pos: Vector2i):
	#current_tile_pos = tile_pos
	#
	## Bezpečné hledání TileMapy
	#var tilemap = get_viewport().get_node_or_null("CombatScene/TileMap")
	#if tilemap == null:
		## Záložní možnost (relativní cesta)
		#tilemap = get_parent().get_parent().get_node_or_null("TileMap")
	#
	#if tilemap:
		#self.position = tilemap.map_to_local(tile_pos)
	#else:
		#print("CHYBA: Unit nemůže najít TileMap! Zkontrolujte jména uzlů.")
#
#func get_tile_position() -> Vector2i:
	#return current_tile_pos
#
#func take_damage(damage: int):
	## Doplňte zbytek logiky z předchozí verze (HP, smrt, blikání)
	#pass # PLACEHOLDER
	## Tuto funkci byste měl/a vyplnit z předchozí verze, teď jen pro spuštění stačí 'pass'
