#extends Node
#
#const UNIT_SCRIPT = preload("res://scripts/Unit.gd")
#const UNIT_DATA_PATH = "res://data/units.json"
#
#@onready var units_container = get_node("../Units")
#@onready var player_controller = get_node("../PlayerController")
#@onready var ai_controller = get_node("../AIController")
#
#var unit_definitions: Array = []
#var player_units: Array = []
#var enemy_units: Array = []
#var current_turn: int = 0 
#
#func _ready():
	#load_data()
	## Počkáme chvilku, než se nastartuje TileMap
	#await get_tree().create_timer(0.1).timeout
	#spawn_initial_units()
	#start_new_turn()
#
#func load_data():
	#if not FileAccess.file_exists(UNIT_DATA_PATH):
		#print("CHYBA: Soubor units.json neexistuje! Vytvořte ho ve složce /data.")
		#return
		#
	#var file = FileAccess.open(UNIT_DATA_PATH, FileAccess.READ)
	#var json_text = file.get_as_text()
	#unit_definitions = JSON.parse_string(json_text)
#
#func spawn_initial_units():
	#if unit_definitions == null or unit_definitions.is_empty():
		#print("CHYBA: Žádná data v units.json")
		#return
#
	## Spawn Hráče (Tým 0) - na pozici hexu 2,2
	#spawn_unit(unit_definitions[0], 0, Vector2i(2, 2))
	#
	## Spawn AI (Tým 1) - na pozici hexu 5,2 (pokud existuje druhý typ jednotky, jinak první)
	#var ai_unit_data = unit_definitions[1] if unit_definitions.size() > 1 else unit_definitions[0]
	#spawn_unit(ai_unit_data, 1, Vector2i(5, 2))
#
#func spawn_unit(data: Dictionary, team_id: int, pos: Vector2i):
	#var unit = UNIT_SCRIPT.new() # Vytvoříme novou instanci skriptu Unit
	#units_container.add_child(unit)
	#unit.init(data, team_id, pos)
	#
	## Propojení signálu, když jednotka zemře
	#unit.died.connect(_on_unit_died)
	#
	#if team_id == 0:
		#player_units.append(unit)
	#else:
		#enemy_units.append(unit)
#
#func start_new_turn():
	#current_turn += 1
	## Liché tahy = Hráč, Sudé = AI
	#if current_turn % 2 != 0:
		#print("\n--- TAH HRÁČE (", current_turn, ") ---")
		#player_controller.start_turn(player_units)
	#else:
		#print("\n--- TAH AI (", current_turn, ") ---")
		#ai_controller.take_turn(enemy_units, player_units)
#
#func end_player_turn():
	#player_controller.reset_state()
	#start_new_turn()
#
#func _on_unit_died(unit):
	#if unit.team == 0:
		#player_units.erase(unit)
	#else:
		#enemy_units.erase(unit)
	#check_game_over()
#
#func check_game_over():
	#if player_units.is_empty():
		#print("!!! PROHRA !!! AI vyhrálo.")
	#elif enemy_units.is_empty():
		#print("!!! VÍTĚZSTVÍ !!! Hráč vyhrál.")
#
## Propojit v editoru s tlačítkem EndTurnButton
#func _on_end_turn_button_pressed():
	#if current_turn % 2 != 0: # Jen pokud je tah hráče
		#print("Tah ukončen tlačítkem.")
		#end_player_turn()
