require 'socket'

class Client
  def initialize(socket)
    @socket = socket
    @request_object = send_request
    @response_object = listen_response

    @request_object.join # will send the request to server
    @response_object.join # will receive response from server
  end

  def send_request
    puts "Establish a connection..."
    begin
      Thread.new do
        loop do
          message = $stdin.gets.chomp
          @socket.puts message
        end
      end
    rescue IOError => e
      puts e.message
      # e.backtrace
      @socket.close
    end

  end

  def listen_response
    begin
      Thread.new do
        loop do
          response = @socket.gets.chomp
          puts "#{response}"
          if response.eql?'quit'
            @socket.close
          end
        end
      end
    rescue IOError => e
      puts e.message
      @socket.close
    end
  end
end



socket = TCPSocket.open( "localhost", 2000 )
Client.new( socket )