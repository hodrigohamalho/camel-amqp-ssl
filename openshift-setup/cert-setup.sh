BROKER_KEYSTORE_PASSWORD=redhat
BROKER_TRUSTSTORE_PASSWORD=redhat
CLIENT_KEYSTORE_PASSWORD=redhat

# Create client keystore (optional - if you alredy have certificate for the client, proceed to step 4)

keytool \
	-genkey \
	-keyalg RSA \
	-alias amq-client \
	-keystore amq-client.ks \
	-storepass $CLIENT_KEYSTORE_PASSWORD \
	-keypass $CLIENT_KEYSTORE_PASSWORD

# Create client certificate (optional - if you alredy have certificate for the client, proceed to step 4)

keytool \
	-export \
	-alias amq-client \
	-keystore amq-client.ks \
	-storepass $CLIENT_KEYSTORE_PASSWORD \
	-file amq-client.cert

# Create broker keystore

keytool \
	-genkey \
	-keyalg RSA \
	-alias amq-broker \
	-keystore amq-broker.ks \
	-storepass $BROKER_KEYSTORE_PASSWORD \
    -keypass $BROKER_KEYSTORE_PASSWORD

# Create broker truststore from client certificate
keytool \
	-import \
	-alias amq-broker \
	-keystore amq-broker.ts \
	-file amq-client.cert \
	-storepass $BROKER_TRUSTSTORE_PASSWORD \
    -trustcacerts \
    -noprompt

# Create broker certificate so that it can be shared with clients
keytool -export -alias amq-broker -keystore amq-broker.ks -file broker.cert

# Create a client trustStore that imports the broker certificate:
keytool -import -alias amq-broker -keystore amq-client.ts -file broker.cert

#Now, you can use files `amq-broker.ks` and `amq-broker.ts` in OpenShift secret definition. 
#Leave the files `amq-client.ks` and `amq-client.cert` be as they are not needed by the broker. 
#Also, when creating A-MQ application, set the template parameters as: +

#AMQ_KEYSTORE=amq-broker.ks +
#AMQ_KEYSTORE_PASSWORD=<password for broker keystore> +
#AMQ_TRUSTSTORE=amq-broker.ts +
#AMQ_TRUSTSTORE_PASSWORD=<password for broker truststore> +

