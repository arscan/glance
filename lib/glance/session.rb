require "yaml"

module Glance

  class Session

    attr_reader :cards, :decks

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


    def load!(glancefile = ENV['HOME'] + '/.glance')
      gf = YAML::load(File.open(glancefile))
      gf.each do |a|
        @decks << a
      end

    end

    def save(glancefile = ENV['HOME'] + '/.glance')

      output = decks.to_yaml
      File.open(glancefile,'w'){ |f| f.write output}

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
