module Glance
  class Card

    attr_reader :question, :answer, :difficulty
    attr_reader :history, :next, :last, :unlocked

    def initialize(question, answer, difficulty, opts = {})
      @question, @answer, @difficulty = question, answer, difficulty

      @history = []
      @next = Time.now
      @last = Time.now
      @unlocked  = false

      @history = opts[:history] if opts.has_key?(:history)
      @last = opts[:last] if opts.has_key?(:last)
      @next = opts[:next] if opts.has_key?(:next)
      @unlocked = opts[:unlocked] if opts.has_key?(:unlocked)
      
    end

    def score(score)
      @history << score
      @next = calc_next
      @last = Time.now
      return false if @history.length < 2
      @history[-2..-1].all?{|h| h == 3}
    end

    private

    def calc_next

      # count the number of perfect scores at the end
      first_two = @history.reverse.index(2)
      first_one = @history.reverse.index(1)

      first_two ||= @history.length
      first_one ||= @history.length

      non_three = [first_one, first_two].min

      # count the number of threes since my last one

      recent_threes = @history.reverse[0..first_one].count(3)

      # if had a one in the last 5, automatically keep me around
      #
      return Time.now if first_one < 5

      Time.now + recent_threes * 60 * 60 * 24

    end

  end

end
