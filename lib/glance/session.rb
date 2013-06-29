module Glance

  class Session

    def initialize(num_cards = 20)
      @num_cards = num_cards
      @cards = []
      @decks = []
    end

    def add_deck deck
      @cards += deck.deal([@num_cards,deck.cards.length].min)
      @decks << deck
    end

    def play

      while @cards.length > 0
        card = @cards[rand(@cards.length)]
        
        yield Flash.new(card,self)

      end

      
    end

    def cards_left
      @cards.length
    end

    def remove_card(card)
     @cards.delete_if{|c| c == card} 
    end


  end

  class Flash
    def initialize(card,session)
      @card, @session = card, session
    end

    def question
      @card.question
    end
    def answer
      @card.answer
    end
    def score(score)
      @session.remove_card(@card) if @card.score(score)
    end
  end
end
