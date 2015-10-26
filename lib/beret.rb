require "json"

require "beret/version"
require "beret/block"
require "beret/search"
require "beret/search_result"
require "beret/block_set"

module Beret
  def self.new(json)
    array = json.kind_of?(Array) ? json : JSON.parse(json)
    Beret::BlockSet.new(array)
  rescue JSON::ParserError
    raise "String provided to Beret.new() was not valid JSON."
  end
end
