require_relative "spec_helper"

module Glance

  describe "session" do

    before :each do
      deck = Deck.new "Name", "Descripton"
      @session = Session.new deck
    end

    describe "#new" do
      it "should take one variable" do
        @session.should be_an_instance_of Session
      end
    end


  end


end
