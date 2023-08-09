require "colorize"
require_relative "cursor"
require_relative "board"

class Display

    attr_reader :cursor

    def initialize
        @board = Board.new()
        @cursor = Cursor.new([0,0], @board)
    end

    def render
        bg_colors = [:white, :black]
        @board.rows.each_with_index{|sub_row, idx|
            new_sub_row = []
            sub_row.each_with_index{|piece, jdx|
                if @cursor.cursor_pos == [idx,jdx]
                    new_sub_row << " #{piece.symbol} ".colorize(:background => :blue)
                else
                    new_sub_row << " #{piece.symbol} ".colorize(:color => piece.color, :background => bg_colors[0])
                end
                bg_colors.rotate!
            }
            bg_colors.rotate!
            puts new_sub_row.join("")
        }

    end

    
end

def make_move()
    puts "Hey Lets play Chess !!!!!"
    dis_inst = Display.new()
    dis_inst.render
    while true
        dis_inst.cursor.get_input
        system "clear"
        dis_inst.render
    end
end

make_move

