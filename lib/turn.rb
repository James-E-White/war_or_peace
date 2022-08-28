class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war

   def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
   end

  def type
      #how the game is played. must have a winner or war! if two war than spoils of war! rank_of_cards_at
      #get discarded with no winner.
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
      :war
    elsif @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
        :basic

    end
  end

    def winner
      if type == :mutually_assured_destruction
        "No Winner"
      elsif
        if type == :war
          @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
          @player1
        elsif
          @player2
        end
        if type == :basic
          if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
            @player1
          else
            #@player1.deck.rank_of_cards_at(0) < @player2.deck.rank_of_cards_at(0)
            @player2
          end
        end
      end
    end

    def pile_cards
     if type == :basic
       @spoils_of_war << @player1.deck.remove_card
       @spoils_of_war << @player2.deck.remove_card
     elsif type == :war
       3.times do
         @spoils_of_war << @player1.deck.remove_card
         @spoils_of_war << @player2.deck.remove_card
       end
     elsif type == :mutually_assured_destruction
       
     end
    end



    def award_spoils(winner)

     # if winner == @player1
       winner.deck.cards.concat(@spoils_of_war)
    #    @player1.deck.cards.flatten!
    #  else
    #    winner == @player2
    #    @player2.deck.cards.concat(@spoils_of_war)
    #    @player2.deck.cards.flatten!
    #  end
    end
end


       #  def war
       #    if turn.type == war
       #    if @player1.deck.rank_of_cards_at(0) == @player2.deck.rank_of_cards_at(0)
       #      @war
       #    end
       #
       # end
