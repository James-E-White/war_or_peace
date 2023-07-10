class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :type

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    determine_turn_type
  end

  def play
    if type == :basic
      play_basic_turn
    elsif type == :war
      play_war_turn
    else
      play_mutually_assured_destruction_turn
    end
  end

  def player1_card
    player1.deck.cards[0]
  end

  def player2_card
    player2.deck.cards[0]
  end

  def winner
    if type == :basic
      determine_basic_winner
    elsif type == :war
      determine_war_winner
    else
      'No winner for mutually assured destruction'
    end
  end

  def award_spoils(winner)
  if type == :basic
    winner.deck.add_cards(player1.deck.cards.shift(1))
    winner.deck.add_cards(player2.deck.cards.shift(1))
  elsif type == :war
    3.times do
      winner.deck.add_cards(player1.deck.cards.shift(1))
      winner.deck.add_cards(player2.deck.cards.shift(1))
    end
  elsif type == :mutually_assured_destruction
    3.times do
      player1.deck.cards.shift(1)
      player2.deck.cards.shift(1)
      end
    end
  end

  private

  def determine_basic_winner
    if player1_card.rank > player2_card.rank
      player1
    elsif player2_card.rank > player1_card.rank
      player2
    else
      'No winner'
    end
  end

  def determine_turn_type
    @type = if player1.deck.cards[0].rank == player2.deck.cards[0].rank
              if player1.deck.cards[2].nil? || player2.deck.cards[2].nil?
                :mutually_assured_destruction
              else
                :war
              end
            else
              :basic
            end
  end

  def play_basic_turn
    winner = determine_turn_winner(player1, player2)
    if winner
      add_spoils_to_winner(winner)
      puts "#{winner.name} won the turn!"
    else
      puts "It's a tie! No winner for this turn."
    end
  end

  def play_war_turn
    winner = determine_turn_winner(player1, player2, 3)
    if winner
      add_spoils_to_winner(winner)
      puts "#{winner.name} won the war!"
    else
      puts "It's a tie! No winner for this war."
    end
  end

  def play_mutually_assured_destruction_turn
    puts 'Turn ended in mutually assured destruction!'
  end

  def determine_turn_winner(player1, player2, compare_cards = 1)
    rank1 = player1.deck.rank_of_card_at(compare_cards)
    rank2 = player2.deck.rank_of_card_at(compare_cards)
    if rank1 > rank2
      player1
    elsif rank2 > rank1
      player2
    end
  end

  def add_spoils_to_winner(winner)
    winner.deck.cards.concat(spoils_of_war)
    @spoils_of_war = []
  end
end
