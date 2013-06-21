module Glance
  class Card

    attr_reader :question, :answer, :difficulty

    def initialize question, answer, difficulty, opts = {}
      @question, @answer, @difficulty = question, answer, difficulty
      
    end
  end
end
