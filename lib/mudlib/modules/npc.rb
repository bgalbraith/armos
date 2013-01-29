module NPC
  attr_reader :name, :description, :dialogue

  def from_hash(props)
    @name = props['name'] || 'An NPC'
    @description = props['description'] || 'No description given.'
    @dialogue = props['dialogue'] || {}
  end
end