class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    return {} unless hash
    JSON.parse(hash).deep_symbolize_keys if hash.is_a?(String)
  end
end
