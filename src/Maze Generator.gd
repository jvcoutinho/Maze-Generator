extends Node
class_name MazeGenerator

enum MazeGenerationAlgorithm { RECURSIVE_BACKTRACKER, RECURSIVE_DIVISION, ELLER, PRIM }

export(MazeGenerationAlgorithm) var algorithm = MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER
export var random_seed : int = 255
export var number_of_rows : int = 10
export var number_of_columns : int = 10

func generate_maze() -> Maze:
	seed(random_seed)
	
	match algorithm:
		MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER:
			return RecursiveBacktracker.generate_maze(number_of_rows, number_of_columns)
		MazeGenerationAlgorithm.RECURSIVE_DIVISION:
			return RecursiveDivision.generate_maze(number_of_rows, number_of_columns)
		MazeGenerationAlgorithm.ELLER:
			return Eller.generate_maze(number_of_rows, number_of_columns)
		MazeGenerationAlgorithm.PRIM:
			return Prim.generate_maze(number_of_rows, number_of_columns)