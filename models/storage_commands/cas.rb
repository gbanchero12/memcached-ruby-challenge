# frozen_string_literal: true

class Cas < Storage
  def initialize(array, hash)
    if hash[array[1]].nil?
      self.result = "\r\nNOT_FOUND"
    elsif hash[array[1]][:cas_unique] != array[5]
      self.result = "\r\nEXISTS"
    elsif cas(handleRequest(array), hash, array)
      end
    result
  end

  attr_reader :result

  attr_writer :result

  #Cas Memcached method: params => value, array, hash
  # array => command info received
  # hash => general hash in memory
  # value => result of superclass method handleRequest with values to storage
  # Assign a value only if it has not been modified since your last get from the user
  #
  def cas(value, hash, array)
    key = array[1]
    hash[value[:key]] = { flags: value[:flags], exptime: value[:exptime_].to_s, value: value[:value] + hash[key][:value], cas_unique: value[:cas_unique] }
    value[:reply] != 'false' ? (self.result = "\r\nSTORED") : (self.result = '')
  end

  def to_s
    result.to_s
  end
end
