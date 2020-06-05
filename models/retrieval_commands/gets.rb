# frozen_string_literal: true

class Gets < Retrieval
  def initialize(array, hash)
    gets(array, hash)
  end

  #Gets Memcached method: params => array, hash
  # array => command info received
  # hash => general hash in memory
  # Returns the unique key of the data stored
  #
  def gets(array, hash)
    response = hash[array[1]]
    response_ = (response[:cas_unique]) unless response.nil?

    response_.nil? ? (self.result = 'false') : (self.result = "\r\n" + response_)

    self.result = 'ERROR' if array.length != 2
  end
end
