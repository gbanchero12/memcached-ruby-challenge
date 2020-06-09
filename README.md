# Memcached-ruby-challenge
Memcached Ruby challenge for Moove-it workshop
 
 # How to run the application:
 
 1. Run servera.rb 
 2. Run client.rb
 3. Text the method to run in the client console
 4. Will see the result in the client console
 
 # Supported commands: 
 
 GET GETS SET ADD REPLACE APPEND PREPEND CAS
            
 # Basic syntax  supported: 
           get [key] => [VALUE] 
           gets [key] => [CAS_UNIQUE_KEY]
           set [key] [flags ] [exptime] [bytes] [noreply]* [value]
           add [key] [flags ] [exptime] [bytes] [noreply]* [value]
           replace [key] [flags ] [exptime] [bytes] [noreply]* [value]
           append [key] [flags ] [exptime] [bytes] [noreply]* [value_to_append]
           prepend [key] [flags ] [exptime] [bytes] [noreply]* [value_to_prepend]
           cas [key] [flags ] [exptime] [bytes] [unique_cas_key ] [noreply]* [value]
           
           *optional
# Output types:

STORED indicates success.

ERROR indicates error while saving data or wrong syntax.

EXISTS indicates that someone has modified the CAS data since last fetch.

NOT_FOUND indicates that the key does not exist in the Memcached server.



# Bibliography

https://ruby-doc.org/stdlib-2.5.3/libdoc/socket/rdoc/Socket.html
https://www.tutorialspoint.com/memcached/memcached_cas.html
https://code.likeagirl.io/socket-programming-in-ruby-f714131336fd

# Basic memcached planning for Ruby Workshop

  Application start => Charge Hash General (HG)
  TCP / IP Server Socket Instance (TCPServer.open (PORT))
  switch case [operation] => operation_logic => Modify HG
  Return message to customer
  
  
# Guillermo Banchero