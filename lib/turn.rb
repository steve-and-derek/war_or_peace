class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def player1_first_card_rank
    player1.deck.rank_of_card_at(0)
  end

  def player2_first_card_rank
    player2.deck.rank_of_card_at(0)
  end

  def player1_third_card_rank
    player1.deck.rank_of_card_at(2)
  end

  def player2_third_card_rank
    player2.deck.rank_of_card_at(2)
  end

  def type
    if player1_first_card_rank == player2_first_card_rank && player1_third_card_rank == player2_third_card_rank
      :mutually_assured_destruction
    elsif player1_first_card_rank != player2_first_card_rank
      :basic
    else
      :war
    end
  end

  def winner
    if type == :basic
      if player1_first_card_rank > player2_first_card_rank
        player1
      else
        player2
      end
    elsif type == :war
      if player1_third_card_rank == nil
        return winner = player2
      elsif player2_third_card_rank == nil
        return winner = player1
      elsif player1_third_card_rank > player2_third_card_rank
        player1
      else
        player2
      end
    else
      "No Winner" ####Look into this possibly
    end
  end

  def pile_cards
    if type == :basic
      spoils_of_war << player1.deck.cards[0]
      spoils_of_war << player2.deck.cards[0]
      player1.deck.remove_card
      player2.deck.remove_card
    elsif type == :war
      spoils_of_war << player1.deck.cards[0]
      spoils_of_war << player1.deck.cards[1]
      spoils_of_war << player1.deck.cards[2]
      spoils_of_war << player2.deck.cards[0]
      spoils_of_war << player2.deck.cards[1]
      spoils_of_war << player2.deck.cards[2]
      3.times do
        player1.deck.remove_card
      end
      3.times do
        player2.deck.remove_card
      end
    else
      3.times do
        player1.deck.remove_card
      end
      3.times do
        player2.deck.remove_card
      end
    end
  end

  def award_spoils(winner_of_turn)
    if type == :basic || type == :war
      if winner_of_turn == player1
        spoils_of_war.each do |card|
          player1.deck.cards << card
        end
        spoils_of_war.clear
      else
        spoils_of_war.each do |card|
          player2.deck.cards << card
        end
        spoils_of_war.clear
      end
    else
      "No Winner"
    end
  end

  def start
    puts "Welcome to War! (or Peace) This game will be played with 52 cards."
    puts "The players today are #{player1.name} and #{player2.name}."
    puts "Type 'GO' to start the game!"
    puts "-" * 66

    index = 0
    input = gets.upcase.chomp
    if input == "GO"
      until player1.has_lost? || player2.has_lost? do
        winner_of_turn = winner
        pile_cards
        award_spoils(winner_of_turn)
        index += 1
        if winner_of_turn == "No Winner"
          puts "Turn #{index}: *Mutually assured destruction* 6 cards removed from play"
        elsif type == :basic
          puts "Turn #{index}: #{winner_of_turn.name} won 2 cards"
        else
           puts "Turn #{index}: WAR - #{winner_of_turn.name} won 6 cards"
        end
        player1.deck.cards.shuffle!
        player2.deck.cards.shuffle!
        break if index == 1000000
      end

      if player1.has_lost?
        puts "*~*~*~* Derek has won the game! *~*~*~*"
      elsif player2.has_lost?
        puts "*~*~*~* Vivi has won the game! *~*~*~*"
      else
        puts "---- DRAW ----"
      end
    else
      puts "Fine, I guess you don't want to play the game"
    end
  end

end
