
require_relative "piece"

class Board

    

    def initialize()
        @rows = Array.new(8) {Array.new(8)}
        populate_board
    end

    def populate_pieces(sub_row, idx, color)
        (0...sub_row.length).each{|jdx|
            case 
            when [0,7].include?(jdx)
                @rows[idx][jdx] = Rook.new(color, :Rook, [idx, jdx], self)
            when [1,6].include?(jdx)
                @rows[idx][jdx] = Knight.new(color, :Knight, [idx, jdx], self)
            when [2,5].include?(jdx)
                @rows[idx][jdx] = Bishop.new(color, :Bishop, [idx, jdx], self)
            when jdx == 3
                @rows[idx][jdx] = King.new(color, :King, [idx, jdx], self)
            else
                @rows[idx][jdx] = Queen.new(color, :Queen, [idx, jdx], self)
            end  
        }
    end

    def populate_board
        @rows.each_with_index{|sub_row, idx|
            if idx == 0
                populate_pieces(sub_row, idx, "Black")
            elsif idx == 1
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = Pawn.new("Black", :Pawn, [idx, jdx], self)}
            elsif idx == 6
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = Pawn.new("White", :Pawn, [idx, jdx], self)}
            elsif idx == 7
                populate_pieces(sub_row, idx, "White")
            else
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = NullPiece.new([idx, jdx], self)}
            end
        }
    end

    def render()
        @rows.each{|sub_row|
            sub_row.map{|ele| p "#{ele.symbol} #{ele.color}" }
        }
        
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, value)
        row, col = pos
        @rows[row][col] = value
    end

    def move_piece(start_pos, end_pos)
        if self[start_pos].class == NullPiece
            raise "No piece at the given pos #{start_pos}"
        elsif self[end_pos].nil?
            raise "Invalid end pos #{end_pos}"
        end

        piece_instance = self[start_pos]
        p piece_instance.moves
        
        if !piece_instance.moves.include?(end_pos)
            raise "Cant move to end pos #{end_pos}"
        end

        piece_instance.pos = end_pos
        self[end_pos], self[start_pos] = piece_instance , NullPiece.new(start_pos, self)
    end

end

# p1 = Player.new("Black")
# p2 =Player.new("White")

b = Board.new()
p b[[0,4]]
p b[[0,3]]
b.move_piece([0,4],[0,3])
p b[[0,4]]
p b[[0,3]]



