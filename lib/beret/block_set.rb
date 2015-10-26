module Beret
  class BlockSet

    def initialize(block_json)
      @block_json = block_json
    end

    def find(field_name, options={})
      results = Search.new(blocks, field_name, options).results

      if block_given?
        results.each do |result|
          yield result.value, result.block
        end
      end

      results
    end

    def update(field_name, options={})
      results = find(field_name, options)

      results.each do |result|
        new_value = yield result.value, result.block
        result.block.update_attribute(field_name, new_value)
      end
    end

    def blocks
      @blocks ||= block_json.map do |block|
        Block.new(block)
      end
    end

    def to_json
      blocks.map(&:to_json)
    end

    private

    attr_reader :block_json

  end
end
