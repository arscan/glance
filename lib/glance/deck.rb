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
        anext = a.next
        bnext = b.next

        anext ||= Time.now
        bnext ||= Time.now
        # if they are due within a minute, sort based on difficulty instead
        if ((anext-bnext)/60).round == 0
          a.difficulty <=> b.difficulty
        else
          anext <=> bnext
        end
      end


      tmpcards.each do |t|
        ret << t if ret.length < num && (t.next && t.next < Time.now)
      end

      ret

    end
  end
end
