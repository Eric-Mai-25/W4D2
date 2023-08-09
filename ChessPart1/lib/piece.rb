require_relative 'module.rb'
require 'singleton'

class Piece

    attr_reader :symbol , :color
    attr_accessor :pos

    def initialize(color, symbol, curr_pos, board)
        @board = board
        @color = color
        @symbol = symbol
        @pos = curr_pos
    end

    def inspect
        "color: #{color}, symbol: #{symbol}, pos: #{pos}"
    end
    
    def  to_s

    end

    def empty?
        self.is_a?(NullPiece)
    end

    def boundary?(row, col)
        row < 0 || row > 7 || col < 0 || col > 7
    end

    def valid_moves

    end

    def move_into_check?(end_pos)
        row, col = end_pos

        return false if boundary?(row, col)

        current_piece_at_pos = @board[end_pos]

        return true if current_piece_at_pos.empty?

        return true if current_piece_at_pos.color != self.color
        
        return false

    end

end 

class NullPiece < Piece

    include Singleton

    def initialize
        # if we dont have initialize then its gonna complain abt not passing enough args, which in our case we dont want to do
        @symbol = :Null
        @color = :grey
    end

end


class Knight < Piece 

    include Stepable

    def move_diffs
        [[-2,1], [-2, -1], [2,1], [2,-1], [-1,2], [-1, -2], [1,2], [1, -2]]
    end
   
end

class King < Piece 
    include Stepable

    def move_diffs
        [[-1,-1], [-1,1], [1,1], [1,-1], [-1,0], [0,1], [1,0], [0,1]]
    end

end

class Queen < Piece
    include Slideable
    
    def move_dirs
        [[-1,-1], [-1,1], [1,1], [1,-1], [-1,0], [0,1], [1,0], [0,1]]
    end

end

class Bishop < Piece

    include Slideable

    def move_dirs
        [[-1,-1], [-1,1], [1,1], [1,-1]]
    end

end

class Rook < Piece

    include Slideable

    def move_dirs
        [[-1,0], [0,1], [1,0], [0,1]]
    end
end

class Pawn < Piece

    def initialize(color, symbol, curr_pos, board)
        super
        @start_pos = curr_pos
    end


    def moves
        all_pos_moves = []
        if at_start_row?
            foward_steps(2).each do |step|
                if !boundary?(step[0], step[1]) && @board[step].empty? 
                    all_pos_moves << step 
                else
                    break
                end
            end
        else
            foward_steps.each do |step|
                all_pos_moves << step if !boundary?(step[0], step[1]) && @board[step].empty?
            end
        end
        p side_attacks
        side_attacks.each do |step|

            if  !boundary?(step[0], step[1]) && @board[step].color != self.color
                all_pos_moves << step
            end
        end
        all_pos_moves
    end

    private
    def at_start_row?
        @start_pos == pos
    end

    def foward_dir
        return -1 if color == 'white'
        return 1 if color == ':yellow'
    end

    def foward_steps(steps=1)
        direc = foward_dir
        res = []
        row , col = pos
        steps.times{ |_| 
            new_row = row+direc
            new_col = col
            res << [new_row, new_col]
            row, col = new_row , new_col
        }
        p res
        return res
    end



    def side_attacks
        return [[pos[0]-1,pos[1]-1],[pos[0]-1,pos[1]+1]] if color == :white
        return [[pos[0]+1,pos[1]-1],[pos[0]+1,pos[1]+1]] if color == :yellow
    end
end

