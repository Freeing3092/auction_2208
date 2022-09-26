require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  
  context 'initialize' do
    it "exists" do
      expect(auction).to be_a Auction
    end
    
    it "has readable attributes" do
      expect(auction.items).to eq([])
    end
  end
  
  context 'behavior' do
    it "#add_item adds an Item to the items attribute" do
      auction.add_item(item1)
      auction.add_item(item2)
      
      expect(auction.items).to eq([item1, item2])
    end
  end
end