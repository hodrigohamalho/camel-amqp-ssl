# Camel AMQP+SSL application publishing messages in a AMQ Broker in Openshift 

This example shows how to connect an external application (outside Openshift) to an AMQ xPaaS message broker inside Openshift using the router via SSL/TLS.

The cool thing about this methodology is the capability to route the traffic to non HTTP ports (TCP) via HTTPS port. On this example I exposed the AMQP port.

Doc: https://access.redhat.com/documentation/en-us/red_hat_jboss_a-mq/6.3/html-single/red_hat_jboss_a-mq_for_openshift/

## Requirements

Openshift cluster up and running.

    mvn clean install

## Setup

### AMQ Setup

1. Generate certificates to use in the broker and the client application (this one)

    openshift-setup/certs-setup.sh

2. Deploy the AMQ Broker

    openshift-setup/setup.sh

3. Run the application to test

    mvn spring-boot:run

If everything works you should see the messages being produced and consumed in a AMQ queue.
    

