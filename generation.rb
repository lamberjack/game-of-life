
#receives current grid matrix composed by '*' and '.' and return an equal matrix 
#composed by 1 ('*') and 0 ('.')
def convertToIntGrid(grid)
    return grid.map{|row| row.map{ |val| 
        if val == '*'
            val = 1
        elsif val == '.'
            val = 0
        else
            raise "Grid cell value must be '*' or '.'"
        end    
        }
    }
end

#receives current grid matrix composed by 1 and 0 and return an equal matrix 
#composed by '*' (1) and '.' (0)
def converToStringGrid(grid)
    return grid.map{|row| row.map{ |val| 
        if val == 1
            val = '*'
        elsif val == 0
            val = '.'
        else
            raise "Grid cell value must be 1 or 0"
        end    
        }
    }
end

#receives a chars matrix with related m rows and n columns and return next 
#return a related chars matrix after the generation process
def nextGeneration(grid, m, n)
    curr_grid = convertToIntGrid(grid)

    #uses a support grid that contain the next generation state
    next_grid = []

    #deep copy of each row
    curr_grid.each{|row| next_grid.push(row.clone)}

    for r in (0...m)
        for c in (0...n)
            alive_neighbours = countAliveNeighbours(curr_grid,r,c)

            # 1) lived cell with less than 2 neighbours, dies (alone)
            if((curr_grid[r][c] == 1) && (alive_neighbours < 2))
                next_grid[r][c] = 0
                
                # 2) lived cell with more than 3 neighbours, dies (over population)
            elsif((curr_grid[r][c] == 1) && (alive_neighbours > 3))
                next_grid[r][c] = 0
                
                # 3) died cell with exactly 3 neighbours, borns
            elsif((curr_grid[r][c] == 0) && (alive_neighbours == 3))
                next_grid[r][c] = 1
                
                # 4) in the other cases the value of the cell doesn't change
            else
                next_grid[r][c] = curr_grid[r][c]
            end
        end
    end
    return converToStringGrid(next_grid)
end

#return the alive neighbours count for the cell with the input position (row,col)
def countAliveNeighbours(grid, row, col)
    alive_neighbours = 0

    #initialize the index to border the scan area of the current cell 
    s_idx_row = row == 0 ? 0 : -1
    e_idx_row = row == (grid.length() -1) ? 0 : 1
    s_idx_col = col == 0 ? 0 : -1
    e_idx_col = col == (grid[0].length() -1) ? 0 : 1

    #scan all the neighbour cells and count them  
    for i in (s_idx_row...e_idx_row+1)
        for j in (s_idx_col...e_idx_col+1)
            alive_neighbours += grid[row + i][col + j]
        end
    end

    #cell itself is subtracted from the neighbours count
    alive_neighbours -= grid[row][col]

    return alive_neighbours
end

