extends Node
class_name MazeGenerator

const Maze = preload("res://src/Maze.gd")
enum MazeGenerationAlgorithm { RECURSIVE_BACKTRACKER, RECURSIVE_DIVISION, ELLER }

export(MazeGenerationAlgorithm) var algorithm = MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER
export var random_seed : int = 255
export var number_rows : int = 5
export var number_columns : int = 5

func generate_maze() -> Maze:
	seed(random_seed)
	
	match algorithm:
		MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER:
			return RecursiveBacktracker.generate_maze(number_rows, number_columns)
		MazeGenerationAlgorithm.RECURSIVE_DIVISION:
			return RecursiveDivision.generate_maze(number_rows, number_columns)
		MazeGenerationAlgorithm.ELLER:
			return EllerAlgorithm.generate_maze(number_rows, number_columns)