require './lib/item'
require './lib/attendee'

RSpec.describe Item do
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:attendee1) {Attendee.new({name: 'Megan', budget: '$50'})}
  let(:attendee2) {Attendee.new({name: 'Bob', budget: '$75'})}
  
  context 'initialize' do
    it "exists" do
      expect(item1).to be_a Item
    end
    
    it "has readable attributes" do
      expect(item1.name).to eq("Chalkware Piggy Bank")
      expect(item1.bids).to eq({})
      expect(item1.closed).to eq(false)
    end
  end 
  
  context 'behavior' do
    it "#add_bid takes an Attendee and amount as arguments and adds them
    to the bids hash as a key value pair" do
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      result = {attendee2 => 20, attendee1 => 22}
      
      expect(item1.bids).to eq(result)
    end
    
    it "current_high_bid returns the highest bid for an item" do
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      
      expect(item1.current_high_bid).to eq(22)
    end
    
    it "#close_bidding discontinues the add_bid method for an item" do
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      result = {attendee2 => 20, attendee1 => 22}
      
      item1.close_bidding
      item1.add_bid(attendee2, 70)
      
      expect(item1.bids).to eq(result)
    end
  end
end 
