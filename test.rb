require 'socket'

class MyClient
  attr_reader :socket

  def initialize
    @socket = TCPSocket.open('localhost', 2000)
  end

  def send_data(data)
    @socket.puts data
  end

  def recv_data
    @socket.gets
  end

end

client = MyClient.new


# Test Case 1
# Assert that contains the word false in the result of the command
# Command 'get test1'
# Precondition: key test1 is deprecated in 2019
# Expected result false
#
#
client.send_data('get test')
response = client.recv_data
  if response.to_s.include?('false') == true
    puts 'test case 1 passed'
  else
    puts 'test case 1 not passed'
  end



# Test Case 2
# Assert that contains the word VALUE in the result of the command
# Command 'get test2'
# key test1 is stored
# Expected result 'VALUE test2 0 2020-07-01T00:04:00+00:00 12
#                   test_value_2'
#
client.send_data('get test')
response = client.recv_data
  if response.to_s.include?('STORED') == true
    print 'test case 1 passed'
  else
    print 'test case 1 not passed'
    print response
  end


