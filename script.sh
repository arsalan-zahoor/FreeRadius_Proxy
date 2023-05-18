source .env
echo -e $'client nas {\n       ipaddr          = 0.0.0.0/0\n       secret          = '$radius_client_secret' \n }' >> $(pwd)/Conf_Files/clients.conf
echo -e $'home_server remoteradius1 {\n    type = auth\n    ipaddr = '$remoteradius1'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server remoteradius2 {\n    type = auth\n    ipaddr = '$remoteradius2'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server remoteradius3 {\n    type = auth\n    ipaddr = '$remoteradius3'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server remoteradius4 {\n    type = auth\n    ipaddr = '$remoteradius4'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server remoteradius5 {\n    type = auth\n    ipaddr = '$remoteradius5'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server remoteradius6 {\n    type = auth\n    ipaddr = '$remoteradius6'\n    port = 1812\n    secret = '$remote_radius_secret'\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'home_server_pool remote_radius_failover {\n   type = fail-over\n   home_server = remoteradius1\n   home_server = remoteradius2\n   home_server = remoteradius3\n   home_server = remoteradius4\n   home_server = remoteradius5\n   home_server = remoteradius6\n }' >> $(pwd)/Conf_Files/proxy.conf
echo -e $'realm DEFAULT {\n        auth_pool = remote_radius_failover\n}' >> $(pwd)/Conf_Files/proxy.conf


docker run --name my-radius-1 -d -p 1812:1812/udp -p 1813:1813/udp -v $(pwd)/Conf_Files/clients.conf:/etc/raddb/clients.conf -v $(pwd)/Conf_Files/proxy.conf:/etc/raddb/proxy.conf freeradius/freeradius-server
