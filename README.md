# Beret

A Ruby utility for consuming and manipulating Colonel Kurtz data

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'beret'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install beret

## Usage

Beret lets you easily work with [Colonel Kurtz](https://github.com/vigetlabs/colonel-kurtz)-generated JSON data in your Ruby application.

### Examples
```ruby
# Grab your CK JSON from wherever it lives.
ck_json = "[{\"content\":{\"text\":\"This is some text.\"},\"type\":\"redactor\",\"blocks\":[{\"type\":\"image\", \"content\":{\"photo_id\":\"42\"}},{\"type\":\"avatar\", \"content\":{\"photo_id\":\"144\"}}]}]"

# Initialization
beret = Beret.new(ck_json)

# Finding values
beret.find(:photo_id) # => [<Beret::SearchResult value="42">, <Beret::SearchResult value="144">]
beret.find(:photo_id, in: [:image]) # => [<Beret::SearchResult value="42">]
beret.find(:photo_id, in: [:avatar]) # => [<Beret::SearchResult value="144">]
beret.find(:photo_id, in: [:some_other_block_type]) # => []

# Using SearchResult objects
result = beret.find(:photo_id).first
result.value # => "42"
result.field_name # => "photo_id"
result.block # => <Beret::Block>
result.block.attributes # => { "photo_id" => "42" }
result.block.type # => "image"
result.block.parent # => <Beret::Block>

# In-place updating
beret.update(:photo_id, in: [:image]) do |value|
  # Transform the value any way you'd like here.
  # In this example, we convert a plain old ID to a SGID
  Image.find(value).to_sgid
end

# Retrieving JSON
beret.to_json
