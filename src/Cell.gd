extends Node
class_name Cell
"""
Representation of a maze cell.
"""

var row: bool
var column: bool
var contains_goal: bool
var walls = {}

func _init(row: int, column: int):
	self.row = row
	self.column = column
	self.contains_goal = false
	self.walls = { "N": false, "W": false, "S": false, "E": false } 