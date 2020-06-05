# Memcached-ruby-challenge
Memcached Ruby challenge for Moove-it workshop

# Guillermo Banchero

 Example: set tutorialspoint 0 900 9
 memcached
 STORED
 get tutorialspoint
 VALUE tutorialspoint 0 9
 Memcached
 END

# Retrieval commands to support:
#
 get
 gets
 Storage commands:

 set
 add
 replace
 append
 prepend
 cas
 
# Basic memcached planning for Ruby Workshop
  Application start => Charge Hash General (HG)
  TCP / IP Server Socket Instance (TCPServer.open (PORT))
  switch case [operation] => operation_logic => Modify HG
  Return message to customer
