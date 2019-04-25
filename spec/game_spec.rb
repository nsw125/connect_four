require './lib/game'

RSpec.describe Game do

    describe "#initialize" do
        it "creates a board that is 7 arrays with 6 zeros inside" do
            game = Game.new
            expect(game.board[0].length).to eql(6)
            expect(game.board[1].length).to eql(6)
            expect(game.board[2].length).to eql(6)
            expect(game.board[3].length).to eql(6)
            expect(game.board[4].length).to eql(6)
            expect(game.board[5].length).to eql(6)
            expect(game.board[6].length).to eql(6)
        end
    end

    describe "#setup" do
        it "creates the first player" do
            game = Game.new
            game.setup('nick', 'tyler')
            expect(game.player1).to eql('nick')
        end

        it "creates the second player" do
            game = Game.new
            game.setup('nick', 'tyler')
            expect(game.player2).to eql('tyler')
        end

        it "determines who plays first" do
            game = Game.new
            game.setup('nick', 'tyler')
            expect(game.current_turn.nil?).to eql(false)
        end

    end

    describe "#placepiece" do
        it "places piece in the corresponding appropriate column." do
            game = Game.new
            game.setup('nick','tyler')
            game.placepiece(selection = '1')
            expect(game.board[0]).not_to eql(0)
        end

        #it "displays the board if the player calls 'display'" do

        #end

    end

    #it "checks after a piece is placed for a winner" do

    #end

    #it "switches turns to the other player if there was no winner detected" do

    #end

    #it "signals a winner when there is one" do

    #end

    #it "signals that no one wins if the board is filled with no winner" do

    #end

end

=begin
    Steps in order to play a game of connect four:
        -Set up players
        -Pick turn order
        -Process
            -Whoever's turn it is needs to place a piece
            -The game needs to check to see if there is a winner
            -If so, stop the game, announce the winner
            -If not, switch to the other player, and repeat the process
                -continue until a winner is announced, or the board is full
=end