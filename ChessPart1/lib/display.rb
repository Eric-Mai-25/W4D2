require "colorize"
require_relative "cursor"
require_relative "board"

class Display

    attr_reader :cursor, :board

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
    # while true
    b = dis_inst.board

    puts "f2, f3" 
    p b.move_piece([6,5], [5,5])
    dis_inst.render
    sleep(1)
    puts "e7, e5" 
    p b.move_piece([1,4], [3,4])
    dis_inst.render
    sleep(1)
    puts "g2, g4" 
    p b.move_piece([6,6], [4,6])
    dis_inst.render
    sleep(1)

    p b.move_piece([6,4], [5,4])
    dis_inst.render
    sleep(1)


    puts "d8, h4" 
    p b.move_piece([0,3], [4,7])
    dis_inst.render
    sleep(1)

    # p b.move_piece([6,7], [5,6])
    # dis_inst.render
    # sleep(1)

    p b.checkmate?(:white)

    dis_inst.render
end

make_move

