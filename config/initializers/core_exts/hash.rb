class Hash
  def include_all?(key, *keys)
    (keys << key).all? { |k| include? k }
  end
end
