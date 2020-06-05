

class Get < Retrieval

  def initialize(array, hash)
    @split = '<!split!>send'
    get(array, hash)
  end

  #Get Memcached method: params => array, hash
  # array => command info received
  # hash => general hash in memory
  # Assign superclass 'result' of the operation
  #
  def get(array, hash)
    response = hash[array[1]]
    unless response.nil?
      response_ = ('VALUE' + array[1] + ' ' + response[:flags] + ' ' + response[:exptime] + ' ' + response[:value].length.to_s + "\r\n" + response[:value] + @split)
    end

    response_.nil? ? (self.result = 'false' + @split) : (self.result = "\r\n" + response_.to_s)

    self.result = ('ERROR' + @split) if array.length != 2
  end
end