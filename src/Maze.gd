class_name Maze
"""
Representation of a maze.
"""

var number_rows: int
var number_columns: int
var grid: Array 

func _init(number_rows: int, number_columns: int, all_connected: bool):
	self.number_rows = number_rows
	self.number_columns = number_columns
	self.grid = _initialize_cells(number_rows, number_columns, all_connected)

func _initialize_cells(number_rows: int, number_columns: int, all_connected: bool):
	var cells = []
	for row in number_rows:
		cells.append([])
		cells[row].resize(number_columns)
		
		for column in number_columns:
			cells[row][column] = Cell.new(row, column, _is_boundary(row, column) || all_connected)
	return cells
	
func _is_boundary(row: int, column: int) -> bool:
	return row == 0 || row == number_rows - 1 || column == 0 || column == number_columns - 1

func cell_at(row: int, column: int) -> Cell:
	return grid[row][column]
	
func get_neighbours(cell: Cell) -> Array:
	var neighbours = []
	if cell.column > 0: # Get western neighbour
		neighbours.append(cell_at(cell.row, cell.column - 1))
	if cell.column < number_columns - 1: # Get eastern neighbour
		neighbours.append(cell_at(cell.row, cell.column + 1))
	if cell.row > 0: # Get northern neighbour
		neighbours.append(cell_at(cell.row - 1, cell.column))
	if cell.row < number_rows - 1: # Get southern neighbour
		neighbours.append(cell_at(cell.row + 1, cell.column))
	return neighbours