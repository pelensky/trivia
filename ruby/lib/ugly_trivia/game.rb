module UglyTrivia
  class Player
    attr_accessor :place, :purse, :in_penalty_box
    attr_reader :name
    def initialize(name)
      @name = name
      @place = 0
      @purse = 0
      @in_penalty_box = false
    end

    def to_s
      name
    end
  end

  class Game
    def  initialize
      @players = []
      @in_penalty_box = Array.new(6, nil)

      @pop_questions = []
      @science_questions = []
      @sports_questions = []
      @rock_questions = []

      @current_player_index = 0
      @is_getting_out_of_penalty_box = false

      create_questions
    end

    def create_questions
      50.times do |i|
        @pop_questions.push "Pop Question #{i}"
        @science_questions.push "Science Question #{i}"
        @sports_questions.push "Sports Question #{i}"
        @rock_questions.push create_rock_question(i)
      end
    end

    def play
      not_a_winner = false
      begin
        roll(rand(5) + 1)

        if rand(9) == 7
          not_a_winner = wrong_answer
        else
          not_a_winner = was_correctly_answered
        end

      end while not_a_winner
    end

    def create_rock_question(index)
      "Rock Question #{index}"
    end

    def is_playable?
      how_many_players >= 2
    end

    def add(player_name)
      @players.push Player.new(player_name)
      @in_penalty_box[how_many_players] = false

      puts "#{player_name} was added"
      puts "They are player number #{@players.length}"
    end

    def how_many_players
      @players.length
    end

    def roll(roll)
      @current_player = @players[@current_player_index]
      puts "#{@current_player} is the current player"
      puts "They have rolled a #{roll}"

      if @in_penalty_box[@current_player_index]
        if roll % 2 != 0
          @is_getting_out_of_penalty_box = true

          puts "#{@current_player} is getting out of the penalty box"
          @current_player.place = @current_player.place + roll
          @current_player.place = @current_player.place - 12 if @current_player.place > 11

          puts "#{@current_player}'s new location is #{@current_player.place}"
          puts "The category is #{current_category}"
          ask_question
        else
          puts "#{@current_player} is not getting out of the penalty box"
          @is_getting_out_of_penalty_box = false
          end

      else

        @current_player.place = @current_player.place + roll
        @current_player.place = @current_player.place - 12 if @current_player.place > 11

        puts "#{@current_player}'s new location is #{@current_player.place}"
        puts "The category is #{current_category}"
        ask_question
      end
    end

  private

    def ask_question
      puts @pop_questions.shift if current_category == 'Pop'
      puts @science_questions.shift if current_category == 'Science'
      puts @sports_questions.shift if current_category == 'Sports'
      puts @rock_questions.shift if current_category == 'Rock'
    end

    def current_category
      return 'Pop' if @current_player.place == 0
      return 'Pop' if @current_player.place == 4
      return 'Pop' if @current_player.place == 8
      return 'Science' if @current_player.place == 1
      return 'Science' if @current_player.place == 5
      return 'Science' if @current_player.place == 9
      return 'Sports' if @current_player.place == 2
      return 'Sports' if @current_player.place == 6
      return 'Sports' if @current_player.place == 10
      return 'Rock'
    end

  public

    def was_correctly_answered
      if @in_penalty_box[@current_player_index]
        if @is_getting_out_of_penalty_box
          puts 'Answer was correct!!!!'
          @current_player.purse += 1
          puts "#{@current_player} now has #{@current_player.purse} Gold Coins."

          winner = did_player_win()
          next_player

          winner
        else
          next_player
          true
        end



      else

        puts "Answer was corrent!!!!"
        @current_player.purse += 1
        puts "#{@current_player} now has #{@current_player.purse} Gold Coins."

        winner = did_player_win
        next_player

        return winner
      end
    end

    def next_player
      @current_player_index += 1
      @current_player_index = 0 if @current_player_index == @players.length
    end

    def wrong_answer
  		puts 'Question was incorrectly answered'
  		puts "#{@current_player} was sent to the penalty box"
  		@in_penalty_box[@current_player_index] = true

      next_player
  		return true
    end

  private

    def did_player_win
      !(@current_player.purse == 6)
    end
  end
end
