class_name RecursiveBacktracker

static func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns, true)
		
	var current_cell = _get_random_cell(maze)
	current_cell.is_visited = true
	var stack = [current_cell]
	
	while not stack.empty():
		current_cell = stack.pop_back()
		var unvisited_neighbours = _get_unvisited(maze.get_neighbours(current_cell))
		if not unvisited_neighbours.empty():
			stack.push_back(current_cell)
			
			var random_neighbour = unvisited_neighbours[randi() % unvisited_neighbours.size()]
			_remove_walls_between(current_cell, random_neighbour)
			random_neighbour.is_visited = true
			stack.push_back(random_neighbour)
		
	return maze
	
static func _get_random_cell(maze: Maze) -> Cell:
	var random_row = randi() % maze.number_rows
	var random_column = randi() % maze.number_columns
	return maze.cell_at(random_row, random_column)
	
static func _get_unvisited(neighbours: Array) -> Array:
	var unvisited = []
	for cell in neighbours:
		if not cell.is_visited:
			unvisited.append(cell)
	return unvisited
	
static func _remove_walls_between(cell1: Cell, cell2: Cell) -> void:
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