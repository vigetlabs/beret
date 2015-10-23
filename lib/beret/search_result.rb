module Beret
  class SearchResult

    attr_reader :block, :field_name

    def initialize(block, field_name)
      @block = block
      @field_name = field_name
    end

    def value
      block.attributes.fetch(field_name)
    end

  end
end
