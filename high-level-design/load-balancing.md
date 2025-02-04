## Key terminology
### Load Balancer
A device or software that distributes network traffic across multiple servers based on predefined load balancing algorithms.

![load balancing](/assets/images/load-balancing.png)

We can add LBs at three places:
![](/assets/images/load-balancer-multi.png)

The main goal of load balancing is to ensure efficient utilization of available resources, improve overall system performance, and maintain high availability and reliability by avoiding overloading a single server and avoiding downtime.
### Backend Servers 
The servers that receive and process requests forwarded by the load balancer/client. Also referred to as the server pool or server farm.
### Load Balancing Algorithm
The rules or set of instructions used by the load balancer to determine how to distribute incoming traffic among the backend servers.
### Health Checks
Periodic tests performed to determine the availability and performance of backend servers.
### Session Persistence
A technique used to ensure that subsequent requests from the same client are directed to the same backend server, maintaining session state and providing a consistent user experience.
### SSL/TLS Termination
The process of decrypting SSL/TLS-encrypted traffic at the load balancer level, offloading the decryption burden from backend servers and allowing for centralized SSL/TLS management.
### Homogenous system
A system in which all the backend servers have the same capacity and performance.
### Stateful system
A system knows the past states of the users.

## How Load Balancer works?
Here are the general steps that a load balancer follows to distribute traffic:

1. The load balancer receives a request from a client or user.
2. The load balancer evaluates the incoming request and determines which server or resource should handle the request. This is done based on a predefined load-balancing algorithm that takes into account factors such as server capacity, server response time, number of active connections, and geographic location.
3. The load balancer forwards the incoming traffic to the selected server or resource.
4. The server or resource processes the request and sends a response back to the load balancer.
5. The load balancer receives the response from the server or resource and sends it to the client or user who made the request.

## Load balancing algorithms
load balancing algorithms can optimize response times, maximize throughput, and enhance user experience. by considering factors such as server capacity, active connections, response times, and server health, among others.
### Round robin
This algorithm distributes incoming requests to servers in a cyclic order.

* Easy to Implement, work best for homogenous and stateless environments.
* No load awareness, No Session persistence, Performance issues if servers have varied capacity and performance, Predictable distribution pattern which could potentially be exploited by attackers who can observe traffic patterns 

### Least connection
The Least Connections algorithm is a dynamic load balancing technique that assigns incoming requests to the server with the fewest active connections at the time of the request.

* aware about the current load, so it is best for stateful, heterogeneous environments with dynamic traffic patterns.
* high Complexity to implement due to real time monitoring of active connections, state maintenance increases over head, Potential for Connection Spikes: In scenarios where connection duration is short, servers can experience rapid spikes in connection counts, leading to frequent rebalancing.

### Weighted Round Robin(WRR)
 It assigns weights to each server based on their capacity or performance, distributing incoming requests proportionally according to these weights. This ensures that more powerful servers handle a larger share of the load, while less powerful servers handle a smaller share.

 * Improved version of round robin and can be good for heterogeneous environments.
 * complexity in weight assignment, increase overhead for maintainig and assigning the weights if servers have varying capacity/performance, Not good for highly variable loads because do not consider real time server load.

 ### Weighed Least Connection
 It takes into account both the current load (number of active connections) on each server and the relative capacity of each server (weight). This approach ensures that more powerful servers handle a proportionally larger share of the load, while also dynamically adjusting to the real-time load on each server.

 will all the Qualities of least connections it is now capacity aware leading to better utilization of resources.

 ### IP Hash 
 IP Hash load balancing is a technique that assigns client requests to servers based on the client's IP address. The load balancer uses a hash function to convert the client's IP address into a hash value, which is then used to determine which server should handle the request. This method ensures that requests from the same client IP address are consistently routed to the same server, providing session persistence

 * State persistence, simple to implement, no overhead on load balancer to maintain the server metrics so best for stateful and geographically distributed clients.
 * could cause uneven distribution, can not adhere to dynamically changing number of servers, lack of capacity awareness and load awareness

 ### Least Response Time
 This approach aims to direct traffic to the server that can handle the request the fastest, based on recent performance metrics of the server.
 Pros
