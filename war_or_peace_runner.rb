require 'pry'
require_relative './lib/card'
require_relative './lib/deck'
require_relative './lib/player'
require_relative './lib/turn'
require_relative './lib/game'

# Create the cards, decks, and players
cards = [] # Add all the card objects here

deck1 = Deck.new(cards[0, 26])
deck2 = Deck.new(cards[26, 26])

player1 = Player.new("Megan", deck1)
player2 = Player.new("Aurora", deck2)

# Create a new game and start it
game = Game.new(player1, player2)
game.play('go')