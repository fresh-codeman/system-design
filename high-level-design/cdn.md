
# Content Delivery Network
## test yourself
1. define CDN, PoP, edge server, origin server, cache warming, TTL, any cast, content invalidation, cache purging.
2. benefits of CDN, origin server vs edge server, 
A Content Delivery Network (CDN) is a distributed network of servers strategically located across various geographical locations to deliver web content, such as images, videos, and other static assets, more efficiently to users.
## Intro to CDN
### How CDNs work?
![cdn](/assets/images/cdn.png)

### Key terminology and concepts
1. Point of Presence (PoP): A PoP is a physical location where CDN servers are deployed, PoPs are strategically placed close to end-users.
2. Edge Server: An edge server is a CDN server located at a PoP, responsible for caching and delivering content to end-users.
3. Origin Server: The origin server is the primary server where the original content is stored. 
4. Cache Warming: process of preloading content into the edge server's cache before it is requested by users.
5. Time to Live (TTL) :TTL is a value set by the origin server that determines how long a piece of content should be stored in the cache before it is considered stale.
6. Anycast: Anycast is a network routing technique used by CDNs to direct user requests to the nearest available edge server, based on the lowest latency or the shortest network path.
7. Content Invalidation: The process of marking cached content as stale when the original content on the origin server changes, new content updates automatically.
8. Cache Purging: The process of forcibly removing content from the edge server's cache, manually or automatically based on condition.
9. Cache Control Headers: Cache control headers are used by the origin server to provide instructions to the CDN regarding caching behavior. These headers can dictate the cacheability of content, its TTL, and other caching-related settings.
10. CDN Prefetching: CDN Prefetching proactively loads and caches content before a user requests it. This improves first-time load speeds by reducing origin fetches.

### Benefits of using a CDN
1. Reduced latency: By serving content from geographically distributed edge servers.
2. Improved performance: CDNs can offload static content delivery from the origin server.
3. Enhanced reliability and availability: With multiple edge servers in different locations, CDNs can provide built-in redundancy and fault tolerance. If one server becomes unavailable, requests can be automatically rerouted to another server, ensuring continuous content delivery.
4. Scalability: CDNs can handle sudden traffic spikes and large volumes of concurrent requests.
5. Security: Many CDNs offer additional security features, such as DDoS protection, Web Application Firewalls (WAF), and SSL/TLS termination at the edge, helping to safeguard web applications from various security threats.
## origin server vs edge server
### Origin Server Characteristics
1. Centralized Content Storage: It is the central repository where all the website's original content is stored and managed.
2. Content Source: It provides the original content to edge servers or directly to users if the content is not cached or when a CDN is not used.
3. Performance Limitations: Directly serving all user requests, especially for sites with a global audience, can lead to slower response times due to geographical distance and increased load.
### Edge Server Characteristics:
1. Geographical Distribution: Located in various locations (edge locations) closer to the end-users.
2. Content Caching: Stores cached copies of content from the origin server. helps in faster delivery, and drop response time.
3. Load Balancing and Scalability: Helps in distributing user requests efficiently, handling traffic spikes, and improving the scalability of web content delivery.

### Example Scenario
Imagine a user from Paris attempting to access a video hosted on a website whose origin server is located in New York. If the website uses a CDN, the user's request might be routed to an edge server in Paris. If the requested video is cached on the Paris edge server, it is delivered quickly to the user from there, significantly reducing the time it would take to fetch the video directly from the origin server in New York.

### Conclusion
While the origin server is the source of the original content, edge servers play a crucial role in optimizing content delivery to end-users by caching content closer to where users are located. This architecture significantly improves website performance, reduces latency, and enhances user experience, especially for websites with a global audience.

## CDN Routing and Request Handling
CDN routing is the process of directing user requests to the most suitable edge server. Routing decisions are typically based on factors such as network latency, server load, and the user's geographical location. Following are Various techniques used to determine the optimal edge server
### Anycast Routing
 In anycast routing, multiple edge servers share a single IP address. When a user sends a request to that IP address, the network's routing system directs the request to the nearest edge server based on network latency or the number of hops. This approach helps ensure that requests are automatically routed to the most appropriate server.