Optimized Performance: Ensures that requests are handled by the fastest available server, leading to reduced latency and improved client experience.
Dynamic Load Balancing: Continuously adjusts to changing server performance, ensuring optimal distribution of load.
Effective Resource Utilization: Helps in better utilization of server resources by directing traffic to servers that can respond quickly.
Cons
Complexity: More complex to implement compared to simpler algorithms like Round Robin, as it requires continuous monitoring of server performance.
Overhead: Monitoring response times and dynamically adjusting the load can introduce additional overhead.
Short-Term Variability: Response times can vary in the short term due to network fluctuations or transient server issues, potentially causing frequent rebalancing.
Use Cases
Real-Time Applications: Ideal for applications where low latency and fast response times are critical, such as online gaming, video streaming, or financial trading platforms.
Web Services: Useful for web services and APIs that need to provide quick responses to user requests.
Dynamic Environments: Suitable for environments with fluctuating loads and varying server performance.

### Random
Random load balancing is a simple algorithm that distributes incoming requests to servers randomly. Over time, if the randomness is uniform, each server should receive approximately the same number of requests. 

* it is very simple to implement and good for systems where load and capacity is uniform and system is stateless.
* not load awareness, potential to load imbalance, Security systems that rely on detecting anomalies (e.g., to mitigate DDoS attacks) might find it slightly more challenging to identify malicious patterns if a Random algorithm is used, due to the inherent unpredictability in request distribution. This could potentially dilute the visibility of attack patterns.

### Least Bandwidth
The Least Bandwidth load balancing algorithm distributes incoming requests to servers based on the current bandwidth usage. It routes each new request to the server that is consuming the least amount of bandwidth at the time. This approach helps in balancing the network load more efficiently by ensuring that no single server gets overwhelmed with too much data traffic.
Pros
Dynamic Load Balancing: Continuously adjusts to the current network load, ensuring optimal distribution of traffic.
Prevents Overloading: Helps in preventing any single server from being overwhelmed with too much data traffic, leading to better performance and stability.
Efficient Resource Utilization: Ensures that all servers are utilized more effectively by balancing the bandwidth usage.
Cons
Complexity: More complex to implement compared to simpler algorithms like Round Robin, as it requires continuous monitoring of bandwidth usage.
Overhead: Monitoring bandwidth and dynamically adjusting the load can introduce additional overhead.
Short-Term Variability: Bandwidth usage can fluctuate in the short term, potentially causing frequent rebalancing.
Use Cases
High Bandwidth Applications: Ideal for applications with high bandwidth usage, such as video streaming, file downloads, and large data transfers.
Content Delivery Networks (CDNs): Useful for CDNs that need to balance traffic efficiently to deliver content quickly.
Real-Time Applications: Suitable for real-time applications where maintaining low latency is critical.

### Custom Load
Custom Load load balancing is a flexible and highly configurable approach that allows you to define your own metrics and rules for distributing incoming traffic across a pool of servers. Unlike standard load balancing algorithms that use predefined criteria such as connection count or response time, Custom Load load balancing enables you to tailor the distribution strategy based on specific requirements and conditions unique to your application or infrastructure.

How Custom Load Load Balancing Works
Define Custom Metrics: Determine the metrics that best represent the load or performance characteristics relevant to your application. These metrics can include CPU usage, memory usage, disk I/O, application-specific metrics, or a combination of several metrics.

Implement Monitoring: Continuously monitor the defined metrics on each server in the pool. This may involve integrating with monitoring tools or custom scripts that collect and report the necessary data.

Create Load Balancing Rules: Establish rules and algorithms that use the monitored metrics to make load balancing decisions. This can be a simple weighted sum of metrics or more complex logic that prioritizes certain metrics over others.

Dynamic Adjustment: Use the collected data and rules to dynamically adjust the distribution of incoming requests, ensuring that the traffic is balanced according to the custom load criteria.

