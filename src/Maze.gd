extends Node
class_name Maze
"""
Representation of a maze.
"""

var number_rows: int
var number_columns: int
var grid: Array 

func _init(number_rows: int, number_columns: int, grid: Array):
	self.number_rows = number_rows
	self.number_columns = number_columns
	self.grid = _initialize_cells(number_rows, number_columns)

func _initialize_cells(number_rows: int, number_columns: int):
	grid = []
	for row in number_rows:
		grid.append([])
		grid[row].resize(number_columns)
		
		for column in number_columns:
			grid[row][column] = Cell.new(row, column)

func cell_at(row: int, column: int):
	return grid[row][column]