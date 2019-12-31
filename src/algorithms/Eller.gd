extends Algorithm
class_name Eller

var state

func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns)
	
	state = State.new()
	
	state.instantiate_set_for_each_cell(maze.get_row(0))
	for row in number_rows - 1:
		_join_adjacent_cells(maze.get_row(row), true)
		_randomly_connect_cells(maze.get_row(row), maze.get_row(row + 1))
		state.instantiate_set_for_each_cell(maze.get_row(row + 1))

	_join_adjacent_cells(maze.get_row(number_rows - 1), false)
	
	return maze

class State:
	var sets: Dictionary # maps a set identifier to the set
	var cells: Dictionary # maps a cell to the set identifier
	var set_identifier: int
	
	func _init():
		sets = {}
		cells = {}
		set_identifier = 0
		
	func instantiate_set_for_each_cell(row: Array) -> void:
		for cell in row:
			if not cells.has(cell):
				add(cell, set_identifier)
				set_identifier += 1
	
	func same_set(cell1: Cell, cell2: Cell) -> bool:
		return cells[cell1] == cells[cell2]
		
	func next() -> State:
		var state = State.new()
		state.set_identifier = set_identifier
		return state
		
	func merge(cell1: Cell, cell2: Cell) -> void:
		var set1 = cells[cell1]
		var set2 = cells[cell2]
		
		for cell in sets[set2].elements():
			add(cell, set1)
		assert sets.erase(set2)
	
	func add(cell: Cell, set: int) -> void:
		cells[cell] = set
		if not sets.has(set):
			sets[set] = Set.new()
		sets[set].add(cell)
	
	func get_sets() -> Array:
		return sets.keys()

class Set:
	var set: Dictionary
	
	func _init():
		self.set = {}
	
	func add(element):
		set[element] = 1
		
	func elements() -> Array:
		return set.keys()

func _join_adjacent_cells(row: Array, randomly: bool):
	for i in row.size() - 1:
		var cell = row[i]
		var adjacent = row[i + 1]
		
		if not state.same_set(cell, adjacent):
			if not randomly or randi() % 2 == 0:
				_join_horizontally(cell, adjacent)
				
func _randomly_connect_cells(row: Array, next_row: Array):
	var next_state = state.next()
	for set in state.get_sets():
		var cells = _get_random_cells(state.sets[set])
		for cell in cells:
			var index = row.find(cell)
			_join_vertically(row[index], next_row[index], set, next_state)
	state = next_state
	
func _get_random_cells(set: Set) -> Array:
	var cells: Array = set.elements()
	cells.shuffle()
	cells.resize(1 + randi() % cells.size())
	return cells

func _join_horizontally(cell: Cell, adjacent: Cell):
	cell.walls.E = false
	adjacent.walls.W = false
	state.merge(cell, adjacent)
	
func _join_vertically(cell: Cell, adjacent: Cell, set: int, state: State):
	cell.walls.N = false
	adjacent.walls.S = false
	state.add(adjacent, set)