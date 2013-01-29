module Room
  attr_reader :short, :long, :area, :items, :exits

  def from_hash(props)
    @short = props['short'] || 'Room'
    @long = props['long'] || 'An empty room.'
    @area = props['area'] || 'Area'
    @items = props['items'] || {}
    @exits = props['exits'] || {}
  end
end