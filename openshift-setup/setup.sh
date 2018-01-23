# OPTIONAL STEP, login with a super user to create resources in openshift template, alternatively
# you could create in the project scope only with a normal user
oc login -u system:admin

# Create the imagestreams and templates, skip if you already have
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/ose-v1.4.5/jboss-image-streams.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-openshift/application-templates/ose-v1.4.5/amq/amq63-persistent-ssl.json -n openshift
oc create -f https://raw.githubusercontent.com/jboss-fuse/application-templates/master/fis-image-streams.json -n openshift

# Login with a normal user
oc login -u developer
# Adjust the project name
oc new-project amq-demo 
oc create serviceaccount amq-service-account
oc policy add-role-to-user view system:serviceaccount:amq-demo:amq-service-account
oc secrets new amq-app-secret amq-server.ks
oc secrets add sa/amq-service-account secret/amq-app-secret

# Create the broker using a openshift template
# Adjust the parameters with your own values
oc new-app --template=amq63-persistent-ssl  \
    --param AMQ_SPLIT=false                 \
    --param APPLICATION_NAME="amq-broker"   \
    --param MQ_PROTOCOL="openwire,amqp"     \
    --param MQ_USERNAME=redhat              \
    --param MQ_PASSWORD=redhat              \
    --param AMQ_SECRET="amq-app-secret"     \
    --param AMQ_TRUSTSTORE="amq-server.ks"  \
    --param AMQ_TRUSTSTORE_PASSWORD=redhat  \
    --param AMQ_KEYSTORE="amq-server.ks"    \
    --param AMQ_KEYSTORE_PASSWORD=redhat    \
    --param AMQ_STORAGE_USAGE_LIMIT=10gb    \
    --param IMAGE_STREAM_NAMESPACE=openshift

oc create route passthrough --service=amq-broker-amq-amqp-ssl