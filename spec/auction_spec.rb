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
    
    it "#bidders returns an array of names of attendees who have bid on an
    item" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    result = ["Megan", "Bob", "Mike"]
    
    expect(auction.bidders).to eq(result)
    end
    
    it "unique_bidders returns an array of unique Attendee bidders" do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      result = [attendee2, attendee1, attendee3]
      
      expect(auction.unique_bidders).to eq(result)
    end
    
    it "bidder_info returns a hash with keys that are attendees, and values 
    that are a hash with that attendee's budget and an array of items that 
    attendee has bid on." do
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee2, 20)
      item1.add_bid(attendee1, 22)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      
      result = {
          attendee1 =>
        {
          :budget => 50,
          :items => [item1]
        },
          attendee2 =>
        {
          :budget => 75,
          :items => [item1, item3]
        },
          attendee3 =>
        {
          :budget => 100,
          :items => [item4]
        }
      }
      expect(auction.bidder_info).to eq(result)
    end
    
    it "#date returns the date of the event" do
      allow(auction).to receive(:date).and_return('01/01/2022')
      expect(auction.date).to eq('01/01/2022')
    end
    
    it "#close_auction returns a hash with items as the keys, and the purchaser
    of that item as the values" do
    auction.add_item(item1)
    auction.add_item(item2)
    auction.add_item(item3)
    auction.add_item(item4)
    auction.add_item(item5)
    item1.add_bid(attendee1, 22)
    item1.add_bid(attendee2, 20)
    item4.add_bid(attendee2, 30)
    item4.add_bid(attendee3, 50)
    item3.add_bid(attendee2, 15)
    item5.add_bid(attendee1, 35)
    
    result = {item5 => attendee1,
              item1 => attendee2,
              item4 => attendee3,
              item3 => attendee2,
              item2 => 'Not Sold'
    }
    
    expect(auction.close_auction).to eq(result)
    end
  end
  
end














