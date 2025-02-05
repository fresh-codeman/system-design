
# Caching
## revise
1. define cache, caching, cache miss, cache hit, cache eviction, cache staleness.
2. how caching works?
3. why caching important?
4. discuss about caching implementation type: in-memory caching, disk caching, database caching, client side caching, server side caching, cdn caching, dns caching.
5. Discuss cache replacement policies: LRU, LFU, FIFO, random replacement.
![caching](/assets/images/caching.png)
## terminologies
### caching
A technique that stores frequently accessed data in a temporary storage location, called a cache, for improved performance, scalability, faster processing and reduced latency.
### Cache: 
A temporary storage location for data or computation results, typically designed for fast access and retrieval.

### Cache hit:
When a requested data item or computation result is found in the cache.

### Cache miss:
When a requested data item or computation result is not found in the cache and needs to be fetched from the original data source or recalculated.

### Cache eviction:
The process of removing data from the cache, typically to make room for new data or based on a predefined cache eviction policy.

### Cache staleness:
When the data in the cache is outdated compared to the original data source.

## Importance of caching
By storing frequently accessed data in a cache, applications can reduce the response time and latency of operations, resulting in faster and more efficient processing
1.  Reduced latency by lesser time taken to fetch the data.
2. improved system performance because data retrieval is is fast that improves the processing time.
3. reduced network load, Since cached data is stored locally.
4. Increased scalability by reducing the load on the original source. so it is less likely to be overwhelmed.
5. Faster response times and reduced latency can lead to a better user experience

## caching implementation type
### In-memory caching
In-memory caching stores data in the main memory of the computer, which is faster to access than disk storage. In-memory caching is useful for frequently accessed data that can fit into the available memory. This type of caching is commonly used for caching API responses, session data, and web page fragments. To implement in-memory caching, software engineers can use various techniques, including using a cache library like Memcached or Redis, or implementing custom caching logic within the application code.

### Disk caching
Disk caching stores data on the hard disk, which is slower than main memory but faster than retrieving data from a remote source. Disk caching is useful for data that is too large to fit in memory or for data that needs to persist between application restarts. This type of caching is commonly used for caching database queries and file system data.

### Database caching
Database caching stores frequently accessed data in the database itself, reducing the need to access external storage. This type of caching is useful for data that is stored in a database and frequently accessed by multiple users. Database caching can be implemented using a variety of techniques, including database query caching and result set caching.

### Client-side caching
This type of caching occurs on the client device, such as a web browser or mobile app. Client-side caching stores frequently accessed data, such as images, CSS, or JavaScript files, to reduce the need for repeated requests to the server. Examples of client-side caching include browser caching and local storage.

### Server-side caching
This type of caching occurs on the server, typically in web applications or other backend systems. Server-side caching can be used to store frequently accessed data, precomputed results, or intermediate processing results to improve the performance of the server. Examples of server-side caching include full-page caching, fragment caching, and object caching.

### CDN caching
CDN caching stores data on a distributed network of servers, reducing the latency of accessing data from remote locations. This type of caching is useful for data that is accessed from multiple locations around the world, such as images, videos, and other static assets. CDN caching is commonly used for content delivery networks and large-scale web applications.

### DNS caching
DNS cache is a type of cache used in the Domain Name System (DNS) to store the results of DNS queries for a period of time. When a DNS server receives a request for a domain name and the IP address is in the cache, then DNS server can immediately respond with the IP address without having to query other servers.

![caching types](/assets/images/caching-types.png)

Some of the solutions for different type of cachings
![solutions for caching types and use cases](/assets/images/solution-to-caching.png)

## cache replacement policies
When implementing caching, it’s important to have a cache replacement policy to determine which items in the cache should be removed when the cache becomes full. Here are some of the most common cache replacement policies:

### Least Recently Used (LRU)
LRU removes the least recently used item. This assumes that items that have been accessed more recently are more likely to be accessed again in the future.

### Least Frequently Used (LFU)
LFU removes the least frequently used item. This assumes that items that have been accessed more frequently are more likely to be accessed again in the future.

### First In, First Out (FIFO)
FIFO removes the oldest item. This assumes that the oldest items in the cache are the least likely to be accessed again in the future.

### Random Replacement
Random replacement removes a random item. This doesn’t make any assumptions and can be useful when the access pattern is unpredictable.

### Comparison of different replacement policies
LRU and LFU are generally more effective than FIFO and random replacement since they take into account the access pattern of the cache. But both are expensive to implement since they require maintaining additional data structures to track access patterns.

## cache invalidation
