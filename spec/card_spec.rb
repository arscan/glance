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

    it "hsitory should be an array of lenght 6" do
      @card.history.length.should eql 6
    end
  end

end

