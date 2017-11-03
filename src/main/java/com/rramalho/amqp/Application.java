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
		return new AMQPConnectionDetails("amqps://amqp-ssl-amq-demo.127.0.0.1.nip.io:443?transport.trustStoreLocation=/home/rramalho/workspace/amqp/src/main/resources/certs/amq-client.ts&transport.trustStorePassword=redhat&transport.verifyHost=false", "redhat", "redhat");
	}

	
	// mvn clean package spring-boot:run -Djavax.net.debug=ssl -Djavax.net.ssl.keyStore=/home/rramalho/workspace/amqp/src/main/resources/amq-client.ks -Djavax.net.ssl.keyStorePassword=redhat -Djavax.net.ssl.trustStore=/home/rramalho/workspace/amqp/src/main/resources/amq-client.ts -Dtransport.trustStorePassword=redhat
}
