
class Storage
  def initialize
    value
  end

  attr_reader :value

  attr_writer :value

  def handleRequest(arr)
    key = arr[1]
    flags = arr[2]
    expire_time = arr[3].to_i

    bytes = arr[4]
    reply = arr.length == 7 ? arr[5] : true # default true
    value = arr.length == 7 ? arr[6] : arr[5]
    exptime_ = Time.now + expire_time
    o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
    cas_unique = (0...8).map { o[rand(o.length)] }.join
    self.value = { key: key, flags: flags, exptime: exptime_.to_s, value: value, cas_unique: cas_unique, reply: reply, bytes: bytes }

  end

  
end
