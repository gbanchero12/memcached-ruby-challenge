require 'socket'
client = TCPSocket.open('localhost', 2000)

command = gets.chomp
client.puts "#{command.to_s}"



while line = client.gets # Read lines from socket
  puts line         # and print them
end
client.close;