# Camel AMQP+SSL application publishing messages in a AMQ Broker in Openshift

This shows how to connect a external application (outside Openshift) to an A-MQ xPaaS message broker inside Openshift.

Doc: https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html-single/red_hat_jboss_a-mq_for_openshift/

### Building

The example can be built with

    mvn clean install

After it you can exec the application using

    mvn spring-boot:run

### Running the example in OpenShift (oc cluster up)

### Openshift Setup

    oc cluster up
    
If a openshift running, run the setup.sh. It will deploy the AMQ in your Openshift instance in the `amq-demo` project. 

    openshift-setup/setup.sh

If you would like to generate your own certificates, you should use:

    openshift-setup/cert-setup.sh

