require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
  let(:auction) {Auction.new}
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  let(:item3) {Item.new('Homemade Chocolate Chip Cookies')}
  let(:item4) {Item.new('2 Days Dogsitting')}
  let(:item5) {Item.new('Forever Stamps')}
  let(:attendee1) {Attendee.new({name: 'Megan', budget: '$50'})}
  let(:attendee2) {Attendee.new({name: 'Bob', budget: '$75'})}
  let(:attendee3) {Attendee.new({name: 'Mike', budget: '$100'})}
  
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
    
    it "#item_names returns an array with the names of the auction items" do
      auction.add_item(item1)
      auction.add_item(item2)
      result = ["Chalkware Piggy Bank", "Bamboo Picture Frame"]
      
      expect(auction.item_names).to eq(result)
    end
    
    it "unpopular_items returns an array of items with no bids" do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      result = [item2, item3, item5]
      
      expect(auction.unpopular_items).to eq(result)
      
      item3.add_bid(attendee2, 15)
      result = [item2, item5]
      
      expect(auction.unpopular_items).to eq(result)
    end
    
    it "potential_revenue returns the total of the current high bids
    across all items" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    
    expect(auction.potential_revenue).to eq(87)
    end
  end
  
end