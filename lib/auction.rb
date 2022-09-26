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
    @items.sum {|item| item.current_high_bid}
  end
  
  def bidders
    names = []
    @items.each do |item|
      item.bids.each_key do |attendee|
        names << attendee.name
      end
    end
    names.uniq
  end
  
  def unique_bidders
    uniq_bidders = @items.map do |item|
      item.bids.keys
    end.flatten.uniq
  end
  
  def bidder_info
    uniq_bidders = unique_bidders
    bidders_hash = Hash.new
    uniq_bidders.each do |bidder|
      bidders_hash[bidder] = {:budget => bidder.budget,
        :items => @items.select { |item| item.bids.include?(bidder)}
      }
    end
    bidders_hash
  end
  
end