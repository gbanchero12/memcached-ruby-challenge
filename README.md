# Memcached-ruby-challenge
Memcached Ruby challenge for Moove-it workshop

# Moove It Uruguay - Taller Ruby - Guillermo Banchero

# Planificación básica de memcached para Taller Ruby
 Inicio aplicacion => Cargo Hash General (HG)
 Instancio TCP/IP Server Socket (TCPServer.open(PORT))
 switch case [operacion] => logica_operacion => Modifica HG
 Retorno mensaje a cliente


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
