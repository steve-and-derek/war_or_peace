require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

suits = [:spade, :heart, :diamond, :club]
new_deck = []

suits.each do |suit|
  card_rank = 2
  while card_rank < 15 do
    if card_rank < 11
      new_deck << Card.new(suit, "#{card_rank}", card_rank)
    elsif card_rank == 11
      new_deck << Card.new(suit, "Jack", card_rank)
    elsif card_rank == 12
      new_deck << Card.new(suit, "Queen", card_rank)
    elsif card_rank == 13
      new_deck << Card.new(suit, "King", card_rank)
    elsif card_rank == 14
      new_deck << Card.new(suit, "Ace", card_rank)
    end
    card_rank += 1
  end
end

deck1 = Deck.new(new_deck.slice(0, 26))
deck2 = Deck.new(new_deck.slice(26, 26))

player1 = Player.new("Vivi", deck1)
player2 = Player.new("Derek", deck2)

turn = Turn.new(player1, player2)

turn.start
