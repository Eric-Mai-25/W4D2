
require_relative "piece"

class Board

    

    def initialize()
        @rows = Array.new(8) {Array.new(8)}
        populate_board
    end

    def populate_board
        @rows.each_with_index{|sub_row, idx|
            if [0,1,6,7].include?(idx)
                @rows[idx].map!{|grid| Piece.new("piece")}
            else
                @rows[idx].map!{|grid| NullPiece.new("nullpiece")}
            end
        }
    end

    def render()
        @rows.each{|sub_row|
            p sub_row.map{|ele| ele.name}
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
    end

end
