package generators;

import data.GridData;
import entities.grid.Grid;

class GridGenerator
{
	public function new() {}

	public function toGrid(grid_data:GridData):Grid
	{
		var grid = new Grid();

		grid.data = grid_data.data;
		grid.cell_height = grid_data.cell_height;
		grid.cell_width = grid_data.cell_width;
		grid.cell_width_spacing = grid_data.cell_width_spacing;
		grid.cell_height_spacing = grid_data.cell_height_spacing;

		return grid;
	}
}
