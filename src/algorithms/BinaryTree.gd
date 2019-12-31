extends Algorithm
class_name BinaryTree

func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns)
		
	for row in number_rows:
		for cell in maze.get_row(row):
			_carve_passage(cell, maze)
	return maze
	
func _carve_passage(cell: Cell, maze: Maze):
	if cell.column != maze.number_columns - 1 || cell.row != maze.number_rows - 1:
		if cell.column == maze.number_columns - 1:
			Utils.remove_walls_between(cell, maze.cell_at(cell.row + 1, cell.column))
		elif cell.row == maze.number_rows - 1:
			Utils.remove_walls_between(cell, maze.cell_at(cell.row, cell.column + 1))
		else:
			if randi() % 2 == 0:
				Utils.remove_walls_between(cell, maze.cell_at(cell.row + 1, cell.column))
			else:
				Utils.remove_walls_between(cell, maze.cell_at(cell.row, cell.column + 1))
		