class Item
  attr_reader :name, :bids, :closed
  
  def initialize(name)
    @name = name
    @bids = Hash.new(0)
    @closed = false
  end
  
  def add_bid(attendee, bid)
    @bids[attendee] = bid if @closed == false
  end
  
  def current_high_bid
    return 0 if @bids.empty?
    @bids.values.max
  end
  
  def close_bidding
    @closed = true
  end
end