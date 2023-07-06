class Player
   #attr_reader allows accees to name and deck
  attr_reader :name #attr_reader = methods for class
  attr_accessor :deck

    def initialize(name, deck) 
      @name = name   
      @deck = deck 
    end

     def has_lost?
          @deck.cards.nil? || @deck.cards.empty?
   end
end
