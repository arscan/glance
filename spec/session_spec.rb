require_relative "spec_helper"

module Glance

  describe "session" do

    before :each do
      @session = Session.new(30)
    end

    describe "#new" do
      it "shouldn't take any vars" do
        @session.should be_an_instance_of Session
      end
    end

    it "should be able to deal some cards and eventually finish" do

      deck = Deck.new("test deck", "test deck descripton")
      30.times do |i|
        deck.add_card(Card.new("question#{i}","answer#{i}", (i%10)+1))
      end
      @session.add_deck(deck)


      @session.play do |f|
        f.question.should be_an_instance_of String
        f.score(3)

      end
    end

    it "should finish quickly if all 3's" do

      deck = Deck.new("test deck", "test deck descripton")
      30.times do |i|
        deck.add_card(Card.new("question#{i}","answer#{i}", (i%10)+1))
      end
      @session.add_deck(deck)


      i = 0
      @session.play do |f|
        i += 1
        f.score(3)
      end

      i.should be > 50
      i.should be < 70

    end
    it "should finish not so quickly if some 2's" do

      deck = Deck.new("test deck", "test deck descripton")
      30.times do |i|
        deck.add_card(Card.new("question#{i}","answer#{i}", (i%10)+1))
      end
      @session.add_deck(deck)


      i = 0
      @session.play do |f|
        i+= 1
        if i < 20
          f.score(2)
        else
          f.score(3)
        end
        
      end

      i.should be > 70
      i.should be < 100

    end


  end


end
