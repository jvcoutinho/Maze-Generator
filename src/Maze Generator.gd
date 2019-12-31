extends Node
class_name MazeGenerator

enum MazeGenerationAlgorithm { RECURSIVE_BACKTRACKER, RECURSIVE_DIVISION, ELLER, PRIM, BINARY_TREE }

export(MazeGenerationAlgorithm) var algorithm = MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER
export var random_seed : int = 255
export var number_of_rows : int = 10
export var number_of_columns : int = 10

func generate_maze() -> Maze:
	seed(random_seed)
	return _get_algorithm().generate_maze(number_of_rows, number_of_columns)
	
func _get_algorithm() -> Algorithm:
	match algorithm:
		MazeGenerationAlgorithm.RECURSIVE_BACKTRACKER:
			return RecursiveBacktracker.new()
		MazeGenerationAlgorithm.RECURSIVE_DIVISION:
			return RecursiveDivision.new()
		MazeGenerationAlgorithm.ELLER:
			return Eller.new()
		MazeGenerationAlgorithm.PRIM:
			return Prim.new()
		MazeGenerationAlgorithm.BINARY_TREE:
			return BinaryTree.new()