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

    it "should grab 20 cards"do
      100.times do |i|
       card = Card.new("Question#{i}","Answer#{i}",i%10) 
       @deck.add_card(card)
      end
        
      cards = @deck.deal(20)

      cards.length.should eql 20
    end

    it "should deal cards in the right order" do
      30.times do |i|
        card = Card.new("No #{i}", "No", i%10, unlocked: true, history: [3,3,3,3,3,3,3,3], last: Time.now, next: Time.now + 1000)
        @deck.add_card card
      end

      10.times do |i|
        card = Card.new("Yes old #{i}", "Yes Old", i, unlocked: true, history: [2,2,2,2,3,3], last:Time.now-100, next: Time.now - 100)
        @deck.add_card card
      end

      10.times do |i|
        card = Card.new("Yes new #{i}", "Yes New", i, unlocked: false, last:Time.now, next: Time.now)
        @deck.add_card card
      end

      30.times do |i|
        card = Card.new("No #{i}", "No", i%10, unlocked: true, history: [3,3,3,3,3,3,3,3], last: Time.now, next: Time.now + 1000)
        @deck.add_card card
      end
      
      cards = @deck.deal(15)


      yes_old =[]
      yes_new =[]
      no = [] 

      cards.each do |c|

        no << c if c.answer == "No"
        yes_old << c if c.answer == "Yes Old"
        yes_new << c if c.answer == "Yes New"

      end

      no.length.should eql 0
      yes_old.length.should  eql 10
      yes_new.length.should  eql 5

    end

    it "should deal easier cards, all else being equal" do

      100.times do |i|
        card = Card.new("Question #{i}", "Answer", i%10)
        @deck.add_card card
      end

      cards = @deck.deal(9)
      cards.all?{|c| c.difficulty == 0}.should be true
    end


  end

end
