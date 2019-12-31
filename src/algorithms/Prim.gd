extends Algorithm
class_name Prim

func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns)
		
	var random_cell = Utils.get_random_cell(maze)
	random_cell.is_visited = true
	var frontier = _get_edges(random_cell, maze)
	
	while not frontier.empty():
		var random_position = randi() % frontier.size()
		
		var edge = frontier[random_position]
		if _only_one_is_visited(edge.cell1, edge.cell2):
			Utils.remove_walls_between(edge.cell1, edge.cell2)
			
			if not edge.cell1.is_visited:
				_mark_and_add_edges(edge.cell1, maze, frontier)
			else:
				_mark_and_add_edges(edge.cell2, maze, frontier)
		frontier.remove(random_position)
	return maze
	
class Edge: # wall
	var cell1: Cell
	var cell2: Cell
	
	func _init(cell1: Cell, cell2: Cell):
		self.cell1 = cell1
		self.cell2 = cell2

func _get_edges(cell: Cell, maze: Maze) -> Array:
	var edges = []
	for neighbour in Utils.get_unvisited_neighbours(cell, maze):
		edges.append(Edge.new(cell, neighbour))
	return edges
	
func _mark_and_add_edges(cell: Cell, maze: Maze, frontier: Array) -> void:
	cell.is_visited = true
	for edge in _get_edges(cell, maze):
		frontier.append(edge) 

func _only_one_is_visited(cell1: Cell, cell2: Cell) -> bool:
	return (cell1.is_visited or cell2.is_visited) and not (cell1.is_visited && cell2.is_visited)