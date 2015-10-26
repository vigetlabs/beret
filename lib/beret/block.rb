require "securerandom"

module Beret
  class Block

    attr_reader :id, :parent

    def initialize(block_json, options={})
      @id = SecureRandom.uuid
      @block_json = block_json
      @parent = options[:parent]
    end

    def attributes
      @attributes ||= block_json[content_key]
    end

    def update_attribute(field_name, value)
      @attributes[field_name.to_s] = value
    end

    def update_content(new_content)
      @attributes = Hash(new_content)
    end

    def type
      block_json[type_key]
    end

    def children
      @children ||= begin
        block_json[children_key] && block_json[children_key].map do |block|
          Block.new(block, parent: self)
        end
      end
    end

    def to_json
      {}.tap do |json|
        json[type_key] = block_json[type_key]
        json[content_key] = attributes

        if children
          json[children_key] = children.map(&:to_json)
        end
      end
    end

    private

    attr_reader :block_json

    def children_key
      "blocks"
    end

    def content_key
      "content"
    end

    def type_key
      "type"
    end

  end
end
