# frozen_string_literal: true

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
    puts 'Establish a connection...'
    begin
      Thread.new do
        loop do
          message = $stdin.gets.chomp
          message == 'quit' ? @socket.close : nil
          @socket.puts message
        end
      end
    end
  end

  def listen_response
    Thread.new do
      loop do
        response = @socket.gets.chomp
        puts response.to_s
        @socket.close if response.eql? 'quit'
      end
    end
  end
end

socket = TCPSocket.open('localhost', 2000)
Client.new(socket)
