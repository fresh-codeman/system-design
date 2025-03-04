
# Caching
## test yourself
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
Process of marking the cached data out-of-date (stale) called “cache invalidation. So we do not serve out-of-date (stale) information. Update happens gradually.

### Why cache invalidation
* Ensure Data Freshness: Without invalidation, caches will keep serving outdated data and lead to inconsistencies across your application.
* Maintain System Consistency:  Large systems with multiple caching layers should Properly invalidating caches at each layers to maintain a consistency.
* Balance Performance and Accuracy: Cache invalidation strategies (e.g., time-to-live/TTL, manual triggers, event-based invalidation) are designed to minimize the performance cost of continuously “refreshing” the cache.
The goal is to keep data as accurate as possible while still benefiting from the high-speed data retrieval that caching offers.
* Reduce Errors and Mismatched States: By strategically invalidating caches on data changes, you reduce the odds of users experiencing buggy or contradictory behavior.
### Cache invalidation schemes

#### Write-through cache
Under this scheme, data is written into the cache and the corresponding database simultaneously. Complete data consistency, No effect of adverse events(crash, power failure, or other system disruptions) and Higher latency for write operations.

<video width="640" height="360" controls>
  <source src="/assets/video/write-through.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

#### Write-around cache
Under this scheme data is written directly to permanent storage, bypassing the cache. This can reduce the cache being flooded with write operations that will not subsequently be re-read. But first read faces 'cache miss' and update data form database that cause Higher latency.

<video width="640" height="360" controls>
  <source src="/assets/video/write-arround.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

#### Write-back cache
Under this scheme, data is written to cache alone, and completion is immediately confirmed to the client. The write to the permanent storage is done based on certain conditions, for example, when the system needs some free space. This results in low-latency and high-throughput for write intensive applications. has risk of data loss in case adverse event.

<video width="640" height="360" controls>
  <source src="/assets/video/write-back.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

#### Write-behind cache
It is quite similar to write-back cache. But in write-back caching, data is only written to the permanent storage when it is necessary for the cache to free up space, while in write-behind caching, data is written to the permanent storage at specified intervals.

### Cache Invalidations Methods
#### Purge
The purge method removes cached content for a specific object, URL, or a set of URLs. and the next request for the content will be served directly from the origin server.

#### Refresh
Refresh request doesn’t remove the existing cached content; instead, it updates it with the latest version.

#### Ban
The ban method invalidates cached content based on specific criteria,and subsequent requests for the content will be served directly from the origin server.

#### Time-to-live (TTL) expiration
This method involves setting a time-to-live value for cached content, after which the content is considered stale. On request based on the TTL expiry serves cached content else fetch from origin and cache it.

#### Stale-while-revalidate
This method is used in web browsers and CDNs to serve stale content from the cache while the content is being updated in the background. This method ensures that the user is always served content quickly, even if the cached version is slightly outdated.
![cache invalidation methodds](/assets/images/cache-invalidation-methods.png)

## Cache read strategies
### Read through cache
A read-through cache strategy is a caching mechanism where the cache itself is responsible for retrieving the data from the underlying data store when a cache miss occurs. Hight consistency b/w cache and data store, cache responsible cache miss. it improve performance in scenarios where data retrieval from the data store is expensive, and cache misses are relatively infrequent.

### Read aside cache
A read-aside cache strategy, also known as cache-aside or lazy-loading, is a caching mechanism where the application is responsible for retrieving the data from the underlying data store when a cache miss occurs. application has control over caching process, although application code logic become complex. it is used when the application wants to optimize cache usage based on specific data access patterns.
![cache read strategies](/assets/images/cache-read-strategies.png)

## cache coherence and consistency model
### Cache Coherence
Cache coherence is a property of multi-core processors or distributed systems that ensures all processors or nodes see the same view of shared data. In a system with multiple caches, each cache may store a local copy of the shared data. When one cache modifies its copy, it is essential that all other caches are aware of the change to maintain a consistent view of the data.

