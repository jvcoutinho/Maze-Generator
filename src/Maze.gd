class_name Maze
"""
Representation of a maze.
"""

var number_rows: int
var number_columns: int
var grid: Array 

func _init(number_rows: int, number_columns: int, all_connected: bool = true):
	self.number_rows = number_rows
	self.number_columns = number_columns
	self.grid = _initialize_cells(all_connected)

func _initialize_cells(all_connected: bool):
	var cells = []
	for row in number_rows:
		cells.append([])
		cells[row].resize(number_columns)
		
		for column in number_columns:
			cells[row][column] = Cell.new(row, column, all_connected)

	return cells

func cell_at(row: int, column: int) -> Cell:
	return grid[row][column]
	
func get_row(row: int) -> Array:
	return grid[row]
	
func get_column(column: int) -> Array:
	var cells = []
	for row in number_rows:
		cells.append(cell_at(row, column))
	return cells
	
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