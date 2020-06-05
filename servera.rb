
require 'socket'
require './models/retrieval'
require './models/storage'
require './models/retrieval_commands/get'
require './models/retrieval_commands/gets'
require './models/storage_commands/set'
require './models/storage_commands/add'
require './models/storage_commands/replace'
require './models/storage_commands/append'
require './models/storage_commands/prepend'
require './models/storage_commands/cas'

server = TCPServer.open(2000)

# General Hash with test data
hash = { 'datos' => { flags: '0', exptime: '2020-07-01T00:04:00+00:00', value: 'valor_de_prueba', cas_unique: 'aFwamHvj' },
         'de' => { flags: '0', exptime: '2020-07-01T00:04:00+00:00', value: 'valor_de_prueba_2', cas_unique: 'fhRyDbne' },
         'prueba' => { flags: '0', exptime: '2020-07-01T00:04:00+00:00', value: 'valor_de_prueba_3', cas_unique: 'wuRbsjWk' } }

loop do
  Thread.start(server.accept) do |client|
    while (response = client.gets) # read data send by clients

      text = response.chomp
      array = text.split(' ')
      command = array[0]

      case command
      when 'get'
        client.puts Get.new(array, hash)
      when 'gets'
        client.puts Gets.new(array, hash)
      when 'set'
        client.puts Set.new(array, hash)
      when 'add'
        client.puts Add.new(array, hash)
      when 'replace'
        client.puts Replace.new(array, hash)
      when 'append'
        client.puts Append.new(array, hash)
      when 'prepend'
        client.puts Prepend.new(array, hash)
      when 'cas'
        # set key flags exptime bytes unique_cas_key [noreply] value
        client.puts Cas.new(array, hash)
      when 'quit'
        client.puts 'quit'
      else
        client.puts "You gave me #{response} -- I have no idea what to do with that."
      end # end case

    end # end while

  end # end thread
end # end loop
