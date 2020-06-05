# frozen_string_literal: true

# Moove It Uruguay - Taller Ruby - Guillermo Banchero
# Planificación básica de memcached para Taller Ruby
# Inicio aplicacion => Cargo Hash General (HG)
# Instancio TCP/IP Server Socket (TCPServer.open(PORT))
# switch case [operacion] => logica_operacion => Modifica HG
# Retorno mensaje a cliente
#
#
# Example: set tutorialspoint 0 900 9
# memcached
# STORED
# get tutorialspoint
# VALUE tutorialspoint 0 9
# Memcached
# END

def save(arr, hash)
  key = arr[1]
  flags = arr[2]
  expire_time = arr[3].to_i

  bytes = arr[4]
  reply = arr.length == 7 ? arr[5] : true
  value = arr.length == 7 ? arr[6] : arr[5]
  exptime_ = Time.now + expire_time
  o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
  cas_unique = (0...8).map { o[rand(o.length)] }.join
  hash[key] = { flags: flags, exptime: exptime_.to_s, value: value, cas_unique: cas_unique }
  reply != 'false' ? (return "\r\nSTORED") : (return '')
end

require 'socket'
require './models/retrieval'
require './models/get'
require './models/gets'

server = TCPServer.open(2000)

# Hash general con datos de prueba
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
        client.puts Get.new(array, hash).to_s
      when 'gets'
        client.puts Gets.new(array, hash).to_s
      when 'set'

        key = array[1]
        client.puts save(array, hash)

      when 'add'

        key = array[1]
        if hash[key].nil?
          client.puts 'Key already stored'
          break
        end

        client.puts save(array, hash)

      when 'replace'

        key = array[1]
        if hash[key].nil?
          client.puts 'key not found'
          break
        end
        client.puts save(array, hash)

      when 'append'
        key = array[1]
        if hash[key].nil?
          client.puts 'NOT_STORED'
          break
        end
        flags = array[2]
        expire_time = array[3].to_i

        value = array.length == 7 ? array[6] : array[5]
        bytes = hash[key][:value].to_s.length + value.to_s.length
        reply = array.length == 7 ? array[5] : true
        exptime = Time.now + expire_time
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        cas_unique = (0...8).map { o[rand(o.length)] }.join
        hash[key] = {flags: hash[key][:flags] + flags, exptime: exptime.to_s, value: hash[key][:value] + value, cas_unique: cas_unique}
        reply != 'false' ? (client.puts "\r\nSTORED") : nil
      when 'prepend'
        key = array[1]
        if hash[key].nil?
          client.puts 'NOT_STORED'
          break
        end
        flags = array[2]
        expire_time = array[3].to_i

        bytes = hash[key][:value].to_s.length + value.to_s.length
        reply = array.length == 7 ? array[5] : true
        value = array.length == 7 ? array[6] : array[5]
        exptime = Time.now + expire_time
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        cas_unique = (0...8).map { o[rand(o.length)] }.join
        hash[key] = {flags: hash[key][:flags] + flags, exptime: exptime.to_s, value: +value + hash[key][:value], cas_unique: cas_unique}
        reply != 'false' ? (client.puts "\r\nSTORED") : nil
      when 'cas'
        # set key flags exptime bytes unique_cas_key [noreply] value

        key = array[1]

        if hash[key].nil?
          client.puts "\r\nNOT_FOUND"
          break
        end

        if hash[key][:cas_unique] != array[5]
          client.puts "\r\nEXISTS"
          break
        end

        flags = array[2]
        expire_time = array[3].to_i

        bytes = array[4]
        reply = array.length == 8 ? array[6] : true
        value = array.length == 8 ? array[7] : array[6]
        exptime_ = Time.now + expire_time
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        cas_unique = (0...8).map { o[rand(o.length)] }.join
        hash[key] = {flags: flags, exptime: exptime_.to_s, value: value, cas_unique: cas_unique}
        reply != 'false' ? (client.puts "\r\nSTORED") : (client.puts '')
      when 'quit'
        client.puts 'quit'
      else
        client.puts "You gave me #{response} -- I have no idea what to do with that."
      end # end case

    end # end while

  end # end thread
end # end loop

# Retrieval commands to support:
#
# get
# gets
# Storage commands:
#
# set
# add
# replace
# append
# prepend
# cas
