#extends Node
#
#@onready var tilemap: TileMap = get_node("../TileMap")
#@onready var highlight_layer: TileMap = get_node("../HighlightLayer")
#@onready var turn_manager = get_node("../TurnManager")
#@onready var units_container = get_node("../Units")
#
## Atlas souřadnice pro zvýraznění (změňte podle vašeho tilesetu, 0,0 je většinou první dlaždice)
#const HIGHLIGHT_SOURCE_ID = 0 
#const HIGHLIGHT_COORD = Vector2i(0, 0) 
#
#var selected_unit: Node = null
#var available_moves: Array[Vector2i] = []
#var is_my_turn: bool = false
#var has_moved: bool = false
#
#func start_turn(_units):
	#is_my_turn = true
	#has_moved = false
	#reset_state()
#
#func reset_state():
	#selected_unit = null
	#available_moves.clear()
	#highlight_layer.clear()
#
#func _unhandled_input(event):
	#if not is_my_turn: return
	#
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#var local_pos = tilemap.to_local(tilemap.get_global_mouse_position())
		#var clicked_cell = tilemap.local_to_map(local_pos)
		#
		## Debug výpis, abyste viděl, kam klikáte
		## print("Klik na hex: ", clicked_cell)
		#
		#handle_click(clicked_cell)
#
#func handle_click(cell: Vector2i):
	#var unit_on_cell = get_unit_at(cell)
	#
	## 1. Výběr vlastní jednotky (pokud jsme se ještě nepohnuli)
	#if unit_on_cell and unit_on_cell.team == 0 and not has_moved:
		#select_unit(unit_on_cell)
		#return
	#
	## 2. Pohyb (klik na prázdné zvýrazněné pole)
	#if selected_unit and available_moves.has(cell) and unit_on_cell == null:
		#move_selected_unit(cell)
		#return
		#
	## 3. Útok (klik na nepřítele)
	#if selected_unit and unit_on_cell and unit_on_cell.team == 1:
		#try_attack(unit_on_cell)
#
#func select_unit(unit):
	#selected_unit = unit
	#highlight_layer.clear()
	#available_moves = get_hex_moves(unit)
	#
	## Vykreslení zvýraznění
	#for cell in available_moves:
		#highlight_layer.set_cell(0, cell, HIGHLIGHT_SOURCE_ID, HIGHLIGHT_COORD)
	#
	#print("Vybrána jednotka: ", unit.name)
#
#func move_selected_unit(target_cell: Vector2i):
	#selected_unit.set_world_position(target_cell)
	#highlight_layer.clear()
	#available_moves.clear()
	#has_moved = true
	#selected_unit = null
	#print("Jednotka se pohnula.")
#
#func try_attack(target):
	## Zjistíme, jestli je cíl soused (dosah 1)
	#var my_pos = selected_unit.get_tile_position()
	#var target_pos = target.get_tile_position()
	#
	#var is_neighbor = false
	#for i in range(6):
		#if tilemap.get_neighbor_cell(my_pos, i) == target_pos:
			#is_neighbor = true
			#break
			#
	#if is_neighbor:
		#print("Útok na ", target.name)
		#var dmg = selected_unit.unit_data.attack
		#target.take_damage(dmg)
		#turn_manager.end_player_turn() # Útok ukončí tah
	#else:
		#print("Cíl je moc daleko!")
#
## --- POMOCNÉ FUNKCE ---
#func get_unit_at(cell: Vector2i):
	#for unit in units_container.get_children():
		#if unit.get_tile_position() == cell:
			#return unit
	#return null
#
#func get_hex_moves(unit) -> Array[Vector2i]:
	#var start = unit.get_tile_position()
	#var move_range = unit.unit_data.movement
	#var visited = {start: 0}
	#var queue = [start]
	#var results: Array[Vector2i] = []
	#
	#while not queue.is_empty():
		#var current = queue.pop_front()
		#if visited[current] >= move_range: continue
		#
		## Godot funkce pro sousedy na hexu (0 až 5)
		#for i in range(6):
			#var neighbor = tilemap.get_neighbor_cell(current, i)
			#
			## Kontrola, jestli hex existuje (má data v TileMapě)
			#if tilemap.get_cell_source_id(0, neighbor) == -1: continue
			## Kontrola, jestli je tam jiná jednotka
			#if get_unit_at(neighbor) != null: continue
			#
			#if not visited.has(neighbor):
				#visited[neighbor] = visited[current] + 1
				#queue.append(neighbor)
				#results.append(neighbor)
	#return results
