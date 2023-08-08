class Piece

    attr_reader :name

    def initialize(name)
        @name = name
    end
end 

class NullPiece < Piece
end