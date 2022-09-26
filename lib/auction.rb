class Auction
  attr_reader :items
  
  def initialize
    @items = []
  end
  
  def add_item(item)
    @items << item
  end
  
  def item_names
    @items.map { |item| item.name }
  end
  
  def unpopular_items
    @items.select {|item| item.bids.empty?}
  end
  
  def potential_revenue
    items_with_bids = @items.select {|item| item.current_high_bid != nil}
    items_with_bids.sum {|item| item.current_high_bid}
  end
end