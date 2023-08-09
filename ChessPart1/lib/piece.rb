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
        p "color: #{color}, symbol: #{symbol}, pos: #{pos}"
    end
    
    def  to_s

    end

    def empty?

    end

    def valid_moves

    end

    def move_into_check?(end_pos)

    end


end 

class NullPiece < Piece
    def initialize(curr_pos, board)
        super(nil, :NullPiece, curr_pos, board)
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
        [[-1,-1], [-1 ,1], [1,1], [1,-1],[-1,0], [0,1], [1,0], [0,1]]
    end
end

class Queen < Piece
    include Slideable
    
    def move_dirs
        [[-1,-1], [-1 ,1], [1,1], [1,-1],[-1,0], [0,1], [1,0], [0,1]]
    end
end

class Bishop < Piece
    include Slideable


    def move_dirs

    end
end

class Rook < Piece
    include Slideable
 

    def move_dirs

    end
end

class Pawn < Piece

    def initialize(color, symbol, curr_pos, board)
        super
        @hasnt_got_yet = true
    end


    def moves

    end

    private
    def at_start_row?

    end

    def foward_dir
        #return -1 or 1
    end

    def foward_steps

    end

    def side_attacks

    end
end

