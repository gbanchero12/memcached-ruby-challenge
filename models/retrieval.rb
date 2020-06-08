# frozen_string_literal: true

require 'date'
class Retrieval
  def initialize
    result
  end

  attr_reader :result

  attr_writer :result

  def to_s
    result.to_s
  end

  def checkExpiration(array, hash)
    response = hash[array[1]]
    expiration = !response.nil? ? DateTime.parse(response[:exptime]) : DateTime.now
    hash[array[1]] = nil if expiration < DateTime.now
  end
end
