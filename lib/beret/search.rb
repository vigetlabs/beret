module Beret
  class Search

    def initialize(block_set, field_name, options={})
      @block_set = block_set
      @field_name = field_name.to_s
      @applicable_block_types = Array(options.fetch(:in, [])).map(&:to_s)
    end

    def results
      block_list = flatten_block_set(block_set)
      block_list.map do |block|
        if (applicable_block_types.empty? || applicable_block_types.include?(block.type)) && block.attributes.has_key?(field_name)
          SearchResult.new(block, field_name)
        end
      end.compact
    end

    private

    attr_reader :applicable_block_types, :block_set, :field_name

    def flatten_block_set(block_set)
      block_set.each do |entry|
        if entry.children
          block_set = [block_set, flatten_block_set(entry.children)].compact.flatten
        end
      end

      block_set
    end

  end
end