Pros
Flexibility: Allows for highly customized load balancing strategies tailored to the specific needs and performance characteristics of your application.
Optimized Resource Utilization: Can lead to more efficient use of server resources by considering a comprehensive set of metrics.
Adaptability: Easily adaptable to changing conditions and requirements, making it suitable for complex and dynamic environments.
Cons
Complexity: More complex to implement and configure compared to standard load balancing algorithms.
Monitoring Overhead: Requires continuous monitoring of multiple metrics, which can introduce additional overhead.
Potential for Misconfiguration: Incorrectly defined metrics or rules can lead to suboptimal load balancing and performance issues.
Use Cases
Complex Applications: Ideal for applications with complex performance characteristics and varying resource requirements.
Highly Dynamic Environments: Suitable for environments where workloads and server performance can change rapidly and unpredictably.
Custom Requirements: Useful when standard load balancing algorithms do not meet the specific needs of the application.

## Uses of Load Balancing
### Improving website performance
Load balancing can distribute incoming web traffic among multiple servers, reducing the load on individual servers and ensuring faster response times for end users.
### Ensuring high availability and reliability
By distributing the workload among multiple servers, load balancing helps prevent single points of failure. If one server fails or experiences an issue, the load balancer can redirect traffic to other available servers, maintaining uptime and minimizing service disruptions
### Scalability
Load balancing allows organizations to easily scale their infrastructure as traffic and demand increase. Additional servers can be added to the load balancing pool to accommodate increased demand, without the need for significant infrastructure changes.
### Redundancy
Load balancing can be used to maintain redundant copies of data and services across multiple servers, reducing the risk of data loss or service outages due to hardware failure or other issues.
and  users can still access their data from the redundant copies stored on other servers
### Network optimization
Load balancing can help optimize network traffic by distributing it across multiple paths or links, reducing congestion and improving overall network performance.
### Geographic distribution
For global organizations, load balancing can be used to distribute traffic across data centers in different geographic locations. This ensures that users are directed to the nearest or best-performing data center, reducing latency and improving user experience.
### Application performance
Load balancing can be used to distribute requests for specific applications or services among dedicated servers or resources, ensuring that each application or service receives the necessary resources to perform optimally.
### Security
Load balancers can help protect against distributed denial-of-service (DDoS) attacks by distributing incoming traffic across multiple servers, making it more difficult for attackers to overwhelm a single target.
### Cost savings
By distributing workloads across available resources more efficiently, load balancing can help organizations save money on hardware and infrastructure costs, as well as reduce energy consumption.
### Content caching
Some load balancers can cache static content, such as images and videos. This cached content is then served directly from the load balancer, reducing the demand on the servers and providing faster response times for users.

## Load Balancer Types
understanding the different load balancing types and their characteristics, you can select the most appropriate solution for your specific needs and infrastructure.
### Hardware Load Balancing
Hardware load balancers are physical devices designed specifically for load balancing tasks. They use specialized hardware components, such as Application-Specific Integrated Circuits (ASICs) or Field-Programmable Gate Arrays (FPGAs), to efficiently distribute network traffic.

Pros:

High performance and throughput, as they are optimized for load balancing tasks.
Often include built-in features for network security, monitoring, and management.
Can handle large volumes of traffic and multiple protocols.

Cons:

Can be expensive, especially for high-performance models.
May require specialized knowledge to configure and maintain.
Limited scalability, as adding capacity may require purchasing additional hardware.
Example: A large e-commerce company uses a hardware load balancer to distribute incoming web traffic among multiple web servers, ensuring fast response times and a smooth shopping experience for customers.

### Software Load Balancing
Software load balancers are applications that run on general-purpose servers or virtual machines. They use software algorithms to distribute incoming traffic among multiple servers or resources.

Pros:

Generally more affordable than hardware load balancers.
Can be easily scaled by adding more resources or upgrading the underlying hardware.
Provides flexibility, as they can be deployed on a variety of platforms and environments, including cloud-based infrastructure.

Cons:

May have lower performance compared to hardware load balancers, especially under heavy loads.
Can consume resources on the host system, potentially affecting other applications or services.
May require ongoing software updates and maintenance.
Example: A startup with a growing user base deploys a software load balancer on a cloud-based virtual machine, distributing incoming requests among multiple application servers to handle increased traffic.

### Cloud-based Load Balancing
Cloud-based load balancers are provided as a service by cloud providers. They offer load balancing capabilities as part of their infrastructure, allowing users to easily distribute traffic among resources within the cloud environment.

