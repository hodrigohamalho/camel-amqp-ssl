/**
 *  Copyright 2005-2016 Red Hat, Inc.
 *
 *  Red Hat licenses this file to you under the Apache License, version
 *  2.0 (the "License"); you may not use this file except in compliance
 *  with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 *  implied.  See the License for the specific language governing
 *  permissions and limitations under the License.
 */
package com.rramalho.amqp;

import org.apache.camel.component.amqp.AMQPConnectionDetails;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ImportResource;

/**
 * The Spring-boot main class.
 */
@SpringBootApplication
@ImportResource({"classpath:spring/camel-context.xml"})
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
    
    @Bean
    AMQPConnectionDetails amqpConnection() {
//    	ComponentConfiguration con = new AMQPComponent().createComponentConfiguration();
//    	con.setParameter("transport.keyStoreLocation", "certs/amq-client.ks");
//    	con.setParameter("transport.keyStorePassword", "redhat");
//    	con.setParameter("transport.trustStoreLocation", "certs/amq-client.ts");
//    	con.setParameter("transport.trustStorePassword", "redhat");
    	
    	return new AMQPConnectionDetails("amqp://amq-broker-amq-demo.127.0.0.1.nip.io:443?ssl=true&trust-store=certs/amq-client.ts&trust-store-password=redhat&key-store=amq-client.ks&key-store-password=redhat", "redhat", "redhat");
    }

}
