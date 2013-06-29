require_relative "../glance"

module Glance

  class Deck

    attr_accessor :name, :descripton
    attr_reader :cards

    def initialize name, description
      @name, @descripton = name, description

      @cards =[] 
    end

    def add_card card
      @cards << card

    end

    def deal(num)

      ret =  []
      tmpcards = @cards.clone

      while ret.length < num
        next_i = rand(tmpcards.length)
        ret << tmpcards[next_i]
        tmpcards.delete_at next_i
      end

      ret

    end
  end
end
