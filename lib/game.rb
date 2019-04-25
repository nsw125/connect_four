class Game
    attr_accessor :board
    def initialize
        #create our board as 7 arrays
        @board =    [[0,0,0,0,0,0],      #1
                     [0,0,0,0,0,0],      #2
                     [0,0,0,0,0,0],      #3
                     [0,0,0,0,0,0],      #4
                     [0,0,0,0,0,0],      #5
                     [0,0,0,0,0,0],      #6
                     [0,0,0,0,0,0]]      #7                        
    end

    def setup(name1 = nil, name2 = nil)
        puts "Welcome to Connect Four! Let's find out who our players are."
        puts "Starting with our first player."
        @player1 = Player.new(name1)
        puts
        puts "And now player two.."
        @player2 = Player.new(name2)
        puts "Okay, we have #{@player1.name} and #{@player2.name}!"

        puts "Let's determine who goes first."
        coin = rand(1..2)
        puts "*COIN FLIP*"
        coin == 1 ? winner = @player1 : winner = @player2
        puts "#{winner.name} wins! #{winner.name} gets to go first."
        @current_turn = winner
        @current_turn == @player1 ? piece_selector = @player2 : piece_selector = @player1
        puts "However, #{piece_selector.name} gets to choose what piece they want to be: (h)earts or (c)lubs?"
        piece_choice = gets.chomp.downcase
        until piece_choice == 'h' or piece_choice == 'c'
            puts "Choose either h for hearts or c for clubs."
            piece_choice = gets.chomp.downcase
        end
        piece_choice == 'h' ? piece_selector.piece = "\u2665" : winner.piece = "\u2665"
        piece_selector.piece == "\u2665" ? winner.piece = "\u2663" : piece_selector.piece = "\u2663"
        puts "Piece Selectors piece: #{piece_selector.piece}"
        puts "Coin winners piece: #{@current_turn.piece}"
    end

    def placepiece(selection = nil)
        #places a piece for the player whose turn it is currently.

        if selection == nil
            puts "It's your turn, #{@current_turn.name}"
            puts "Enter the column you'd like to place a piece."
            selection = gets.chomp.downcase
        end
        until selection.length == 1 and selection =~ /[0-6]/ and @board[selection.to_i].any? { |item| item == 0 } == true
            puts 'That is not a valid option. Enter a new option.'
            selection = gets.chomp.downcase
        end
        selection = selection.to_i
        i = 0
        until @board[selection][i] == 0
            i += 1
        end
        @board[selection][i] = @current_turn.piece
        check_for_winner(selection, i)
    end

    def play
        42.times do
            display_board
            placepiece
            @current_turn == @player1 ? @current_turn = @player2 : @current_turn = @player1
        end
    end

    def player1
        @player1.name
    end

    def player2
        @player2.name
    end

    def current_turn
        @current_turn
    end

    def display_board
        i = 5
        until i < 0
            print "#{i}   "
            @board.each do |item|
                print "| #{item[i]} " 
            end
            print '|'
            puts
            i -= 1
        end
        puts "     ----------------------------"
        puts "       0   1   2   3   4   5   6"
    end

    def check_for_winner(x, y)
        place_x = x
        place_y = y
        #puts "Location: #{x}, #{y}"
        count = 0

        #HORIZONTAL CHECK

        until @board[x - 1][y] != @current_turn.piece
            x -= 1
        end
        until @board[x][y] != @current_turn.piece or count == 4
            x += 1
            count += 1
        end
        #puts "Destination #{x}, #{y}"
        #puts "Count horizontal: #{count}"
        if count >= 4
            win_message
        end

        #Vertical Check
        x = place_x
        y = place_y
        count = 0
        until @board[x][y - 1] != @current_turn.piece
            y -= 1
        end
        until @board[x][y] != @current_turn.piece or count == 4
            y += 1
            count += 1
        end
        #puts "Destination #{x}, #{y}"
        #puts "Count vertical: #{count}"
        if count >= 4
            win_message
        end

        #Diagonal Check (top left to bottom right)
        x = place_x
        y = place_y
        count = 0
        until @board[x - 1][y + 1] != @current_turn.piece
            y += 1
            x -= 1
        end
        until @board[x][y] != @current_turn.piece or count == 4
            y -= 1
            x += 1
            count += 1
        end
        #puts "Destination #{x}, #{y}"
        #puts "Count diagonal: #{count}"
        if count >= 4
            win_message
        end

        #Diagonal Check (top right to bottom left)
        x = place_x
        y = place_y
        count = 0
        until @board[x + 1][y + 1] != @current_turn.piece
            y += 1
            x += 1
        end
        until @board[x][y] != @current_turn.piece or count == 4
            y -= 1
            x -= 1
            count += 1
        end
        #puts "Destination #{x}, #{y}"
        #puts "Count diagonal: #{count}"
        if count >= 4
            win_message
        end
=begin
        original_x = x
        original_y = y
        count = 1
        until @board[x][y] != @current_turn.piece or count == 4
            x -= 1
            if @board[x][y] == @current_turn.piece
                puts "New spot: #{x}, #{y}"
                count += 1
                puts "Counting Down: #{count}"
            end
        end
        x = original_x
        y = original_y
        until @board[x][y] != @current_turn.piece or count == 4
            x += 1
            if @board[x][y] == @current_turn.piece
                puts "New spot: #{x}, #{y}"
                count += 1
                puts "Counting up: #{count}"
            end
        end  
        puts "Count: #{count}"
=end
    end


    def win_message
        puts "------------GAME OVER------------"
        puts
        display_board
        puts
        puts "#{@current_turn.name} is the winner!"
        exit
    end

end

class Player
    attr_accessor :name, :piece
    def initialize(name = nil, piece = nil)
        unless name != nil
            puts 'Player: enter a name.'
            name = gets.chomp
        end
        @name = name
        @piece = piece

    end

end

game = Game.new
game.setup('nick', 'tyler')
game.play

#codes: hrt: 2665 clb: 2663

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