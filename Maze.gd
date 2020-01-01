extends Spatial

const Wall = preload("res://assets/Wall.tscn")
const Floor = preload("res://assets/Floor.tscn")

func _ready():
	_build_maze(3.0, -5.0)
	
func _build_maze(cell_size: float, offset: float) -> void:
	var maze = $MazeGenerator.generate_maze()
	for row in maze.number_rows:
		for column in maze.number_columns:
			var cell = maze.cell_at(row, column)
			
			var left_boundary = column * cell_size + offset 
			var right_boundary = (column + 0.5) * cell_size + offset
			var bottom_boundary = row * cell_size + offset 
			var top_boundary = (row + 0.5) * cell_size + offset
			
			var floor_ = Floor.instance()
			floor_.mesh.size = Vector2(cell_size, cell_size)
			floor_.translation = Vector3(left_boundary, 0, bottom_boundary)
			add_child(floor_)
			
			if cell.walls.E:
				_spawn_wall(right_boundary, bottom_boundary, PI / 2, cell_size)
				
			if cell.walls.W:
				_spawn_wall(left_boundary - cell_size * 0.5, bottom_boundary, PI / 2, cell_size)
				
			if cell.walls.N:
				_spawn_wall(left_boundary, top_boundary, 0, cell_size)
				
			if cell.walls.S:
				_spawn_wall(left_boundary,  bottom_boundary - cell_size * 0.5, 0, cell_size)
				
func _spawn_wall(x: float, z: float, rotate_y: float, cell_size: float):
	var wall = Wall.instance()
	wall.translation = Vector3(x, 0, z)
	wall.rotate_y(rotate_y)
	wall.width = cell_size
	add_child(wall)