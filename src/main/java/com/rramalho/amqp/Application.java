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
import org.springframework.beans.factory.annotation.Value;
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
	
	@Value("${activemq.broker.url}")
	private String AMQ_BROKER_URL;
	
	@Value("${activemq.broker.username}")
	private String AMQ_BROKER_USERNAME;
	
	@Value("${activemq.broker.password}")
	private String AMQ_BROKER_PASSWORD;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@Bean
	AMQPConnectionDetails amqpConnection() {
		System.out.println("AMQ BROKER URL: "+AMQ_BROKER_URL);
		System.out.println("AMQ BROKER USERNAME: "+AMQ_BROKER_USERNAME);
		System.out.println("AMQ BROKER PASSWORD: "+AMQ_BROKER_PASSWORD);
		return new AMQPConnectionDetails(AMQ_BROKER_URL, AMQ_BROKER_USERNAME, AMQ_BROKER_PASSWORD);
	}

	// You could remove all parameters and pass it via environment variables https://qpid.apache.org/releases/qpid-jms-0.26.0/docs/index.html
	// mvn clean package spring-boot:run -Djavax.net.debug=ssl -Djavax.net.ssl.keyStore=/home/rramalho/workspace/amqp/src/main/resources/amq-client.ks -Djavax.net.ssl.keyStorePassword=redhat -Djavax.net.ssl.trustStore=/home/rramalho/workspace/amqp/src/main/resources/amq-client.ts -Dtransport.trustStorePassword=redhat
}