Pros:

Highly scalable, as they can easily accommodate changes in traffic and resource demands.
Simplified management, as the cloud provider takes care of maintenance, updates, and security.
Can be more cost-effective, as users only pay for the resources they use.

Cons:

Reliance on the cloud provider for performance, reliability, and security.
May have less control over configuration and customization compared to self-managed solutions.
Potential vendor lock-in, as switching to another cloud provider or platform may require significant changes.
Example: A mobile app developer uses a cloud-based load balancer provided by their cloud provider to distribute incoming API requests among multiple backend servers, ensuring smooth app performance and quick response times.

### DNS Load Balancing
DNS (Domain Name System) load balancing relies on the DNS infrastructure to distribute incoming traffic among multiple servers or resources. It works by resolving a domain name to multiple IP addresses, effectively directing clients to different servers based on various policies.

Pros:

Relatively simple to implement, as it doesn't require specialized hardware or software.
Provides basic load balancing and failover capabilities.
Can distribute traffic across geographically distributed servers, improving performance for users in different regions.

Cons:

Limited to DNS resolution time, which can be slow to update when compared to other load balancing techniques.
No consideration for server health, response time, or resource utilization.
May not be suitable for applications requiring session persistence or fine-grained load distribution.
Example: A content delivery network (CDN) uses DNS load balancing to direct users to the closest edge server based on their geographical location, ensuring faster content delivery and reduced latency.

### Global Server Load Balancing (GSLB)
Global Server Load Balancing (GSLB) is a technique used to distribute traffic across geographically dispersed data centers. It combines DNS load balancing with health checks and other advanced features to provide a more intelligent and efficient traffic distribution method.

Pros:

Provides load balancing and failover capabilities across multiple data centers or geographic locations.
Can improve performance and reduce latency for users by directing them to the closest or best-performing data center.
Supports advanced features, such as server health checks, session persistence, and custom routing policies.

Cons:

Can be more complex to set up and manage than other load balancing techniques.
May require specialized hardware or software, increasing costs.
Can be subject to the limitations of DNS, such as slow updates and caching issues.
Example: A multinational corporation uses GSLB to distribute incoming requests for its web applications among several data centers around the world, ensuring high availability and optimal performance for users in different regions.

### Hybrid Load Balancing
Hybrid load balancing combines the features and capabilities of multiple load balancing techniques to achieve the best possible performance, scalability, and reliability. It typically involves a mix of hardware, software, and cloud-based solutions to provide the most effective and flexible load balancing strategy for a given scenario.

Pros:

Offers a high degree of flexibility, as it can be tailored to specific requirements and infrastructure.
Can provide the best combination of performance, scalability, and reliability by leveraging the strengths of different load balancing techniques.
Allows organizations to adapt and evolve their load balancing strategy as their needs change over time.

Cons:

Can be more complex to set up, configure, and manage than single-technique solutions.
May require a higher level of expertise and understanding of multiple load balancing techniques.
Potentially higher costs, as it may involve a combination of hardware, software, and cloud-based services.
Example: A large-scale online streaming platform uses a hybrid load balancing strategy, combining hardware load balancers in their data centers for high-performance traffic distribution, cloud-based load balancers for scalable content delivery, and DNS load balancing for global traffic management. This approach ensures optimal performance, scalability, and reliability for their millions of users worldwide.

### Layer 4 Load Balancing
Layer 4 load balancing, also known as transport layer load balancing, operates at the transport layer of the OSI model (the fourth layer). It distributes incoming traffic based on information from the TCP or UDP header, such as source and destination IP addresses and port numbers.

Pros:

Fast and efficient, as it makes decisions based on limited information from the transport layer.
Can handle a wide variety of protocols and traffic types.
Relatively simple to implement and manage.

Cons:

Lacks awareness of application-level information, which may limit its effectiveness in some scenarios.
No consideration for server health, response time, or resource utilization.
May not be suitable for applications requiring session persistence or fine-grained load distribution.
Example: An online gaming platform uses Layer 4 load balancing to distribute game server traffic based on IP addresses and port numbers, ensuring that players are evenly distributed among available game servers for smooth gameplay.

