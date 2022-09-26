require './lib/item'

RSpec.describe Item do
  let(:item1) {Item.new('Chalkware Piggy Bank')}
  let(:item2) {Item.new('Bamboo Picture Frame')}
  
  context 'initialize' do
    it "exists" do
      expect(item1).to be_a Item
    end
    
    it "has readable attributes" do
      expect(item1.name).to eq("Chalkware Piggy Bank")
      expect(item1.bids).to eq({})
    end
  end 
end 
