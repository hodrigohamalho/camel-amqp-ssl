BROKER_KEYSTORE_PASSWORD=redhat
CLIENT_KEYSTORE_PASSWORD=redhat

# Create a keystore for the broker SERVER
keytool \
	-genkey \
	-keyalg RSA \
	-alias amq-server \
    -dname "CN=amq.rramalho.com, OU=Solution Architect, O=Red Hat, L=Rio de Janeiro, ST=RJ, C=BR" \
	-keystore amq-server.ks \
	-storepass $BROKER_KEYSTORE_PASSWORD \
    -keypass $BROKER_KEYSTORE_PASSWORD


# Export the broker SERVER certificate from the keystore
keytool \
	-export \
	-alias amq-server \
	-keystore amq-server.ks \
	-storepass $CLIENT_KEYSTORE_PASSWORD \
	-file amq-server_cert

# Create the CLIENT keystore
keytool \
	-genkey \
	-keyalg RSA \
	-alias amq-client \
    -dname "CN=app.rramalho.com, OU=Solution Architect, O=Red Hat, L=Rio de Janeiro, ST=RJ, C=BR" \
	-keystore amq-client.ks \
	-storepass $CLIENT_KEYSTORE_PASSWORD \
    -keypass $CLIENT_KEYSTORE_PASSWORD

# Import the previous exported broker’s certificate into a CLIENT truststore
keytool \
	-import \
	-alias amq-server \
	-keystore amq-client.ts \
	-file amq-server_cert \
	-storepass $CLIENT_KEYSTORE_PASSWORD \
    -trustcacerts \
    -noprompt

# OPTIONAL steps...
# If you want to make trusted also the client, you must export the client’s certificate from the keystore
# keytool -export -alias amq-client -keystore amq-client.ks -file amq-client_cert
# Import the client’s exported certificate into a broker SERVER truststore
# keytool -import -alias amq-client -keystore amq-server.ts -file amq-client_cert

# A good tool to know to list the contents of the key
#keytool -list -keystore amq-server.ks