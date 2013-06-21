require_relative "spec_helper"

module Glance

  describe "deck" do

    before :each do
      @deck = Deck.new "this is my deck name", "this is my deck description"
    end

    describe "#new" do
      it "should take 2 parameters" do
        @deck.should be_an_instance_of Deck
      end
    end

    it "should be able to add a card" do
      card = Card.new("Question", "Answer", 1)
      @deck.add_card card
      @deck.cards.length.should eql 1
    end

    it "should be able to remove a card" do
      card = Card.new("Question", "Answer", 1)
      @deck.add_card card
      @deck.cards.clear
      @deck.cards.length.should eql 0
    end

    describe "card actions on deck" do
      before :each do
        10.times do |i|
         card = Card.new("Question#{i}","Answer#{i}",i) 
         @deck.add_card(card)
        end
        
      end


    end


    
  end

end
