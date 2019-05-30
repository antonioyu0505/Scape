extends Node2D

enum cell_types { player, obstacle, object, note, stair }
export(cell_types) var type = player