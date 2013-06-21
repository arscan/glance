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
  end
end
