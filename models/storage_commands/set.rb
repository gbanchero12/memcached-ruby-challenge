# frozen_string_literal: true

class Set < Storage
  def initialize(array, hash)
    set(handleRequest(array), hash)
    result
  end

  attr_reader :result

  attr_writer :result

  # Add Memcached method: params => value, hash
  # value => result of superclass method handleRequest with values to storage
  # hash => general hash in memory
  # Set a new value to a new or existing key
  #
  def set(value, hash)
    hash[value[:key]] = { flags: value[:flags], exptime: value[:exptime], value: value[:value], cas_unique: value[:cas_unique] }
    value[:reply] != 'false' ? (self.result = "\r\nSTORED") : (self.result = '')
  end

  def to_s
    result.to_s
  end
end
