remote-python
=============

Project meant to help programming python app with remote interpreter. 

Contains:

1. python 3.4
1. oracle instantclient
1. postgresql

Usage
-----
### Oracle instantclient
For useing instantclient please download basik and sdk from OTN page and place them in **vagrant** subdirectory. Right now only 11.2.0.4.0 version supported.

### Ports forwarding
Container forwards some typical ports.

1. 15434 for postgresql
    1. user pguser
    1. password pgpassword
1. 6543 for typical pyramid port

Feel free to add or change port forwarding in *Vagrantfile*

