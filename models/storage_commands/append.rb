

class Append < Storage

  def initialize(array, hash)
    hash[array[1]].nil? ? self.result = 'NOT_STORED' : append(handleRequest(array), hash, array)
    result
  end

  attr_reader :result

  attr_writer :result

  #Append Memcached method: params => value, array, hash
  # array => command info received
  # hash => general hash in memory
  # value => result of superclass method handleRequest with values to storage
  # Add some data in an existing key. The data is stored after the existing data of the key.
  #
  def append(value, hash, array)
    key = array[1]
    hash[value[:key]] = { flags: value[:flags], exptime: value[:exptime], value: hash[key][:value] + value[:value], cas_unique: value[:cas_unique] }
    value[:reply] != 'false' ? (self.result = "\r\nSTORED") : (self.result = '')
  end

  def to_s
    result.to_s
  end
end


