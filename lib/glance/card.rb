module Glance
  class Card

    attr_reader :question, :answer, :difficulty
    attr_reader :history, :last, :unlocked

    def initialize(question, answer, difficulty, opts = {})
      @question, @answer, @difficulty = question, answer, difficulty

      @history = []
      @last = Time.now
      @unlocked  = false

      @history = opts[:history] if opts.has_key?(:history)
      @last = opts[:last] if opts.has_key?(:last)
      @unlocked = opts[:unlocked] if opts.has_key?(:unlocked)
      
    end
  end
end
