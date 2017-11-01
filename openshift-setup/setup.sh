oc login -u system:admin
oc adm policy add-cluster-role-to-user cluster-admin admin
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/jboss-image-streams.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/master/amq/amq63-persistent-ssl.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-fuse/application-templates/master/fis-image-streams.json -n openshift

oc login -u developer
oc new-project amq-demo 
oc create serviceaccount amq-service-account
oc policy add-role-to-user view system:serviceaccount:amq-demo:amq-service-account
oc secrets new amq-app-secret amq-broker.ks amq-broker.ts
oc secrets add sa/amq-service-account secret/amq-app-secret

# Create the broker
oc new-app --template=amq63-persistent-ssl --param APPLICATION_NAME="amq-broker" --param AMQ_SPLIT=true --param MQ_PROTOCOL="openwire,amqp" --param MQ_USERNAME=redhat --param MQ_PASSWORD=redhat --param AMQ_SECRET="amq-app-secret" --param AMQ_TRUSTSTORE="amq-broker.ts" --param AMQ_TRUSTSTORE_PASSWORD=redhat --param AMQ_KEYSTORE="amq-broker.ks" --param AMQ_KEYSTORE_PASSWORD=redhat --param AMQ_STORAGE_USAGE_LIMIT=10gb --param IMAGE_STREAM_NAMESPACE=openshift
