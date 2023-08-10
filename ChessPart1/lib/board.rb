
require_relative "piece"

class Board

    attr_reader :rows

    def initialize()
        @rows = Array.new(8) {Array.new(8)}
        populate_board
    end

    def populate_pieces(sub_row, idx, color)
        (0...sub_row.length).each{|jdx|
            case 
            when [0,7].include?(jdx)
                @rows[idx][jdx] = Rook.new(color, [idx, jdx], self)
            when [1,6].include?(jdx)
                @rows[idx][jdx] = Knight.new(color, [idx, jdx], self)
            when [2,5].include?(jdx)
                @rows[idx][jdx] = Bishop.new(color, [idx, jdx], self)
            when jdx == 3
                @rows[idx][jdx] = Queen.new(color, [idx, jdx], self)
            else
                @rows[idx][jdx] = King.new(color, [idx, jdx], self)
            end  
        }
    end

    def populate_board
        @rows.each_with_index{|sub_row, idx|
            if idx == 0
                populate_pieces(sub_row, idx, :yellow)
            elsif idx == 1
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = Pawn.new(:yellow, [idx, jdx], self)}
            elsif idx == 6
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = Pawn.new(:white, [idx, jdx], self)}
            elsif idx == 7
                populate_pieces(sub_row, idx, :white)
            else
                sub_row.each_with_index{|ele, jdx| @rows[idx][jdx] = NullPiece.instance}
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
        
        if !piece_instance.moves.include?(end_pos)
            raise "Cant move to end pos #{end_pos}"
        end

        piece_instance.pos = end_pos
        self[end_pos], self[start_pos] = piece_instance , NullPiece.instance
    end

    def valid_pos?(new_pos)
        row, col = new_pos
        row >= 0 && row <= 7 && col >= 0 && col <= 7
    end

    def find_king(color)
        @rows.each_with_index{|sub_row, idx|
            sub_row.each_with_index{|piece, jdx|
                return [idx, jdx] if piece.is_a?(King) && piece.color == color
            }
        }
    end

    def in_check?(color)
        #find the kings position by color
        kings_pos = find_king(color)
        @rows.any?{|sub_row|
            sub_row.any?{|piece|
                if !piece.empty? && piece.moves.include?(kings_pos)
                    return true
                end
            }
        }
    end

    def dup()
        board_dup = Board.new()
        @rows.each_with_index{|sub_row, idx|
            sub_row.each_with_index{|piece, jdx|
                piece.is_a?(NullPiece) ? new_piece_inst = NullPiece.instance : new_piece_inst = piece.class.new(piece.color, [idx, jdx], board_dup)
                
                board_dup[[idx, jdx]] = new_piece_inst
            }
        }
        board_dup
    end

    def valid_moves(color)
        @rows.any?{|sub_row|
            sub_row.any?{|piece|
                if piece.empty? || piece.color != color
                    next
                end

                piece.moves.any?{|pos|
                    !piece.still_in_check?(pos)
                }
            }
        }
    end

    def checkmate?(color)
        return in_check?(color) && !valid_moves(color)
    end

end

