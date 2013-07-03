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

    def load_deck deckfile
      yaml = YAML::load(File.open(deckfile))
      newdeck = Deck.new(yaml["name"], yaml["description"])
      decks.each do |d|
         return if d.name == yaml["name"]
      end
      yaml["cards"].each do |c|
        newcard = Card.new(c["question"], c["answer"], c["difficulty"])
        newdeck.add_card(newcard)
      end
      add_deck(newdeck)
    end

    def play

      continue = true

      while @cards.length > 0 && continue
        card = @cards[rand(@cards.length)]

        f = Flash.new(card,self)
        
        yield f 

        continue = f.continue
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

    attr_accessor :continue

    def initialize(card,session)
      @card, @session = card, session
      @continue = true
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
