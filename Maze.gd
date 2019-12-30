extends Node2D

func _draw():
	var cell_size = 50
	
	var maze = $MazeGenerator.generate_maze()
	for row in maze.number_rows:
		for column in maze.number_columns:
			var cell = maze.cell_at(row, column)
			
			var offset = 40
			var left_boundary = column * cell_size + offset 
			var right_boundary = (column + 1) * cell_size + offset
			var bottom_boundary = row * cell_size + offset 
			var top_boundary = (row + 1) * cell_size + offset
			
			draw_rect(Rect2(left_boundary, bottom_boundary, cell_size, cell_size), Color.white)
			if cell.walls.E:
				draw_line(Vector2(right_boundary, bottom_boundary), Vector2(right_boundary, top_boundary), Color.black, 2.0)
			if cell.walls.N:
				draw_line(Vector2(right_boundary, top_boundary), Vector2(left_boundary, top_boundary), Color.black, 2.0)
			if cell.walls.W:
				draw_line(Vector2(left_boundary, bottom_boundary), Vector2(left_boundary, top_boundary), Color.black, 2.0)
			if cell.walls.S:
				draw_line(Vector2(right_boundary, bottom_boundary), Vector2(left_boundary, bottom_boundary), Color.black, 2.0)