### Layer 7 Load Balancing
Layer 7 load balancing, also known as application layer load balancing, operates at the application layer of the OSI model (the seventh layer). It takes into account application-specific information, such as HTTP headers, cookies, and URL paths, to make more informed decisions about how to distribute incoming traffic.

Pros:

Provides more intelligent and fine-grained load balancing, as it considers application-level information.
Can support advanced features, such as session persistence, content-based routing, and SSL offloading.
Can be tailored to specific application requirements and protocols.

Cons:

Can be slower and more resource-intensive compared to Layer 4 load balancing, as it requires deeper inspection of incoming traffic.
May require specialized software or hardware to handle application-level traffic inspection and processing.
Potentially more complex to set up and manage compared to other load balancing techniques.
Example: A web application with multiple microservices uses Layer 7 load balancing to route incoming API requests based on the URL path, ensuring that each microservice receives only the requests it is responsible for handling.

## Stateless vs Stateful load balancing
### Stateless Load Balancing
Stateless load balancers operate without maintaining any information about the clients' session or connection state. they can quickly and efficiently distribute incoming traffic without considering the clients' history or past interactions with the application.
### Stateful Load Balancing
It preserves session information between requests. The load balancer assigns a client to a specific server and ensures that all subsequent requests from the same client are directed to that server.

Stateful load balancing can be further categorized into two types:

1. Source IP Affinity: This form of stateful load balancing assigns a client to a specific server based on the client's IP address. While this approach ensures that requests from the same client consistently reach the same server, it may pose issues if the client's IP address frequently changes, such as in mobile networks.

2. Session Affinity: In this type of stateful load balancing, the load balancer allocates a client to a specific server based on a session identifier, such as a cookie or URL parameter. This method ensures that requests from the same client consistently reach the same server, regardless of the client's IP address.

## aspect of High availability and fault taularence
### Redundancy and failover strategies for load balancers
To ensure high availability and fault tolerance, load balancers should be designed and deployed with redundancy in mind. This means having multiple instances of load balancers that can take over if one fails. Redundancy can be achieved through several failover strategies:

Active-passive configuration: In this setup, one load balancer (the active instance) handles all incoming traffic while the other (the passive instance) remains on standby. If the active load balancer fails, the passive instance takes over and starts processing requests. This configuration provides a simple and reliable failover mechanism but does not utilize the resources of the passive instance during normal operation.

Active-active configuration: In this setup, multiple load balancer instances actively process incoming traffic simultaneously. Traffic is distributed among the instances using methods such as DNS load balancing or an additional load balancer layer. If one instance fails, the others continue to process traffic with minimal disruption. This configuration provides better resource utilization and increased fault tolerance compared to the active-passive setup.

### Health checks and monitoring
Effective health checks and monitoring are essential components of high availability and fault tolerance for load balancers. Health checks are periodic tests performed by the load balancer to determine the availability and performance of backend servers. By monitoring the health of backend servers, load balancers can automatically remove unhealthy servers from the server pool and avoid sending traffic to them, ensuring a better user experience and preventing cascading failures.

Monitoring the load balancer itself is also crucial. By keeping track of performance metrics, such as response times, error rates, and resource utilization, we can detect potential issues and take corrective action before they lead to failures or service degradation.

In addition to regular health checks and monitoring, it is essential to have proper alerting and incident response procedures in place. This ensures that the appropriate personnel are notified of any issues and can take action to resolve them quickly.

### Synchronization and State Sharing
In active-active and active-passive configurations, it is crucial to ensure that the load balancer instances maintain a consistent view of the system's state, including the status of backend servers, session data, and other configuration settings. This can be achieved through various mechanisms, such as:

Centralized configuration management: Using a centralized configuration store (e.g., etcd, Consul, or ZooKeeper) to maintain and distribute configuration data among load balancer instances ensures that all instances are using the same settings and are aware of changes.

State sharing and replication: In scenarios where load balancers must maintain session data or other state information, it is crucial to ensure that this data is synchronized and replicated across instances. This can be achieved through database replication, distributed caching systems (e.g., Redis or Memcached), or built-in state-sharing mechanisms provided by the load balancer software or hardware.

