module Slideable

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
            if !move_into_check?([new_row, new_col])
                growing = false
            else
                unblocked_moves << [new_row, new_col]
                row, col = new_row, new_col
                # to stop growing if you hit the opposite color piece
                if @board[[row, col]].color != :grey && @board[[row, col]].color != self.color
                    growing = false
                end
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

            if !move_into_check?([new_row, new_col])
                next
            end

            all_pos_moves << [new_row, new_col]
        }
        all_pos_moves
    end



end