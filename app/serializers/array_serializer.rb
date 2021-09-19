class ArraySerializer
  def self.dump(array)
    array.to_json
  end

  def self.load(array)
    return [] unless array
    JSON.parse(array, symbolize_names: true) if array.is_a?(String)
  end
end
