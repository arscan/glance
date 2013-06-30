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
      tmpcards.sort! do |a,b|
        # if they are due within a minute, sort based on difficulty instead
        if ((a.next-b.next)/60).round == 0
          a.difficulty <=> b.difficulty
        else
          a.next <=> b.next
        end
      end


      tmpcards.each do |t|
        ret << t if ret.length < num
      end

      ret

    end
  end
end