### DNS-based Routing
With DNS-based routing, when a user requests content, the CDN's DNS server responds with the IP address of the most suitable edge server. This approach can take into account factors such as geographical proximity and server load to select the best edge server for handling the request.

### GeoIP-based Routing
In this approach, the user's geographical location is determined based on their IP address. The request is then directed to the nearest edge server in terms of geographical distance, which often corresponds to lower network latency.

What are the different CDN caching strategies?
Answer:

Time-Based Caching (Cache-Control: max-age)
Etag-Based Caching (Checks content updates using ETag)
Heuristic Caching (Estimates cache time based on past behavior)
Bypass Cache (no-cache header forces revalidation)

## CDN Network Topologies
CDN network topologies describe the structure and organization of the CDN's distributed network. Different topologies can be employed to optimize content delivery based on factors such as performance, reliability, and cost. Some common CDN network topologies include:

### Flat Topology
In a flat topology, all edge servers in the CDN are directly connected to the origin server. This approach can be effective for smaller CDNs, but may not scale well as the network grows.

### Hierarchical Topology
In a hierarchical topology, edge servers are organized into multiple tiers, with each tier being responsible for serving content to the tier below it. This approach can improve scalability by distributing the load among multiple levels of servers and reducing the number of direct connections to the origin server.

### Mesh Topology
In a mesh topology, edge servers are interconnected, allowing them to share content and load with each other. This approach can enhance the redundancy and fault tolerance of the CDN, as well as improve content delivery performance by reducing the need to fetch content from the origin server.

### Hybrid Topology
A hybrid topology combines elements from various topologies to create an optimized CDN architecture tailored to specific needs. For example, a CDN could use a hierarchical structure for serving static content, while employing a mesh topology for dynamic content delivery.


CDN architecture involves the strategic placement of PoPs and edge servers, efficient routing and request handling mechanisms, effective caching strategies, and the appropriate selection of network topologies to optimize content delivery. By considering these factors, CDNs can provide significant improvements in latency, performance, reliability, and security for web applications.
## push, pull CDNs
CDNs can be categorized into two types: Pull CDNs and Push CDNs. Both types aim to deliver content efficiently, but they differ in how they handle and distribute the content.

### Pull CDN
In a Pull CDN, the content is not stored on the CDN's servers by default. Instead, the CDN "pulls" the content from the origin server when a user requests it for the first time. Once the content is cached on the CDN's edge server, subsequent requests for the same content will be served directly from the CDN, reducing the load on the origin server.

When the cached content expires or reaches its Time-to-Live (TTL), the CDN will fetch the content again from the origin server, ensuring that users receive up-to-date content.

Examples of Pull CDNs include Cloudflare, Fastly, and Amazon CloudFront.

Advantages of Pull CDN

Easy to set up and requires minimal changes to the existing infrastructure.
The origin server is only accessed when content is not available on the CDN, reducing the load and bandwidth usage.
The CDN automatically handles cache management and content expiration.
Disadvantages of Pull CDN

The first user to request the content may experience slightly slower load times as the CDN fetches the content from the origin server.
The origin server must be accessible at all times for the CDN to fetch the content when needed.
### Push CDN
In a Push CDN, the content is "pushed" to the CDN's servers by the content provider, usually through manual uploads or automated processes. The content is proactively distributed across the CDN's edge servers, making it readily available for user requests.

Push CDNs are typically used for large files or less frequently accessed content, as they allow for better control over content distribution and caching.

Examples of Push CDNs include Rackspace Cloud Files and Akamai NetStorage.

Advantages of Push CDN

Better control over content distribution and cache management, especially for large or infrequently accessed files.
Content is readily available on the CDN's servers, ensuring consistent load times for users.
Disadvantages of Push CDN

More complex to set up and maintain, as content must be manually uploaded or synced to the CDN.
Increased storage costs, as content is stored on both the origin server and the CDN's servers.
The responsibility of cache management and content expiration lies with the content provider.
In short, Pull CDNs are best suited for frequently accessed content and are easier to set up, while Push CDNs offer more control and are ideal for large or infrequently accessed files.
