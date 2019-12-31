extends Algorithm
class_name RecursiveDivision

enum Orientation { HORIZONTAL, VERTICAL, NONE }

func generate_maze(number_rows: int, number_columns: int) -> Maze:
	var maze = Maze.new(number_rows, number_columns, false)
	
	_put_walls_at_boundaries(maze)
	
	var current_field = { "bottom": 0, "left": 0, "right": maze.number_columns, "top": maze.number_rows }
	var stack = [current_field]
	
	while not stack.empty():
		current_field = stack.pop_back()
		
		var orientation = _choose_orientation(current_field)
		if orientation != Orientation.NONE:
			var subfields = _bisect_horizontally(current_field, maze) \
					if orientation == Orientation.HORIZONTAL \
					else _bisect_vertically(current_field, maze)
			stack.push_back(subfields[0])
			stack.push_back(subfields[1]) 
	
	return maze
	
func _put_walls_at_boundaries(maze: Maze) -> void:
	for row in maze.number_rows:
		maze.cell_at(row, 0).walls.W = true
		maze.cell_at(row, maze.number_columns - 1).walls.E = true
	
	for column in maze.number_columns:
		maze.cell_at(0, column).walls.S = true
		maze.cell_at(maze.number_rows - 1, column).walls.N = true
		
func _choose_orientation(field: Dictionary):
	var width = field.right - field.left
	var height = field.top - field.bottom
	
	if width > 1 && height > 1:
		if width < height: # prefer horizontal
			return Orientation.HORIZONTAL
		elif width > height: # prefer vertical
			return Orientation.VERTICAL
		else: # choose randomly
			return Orientation.HORIZONTAL if randi() % 2 == 0 else Orientation.VERTICAL
	else: # end interaction with field
		return Orientation.NONE
		
func _bisect_vertically(field: Dictionary, maze: Maze) -> Array:
	var column_to_bisect = _get_random_value_at_range(field.left, field.right - 1)
	for row in range(field.bottom, field.top):
		maze.cell_at(row, column_to_bisect).walls.E = true
		maze.cell_at(row, column_to_bisect + 1).walls.W = true
		
	var passage_row = _get_random_value_at_range(field.bottom, field.top)
	maze.cell_at(passage_row, column_to_bisect).walls.E = false
	maze.cell_at(passage_row, column_to_bisect + 1).walls.W = false
	
	var left_subfield = { "bottom": field.bottom, "left": field.left, "right": column_to_bisect + 1, "top": field.top }
	var right_subfield = { "bottom": field.bottom, "left": column_to_bisect + 1, "right": field.right, "top": field.top }
	return [left_subfield, right_subfield]
	
func _bisect_horizontally(field: Dictionary, maze: Maze) -> Array:
	var row_to_bisect = _get_random_value_at_range(field.bottom, field.top - 1)
	for column in range(field.left, field.right):
		maze.cell_at(row_to_bisect + 1, column).walls.S = true
		maze.cell_at(row_to_bisect, column).walls.N = true
		
	var passage_column = _get_random_value_at_range(field.left, field.right)
	maze.cell_at(row_to_bisect, passage_column).walls.N = false
	maze.cell_at(row_to_bisect + 1, passage_column).walls.S = false
		
	var top_subfield = { "bottom": row_to_bisect + 1, "left": field.left, "right": field.right, "top": field.top }
	var bottom_subfield = { "bottom": field.bottom, "left": field.left, "right": field.right, "top": row_to_bisect + 1 }
	return [top_subfield, bottom_subfield]
	
func _get_random_value_at_range(start: int, end: int):
	return start + randi() % (end - start)