By addressing these aspects of high availability and fault tolerance, we can design and deploy load balancers that provide reliable, consistent service even in the face of failures or other issues.
## scalability and Performance
### Horizontal and vertical scaling of load balancers
As traffic to an application increases, it is essential to ensure that the load balancer can handle the increased demand. There are two primary methods for scaling load balancers:

1. Horizontal scaling: This involves adding more load balancer instances to distribute traffic among them. Horizontal scaling is particularly effective for active-active configurations, where each load balancer instance actively processes traffic. Horizontal scaling can be achieved using DNS load balancing or by implementing an additional load balancer layer to distribute traffic among the instances.

2. Vertical scaling: This involves increasing the resources (e.g., CPU, memory, and network capacity) of the existing load balancer instance(s) to handle increased traffic. Vertical scaling is often limited by the maximum capacity of a single instance, which is why horizontal scaling is typically preferred for large-scale applications.

### Connection and request rate limits
Managing the number of connections and request rates is crucial for optimizing the performance of load balancers. Overloading a load balancer or backend servers can result in decreased performance or even service outages. Implementing rate limiting and connection limits at the load balancer level can help prevent overloading and ensure consistent performance.

Load balancers can enforce rate limits based on various criteria, such as IP addresses, client domains, or URL patterns. Implementing these limits can also help mitigate the impact of Denial of Service (DoS) attacks and prevent individual clients from monopolizing resources.

### Caching and content optimization
Caching and content optimization can significantly improve the performance of load-balanced applications. Load balancers can cache static content, such as images, CSS, and JavaScript files, to reduce the load on backend servers and improve response times. Additionally, some load balancers support content optimization features like compression or minification, which can further improve performance and reduce bandwidth consumption.

### Impact of load balancers on latency
Introducing a load balancer into the request-response path adds an additional network hop, which can result in increased latency. While the impact is typically minimal, it is important to consider the potential latency introduced by the load balancer and optimize its performance accordingly.

Optimizing the performance of the load balancer can be achieved through various strategies, including:

* Geographical distribution: Deploying load balancers and backend servers in geographically distributed locations can help reduce latency for users by ensuring that their requests are processed by a nearby instance.

* Connection reuse: Many load balancers support connection reuse or keep-alive connections, which reduce the overhead of establishing new connections between the load balancer and backend servers for each request.

* Protocol optimizations: Some load balancers support protocol optimizations, such as HTTP/2 or QUIC, which can improve performance by reducing latency and increasing throughput.

By focusing on these aspects of scalability and performance, you can ensure that your load balancer can handle increased traffic and provide consistent, fast service for your application's users.

## Challenges of load balancers
Load balancers play a crucial role in distributing traffic and optimizing resource utilization in modern applications. However, they are not without potential challenges or problems. Some common issues associated with load balancers include:

### Single Point of Failure
If not designed with redundancy and fault tolerance in mind, a load balancer can become a single point of failure in the system. If the load balancer experiences an outage, it could impact the entire application.

### Configuration Complexity
Load balancers often come with a wide range of configuration options, including algorithms, timeouts, and health checks. Misconfigurations can lead to poor performance, uneven traffic distribution, or even service outages.

### Scalability Limitations
As traffic increases, the load balancer itself might become a performance bottleneck, especially if it is not configured to scale horizontally or vertically.

### Latency
Introducing a load balancer into the request-response path adds an additional network hop, which could lead to increased latency. While the impact is typically minimal, it is essential to consider the potential latency introduced by the load balancer and optimize its performance accordingly.

### Sticky Sessions
Some applications rely on maintaining session state or user context between requests. In such cases, load balancers must be configured to use session persistence or "sticky sessions" to ensure subsequent requests from the same user are directed to the same backend server. However, this can lead to uneven load distribution and negate some of the benefits of load balancing.

### Cost
Deploying and managing load balancers, especially in high-traffic scenarios, can add to the overall cost of your infrastructure. This may include hardware or software licensing costs, as well as fees associated with managed load balancing services provided by cloud providers.

### Health Checks and Monitoring
Implementing effective health checks for backend servers is essential to ensure that the load balancer accurately directs traffic to healthy instances. Misconfigured or insufficient health checks can lead to the load balancer sending traffic to failed or underperforming servers, resulting in a poor user experience.
