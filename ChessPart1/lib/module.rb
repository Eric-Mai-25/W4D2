module Slideable
    HORIZONTAL_DIRS = [[-1,0], [0,1], [1,0], [0,1]]
    DIAGONAL_DIRS =[[-1,-1], [-1 ,1], [1,1], [1,-1]]

    def horizontal_dirs(pos)
        possible_dirs = []
        row, col = pos
        HORIZONTAL_DIRS.each{|dir|
            possible_dirs << [row+dir[0], col+dir[1]]
        }
        possible_dirs

    end

    def diagonal_dirs
        possible_dirs = []
        row, col = pos
        DIAGONAL_DIRS.each{|dir|
            possible_dirs << [row+dir[0], col+dir[1]]
        }
        possible_dirs
    end

    def moves
        all_pos_moves = []
        move_dirs.each do |direction| 
            all_pos_moves += grow_unblocked_moves_in_dir(direction[0], direction[1])
        end
        all_pos_moves
    end

    def grow_unblocked_moves_in_dir(dx,dy)
        row, col = pos
        unblocked_moves = []
        growing = true
        while growing
            new_row = row+dx
            new_col = col+dy
            current_piece_at_pos = @board[[new_row, new_col]]
            if new_row < 0 || new_row > 7 || new_col < 0 || new_col > 7
                growing = false
            elsif !current_piece_at_pos.is_a?(NullPiece) || current_piece_at_pos.color == self.color
                growing = false
            else
                unblocked_moves << [new_row, new_col]
                row, col = new_row, new_col
            end
        end
        unblocked_moves
    end
end

module Stepable

    def moves
        row, col = pos
        all_pos_moves = []
        move_diffs.each{|pos_dir|
            new_row = row+pos_dir[0]
            new_col = col+pos_dir[1]

            if new_row < 0 || new_row > 7 || new_col < 0 || new_col > 7
                next
            end

            current_piece_at_pos = @board[[new_row, new_col]]

            if !current_piece_at_pos.is_a?(NullPiece) || current_piece_at_pos.color == self.color
                next
            end
        
            all_pos_moves << [new_row, new_col]
        }
        all_pos_moves
    end



end