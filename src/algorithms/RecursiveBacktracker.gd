extends Algorithm
class_name RecursiveBacktracker

func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns)
		
	var current_cell = Utils.get_random_cell(maze)
	current_cell.is_visited = true
	var stack = [current_cell]
	
	while not stack.empty():
		current_cell = stack.pop_back()
		var unvisited_neighbours = Utils.get_unvisited_neighbours(current_cell, maze)
		if not unvisited_neighbours.empty():
			stack.push_back(current_cell)
			
			var random_neighbour = unvisited_neighbours[randi() % unvisited_neighbours.size()]
			Utils.remove_walls_between(current_cell, random_neighbour)
			random_neighbour.is_visited = true
			stack.push_back(random_neighbour)
		
	return maze