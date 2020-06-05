

class Replace < Storage

  def initialize(array, hash)
    hash[array[1]].nil? ? self.result = 'NOT_STORED' : replace(handleRequest(array), hash)
    result
  end

  attr_reader :result

  attr_writer :result

  # Replace Memcached method: params => value, hash
  # value => result of superclass method handleRequest with values to storage
  # hash => general hash in memory
  # Replace the value of an existing key. If the key does not exist, then it gives the output NOT_STORED.
  #
  def replace(value, hash)
    hash[value[:key]] = { flags: value[:flags], exptime: value[:exptime_].to_s, value: value[:value], cas_unique: value[:cas_unique] }
    value[:reply] != 'false' ? (self.result = "\r\nSTORED") : (self.result = '')
  end

  def to_s
    result.to_s
  end
end

