class_name Cell
"""
Representation of a maze cell.
"""

var row: bool
var column: bool
var contains_goal: bool
var walls = {}

var is_visited: bool

func _init(row: int, column: int, have_walls: bool):
	self.row = row
	self.column = column
	self.contains_goal = false
	self.walls = { "N": have_walls, "W": have_walls, "S": have_walls, "E": have_walls } 
	self.is_visited = false