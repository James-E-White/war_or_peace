require 'rspec'
require 'pry'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'
# from here to war_or_peace runner to play gameplay
# Order matters
# how does the match start-end
class Game
  attr_reader :player1,
              :player2,
              :turn_count,
              :turn_start

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_count = 0
    @turn_start = player1
  end

  def new_deck
    cards = []

    cards << card1 = Card.new(:heart, 'Jack', 11)
    cards << card2 = Card.new(:heart, '10', 10)
    cards << card3 = Card.new(:heart, '9', 9)
    cards << card4 = Card.new(:diamond, 'Jack', 11)
    cards << card5 = Card.new(:heart, '8', 8)
    cards << card6 = Card.new(:diamond, '8', 8)
    cards << card7 = Card.new(:heart, '3', 3)
    cards << card8 = Card.new(:diamond, '2', 2)
    cards << card9 = Card.new(:club, '9', 9)
    cards << card10 = Card.new(:diamond, '4', 4)
    cards << card11 = Card.new(:spade, '10', 10)
    cards << card12 = Card.new(:spade, 'Jack', 11)
    cards << card13 = Card.new(:club, '6', 6)
    cards << card14 = Card.new(:spade, '2', 2)
    cards << card15 = Card.new(:spade, '8', 8)
    cards << card16 = Card.new(:diamond, 'Queen', 12)
    cards << card17 = Card.new(:club, '5', 5)
    cards << card18 = Card.new(:spade, '4', 4)
    cards << card19 = Card.new(:club, '3', 3)
    cards << card20 = Card.new(:club, 'Ace', 14)
    cards << card21 = Card.new(:spade, '5', 5)
    cards << card22 = Card.new(:heart, '6', 6)
    cards << card23 = Card.new(:club, '7', 7)
    cards << card24 = Card.new(:spade, 'King', 13)
    cards << card25 = Card.new(:diamond, 'Ace', 14)
    cards << card26 = Card.new(:diamond, '6', 6)
    cards << card27 = Card.new(:spade, '9', 9)
    cards << card28 = Card.new(:heart, '4', 4)
    cards << card29 = Card.new(:spade, '7', 7)
    cards << card30 = Card.new(:diamond, '10', 10)
    cards << card31 = Card.new(:heart, '5', 5)
    cards << card32 = Card.new(:club, 'Jack', 11)
    cards << card33 = Card.new(:heart, '7', 7)
    cards << card34 = Card.new(:heart, 'Queen', 12)
    cards << card35 = Card.new(:heart, '2', 2)
    cards << card36 = Card.new(:diamond, 'King', 13)
    cards << card37 = Card.new(:club, '8', 8)
    cards << card38 = Card.new(:spade, 'Jack', 11)
    cards << card39 = Card.new(:club, '2', 2)
    cards << card40 = Card.new(:diamond, '3', 3)
    cards << card41 = Card.new(:club, 'Queen', 12)
    cards << card42 = Card.new(:diamond, '7', 7)
    cards << card43 = Card.new(:heart, 'King', 13)
    cards << card44 = Card.new(:spade, '3', 3)
    cards << card45 = Card.new(:spade, 'Queen', 12)
    cards << card46 = Card.new(:club, '4', 4)
    cards << card47 = Card.new(:club, '10', 10)
    cards << card48 = Card.new(:diamond, '5', 5)
    cards << card49 = Card.new(:club, 'King', 13)
    cards << card50 = Card.new(:spade, '6', 6)
    cards << card51 = Card.new(:diamond, '9', 9)
    cards << card52 = Card.new(:heart, 'Ace', 14)

    cards.shuffle!

    @full_deck = Deck.new(cards)
    @deck1 = @full_deck.cards[0, 26]
    @deck2 = @full_deck.cards[26, 26]
  end

  def start
    new_deck

    player1_deck = Deck.new(@deck1)
    player2_deck = Deck.new(@deck2)

    @player1 = Player.new('Megan', player1_deck)
    @player2 = Player.new('Aurora', player2_deck)
  end

  def play(_go = 'go')
    welcome_message
    input = gets.chomp.downcase
    if input == 'go'
      start
      game_loop
      display_game_winner
    else
      puts "Invalid input. Please type 'GO' to start the game."
    end
  end

  private

  def welcome_message
    puts 'Welcome to War! (or Peace) This game will be played with 52 cards.'
    puts 'The players today are Megan and Aurora.'
    puts "Type 'GO' to start the game!"
  end

  def game_loop
    until game_over?
      play_turn
      break if game_over? || quit_game?
    end

    display_game_winner
  end

  def quit_game?
    puts "Type 'quit' to exit the game."
    input = gets.chomp.downcase
    input == 'quit'
  end

  def play_turn
    turn = Turn.new(player1, player2)
    puts "Turn #{@turn_count}:"
    puts "#{player1.name} deck: #{player1.deck.cards.length} cards"
    puts "#{player2.name} deck: #{player2.deck.cards.length} cards"
    puts "Type 'c' to play the turn"
    input = gets.chomp.downcase
    if input == 'c'
      puts "\n===== Playing the turn ====="
      turn.play
      puts "Player 1 cards: #{player1.deck.cards}"
      puts "Player 2 cards: #{player2.deck.cards}"
      puts "Player 1 plays: #{turn.player1_card}"
      puts "Player 2 plays: #{turn.player2_card}"
      puts "Turn type: #{turn.type}"
      puts "Turn winner: #{turn.winner ? turn.winner.name : 'Tie'}"
      collect_spoils(turn)

      increment_turn_count
      puts "===========================\n\n"
      display_game_winner if game_over?
    else
      puts 'Invalid input. Turn skipped.'
    end
  end

  def game_over?
    player1.has_lost? || player2.has_lost?
  end

  def display_turn_results(turn)
    if turn.winner
      puts "Turn #{@turn_count}: #{turn.winner.name} won the turn!"
    else
      puts "Turn #{@turn_count}: It's a tie!"
    end
  end

  def collect_spoils(turn)
    if turn.winner
      turn.award_spoils(turn.winner)
    else
      turn.spoils_of_war.each(&:remove_card)
    end
  end

  def increment_turn_count
    @turn_count += 1
  end

  def display_game_winner
    if player1.has_lost? && player2.has_lost?
      puts 'The game ended in a draw!'
    elsif player1.has_lost?
      puts "#{player2.name} wins the game!"
    elsif player2.has_lost?
      puts "#{player1.name} wins the game!"
    end
  end
end
