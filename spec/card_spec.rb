require_relative 'spec_helper'

module Glance

  describe "card" do

    before :each do
      @card = Card.new "Question", "Answer", 1, history: [1,2,3,2,1,2]
    end

    describe "#new" do
      it "should take question and answer parameters" do
        @card.should be_an_instance_of Card
      end
    end

    it "should tell me what the question was" do
      @card.question.should eql "Question"
      
    end

    it "should tell me what the answer was" do
      @card.answer.should eql "Answer"
      
    end

    it "should tell me what the difficulty was" do
      @card.difficulty.should eql 1
    end

    it "should have a history length 6" do
      @card.history.length.should eql 6
    end

    it "should have a history length 0 when history not supplied" do
      Card.new("questsion","answer",1).history.length.should eql 0
    end

    it "shouldn't be unlocked by default" do
      @card.unlocked.should eql false
    end

    describe "#score" do
      before :each do
        @card = Card.new "Question", "Answer", 1
      end

      it "should return true if I score a couple 3's in a row" do
        @card.score(2)
        @card.score(1)
        @card.score(3)
        @card.score(3).should eq true
        
      end

      it "should return false if I don't score a couple 3's in a row" do
        @card.score(3)
        @card.score(2)
        @card.score(1)
        @card.score(3).should eq false
      end

      it "should return false the fist score that I do" do
        @card.score(3).should eq false
      end

      it "should say that i went recently" do
        @card.score(3)
        @card.last.should be < Time.now
        @card.last.should be > Time.now - 10

      end

      it "should tell me to go again if I had a one recently" do
        3.times {@card.score(2)}
        @card.score(1)
        3.times {@card.score(2)}
        @card.score(3)
        @card.next.should be < Time.now
      end

      it "should tell me I don't need to go again if I've been doing well" do
        @card.score(1)
        5.times {@card.score(3)}
        2.times {@card.score(2)}
        2.times {@card.score(3)}
        @card.next.should be > Time.now
      end

      it "should not make me do this for a few more days" do
        5.times {@card.score(3)}
        @card.next.should be > Time.now + (60*60*24) * 3
        @card.next.should be < Time.now + (60*60*24)*6
      end

      it "should not make me do this for a few more days" do
        5.times {@card.score(3)}
        @card.score(1)
        5.times {@card.score(3)}
        @card.next.should be > Time.now + (60*60*24) * 3
        @card.next.should be < Time.now + (60*60*24)*6
      end

      it "should not make me do this for a few more days" do
        5.times {@card.score(3)}
        @card.score(1)
        5.times {@card.score(3)}
        2.times {@card.score(2)}
        2.times {@card.score(3)}
        @card.next.should be > Time.now + (60*60*24) * 6
        @card.next.should be < Time.now + (60*60*24)*8
      end

    end

  end

end

