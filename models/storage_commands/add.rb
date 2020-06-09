
class Add < Storage

  def initialize(array, hash)
    hash[array[1]].nil? ? add(handleRequest(array), hash)  : self.result = 'NOT_STORED'
    result
  end

  attr_reader :result

  attr_writer :result

  # Add Memcached method: params => value, hash
  # value => result of superclass method handleRequest with values to storage
  # hash => general hash in memory
  # Set a value to a new key. If the key already exists, then it gives the output NOT_STORED.
  #
  def add(value, hash)
    hash[value[:key]] = { flags: value[:flags], exptime: value[:exptime], value: value[:value], cas_unique: value[:cas_unique] }
    value[:reply] != 'false' ? (self.result = "\r\nSTORED") : (self.result = '')
  end

  def to_s
    result.to_s
  end
  end


