class_name Utils

static func get_random_cell(maze: Maze) -> Cell:
	var random_row = randi() % maze.number_rows
	var random_column = randi() % maze.number_columns
	return maze.cell_at(random_row, random_column)
	
static func get_unvisited_neighbours(cell: Cell, maze: Maze) -> Array:
	return _filter_unvisited(maze.get_neighbours(cell))
	
static func _filter_unvisited(cells: Array) -> Array:
	var unvisited = []
	for cell in cells:
		if not cell.is_visited:
			unvisited.append(cell)
	return unvisited
	
static func remove_walls_between(cell1: Cell, cell2: Cell) -> void:
	if cell1.row == cell2.row - 1: # cell1 is southern
		cell1.walls.N = false
		cell2.walls.S = false
	elif cell1.row == cell2.row + 1: # cell1 is northern
		cell1.walls.S = false
		cell2.walls.N = false
	elif cell1.column == cell2.column - 1: # cell1 is western
		cell1.walls.E = false
		cell2.walls.W = false
	else: # cell1 is eastern
		cell1.walls.W = false
		cell2.walls.E = false