To achieve cache coherence, various protocols and techniques can be employed, such as:

1. Write-invalidate: When a cache writes to its copy of the shared data, it broadcasts a message to other caches, invalidating their copies. When another cache requires the updated data, it fetches the new data from the memory or the cache that made the change.

2. Write-update (or write-broadcast): When a cache writes to its copy of the shared data, it broadcasts the updated data to all other caches, which update their local copies accordingly.

### Cache Consistency Models
Cache consistency models define the rules and guarantees for how data is updated and accessed in a distributed system with multiple caches. Different consistency models offer varying levels of strictness, balancing performance with the need for data accuracy.

* Strict Consistency: In this model, any write to a data item is instantly visible to all caches. Highest level of consistency, High synchronization overhead and negatively impact performance.

* Sequential Consistency: In this model, all operations on data items appear to occur in a specific sequential order across all caches. While better performance than strict consistency, still requires considerable synchronization.

* Causal Consistency: In this model, operations that are causally related (i.e., one operation depends on the outcome of another) are guaranteed to appear in order across all caches. Operations that are not causally related can occur in any order. This model provides better performance than sequential consistency while still ensuring a reasonable level of data accuracy.

* Eventual Consistency: In this model, all updates to a data item will eventually propagate to all caches, but there is no guarantee about the order or timing of the updates. best performance, weakest consistency guarantees. It used when scalability are prioritized over strict data accuracy.

## cache challenge
Here are the top cache-related problems and their possible workarounds:
### Thundering Herd
When a popular piece of data expires from the cache, leading to a sudden surge in requests to the origin server to fetch the missing data. This can cause excessive load on the origin server and degrade performance. Solutions use staggered expiration times, cache lock, or background update to refresh before expiry.
### Cache Penetration
When requests for data bypass the cache and directly access the origin server, reducing the benefits of caching. happens when requests are made for non-existent or rarely accessed data. Solutions negative caching (caching negative responses) or using a bloom filter to check for the existence of data.
### Big Key
A big key is a large piece of data that consumes a significant portion of the cache's capacity. Storing big keys can lead to cache evictions, reducing the overall effectiveness of the caching system. Solutions compressing the data, breaking data into smaller chunks, specific caching strategy for large objects.
### Hot Key
A hot key refers to a piece of data that is frequently accessed, causing contention and performance issues in the caching system. Hot keys can lead to cache thrashing and an unbalanced distribution of load. Solutions consistent hashing to distribute the load more evenly, replicate hot key to multiple cache nodes, use load balancing strategy to distribute requests across multiple instances.
### Cache Stampede (or Dogpile)
when multiple requests for the same data are made simultaneously, causing excessive load on the cache and the origin server. Cache stampede can be addressed using techniques such as request coalescing (combining multiple requests for the same data into a single request) or implementing a read-through cache, where the cache itself fetches the missing data from the origin server.
### Cache Pollution
when less frequently accessed data displaces more frequently accessed data in the cache, leading to a reduced cache hit rate. Solution use eviction policies like LRU or LFU, which prioritize retaining frequently accessed data.
### Cache Drift
Cache drift refers to the inconsistency between cached data and the data on the origin server, typically caused by updates or changes in the data. Solution proper cache invalidation strategies.

## cache performance metrics
When implementing caching, it’s important to measure the performance of the cache to ensure that it is effective in reducing latency and improving system performance. Here are some of the most common cache performance metrics:

### Hit rate
The hit rate is the percentage of requests that are served by the cache without accessing the original source. So expect high hit rate.
### Miss rate
The miss rate is the percentage of requests that are not served by the cache and need to be fetched from the original source. expects low miss rates

### Cache size
The cache size is the amount of memory or storage allocated for the cache. The cache size can impact the hit rate and miss rate of the cache. A larger cache size can result in a higher hit rate, but it may also increase the cost and complexity of the caching solution.

### Cache latency
The cache latency is the time it takes to access data from the cache. A lower cache latency is expected.

