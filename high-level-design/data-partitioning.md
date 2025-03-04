# Data partitioning

Data partitioning is a technique used in distributed systems and databases to divide a large dataset into smaller, more manageable parts, referred to as partitions. Each partition is independent and contains a subset of the overall data.

In data partitioning, the dataset is typically partitioned based on a certain criterion, such as data range, data size, or data type. Each partition is then assigned to a separate processing node, which can perform operations on its assigned data subset independently of the others.

## test yourself

1. define data partitioning, partition, partition key, shard, type of partitioning
2. Sharding, Vertical partitioning, Hybrid partitioning, sharding technique
3. Range-based Sharding, Hash-based Sharding, Directory-based Sharding, Geographical Sharding, Dynamic Sharding, Hybrid Sharding,
4. befits and challenges of data partitioning.


## terminology

Partition: A partition is a smaller, more manageable part of a larger dataset, created as a result of data partitioning.

Partition key: The partition key is a data attribute used to determine how data is distributed across partitions. An effective partition key should provide an even distribution of data and support efficient query patterns.

Shard: A shard is a term often used interchangeably with a partition, particularly in the context of horizontal partitioning.

## Data partitioning scheme/methods

Designing an effective partitioning scheme can be challenging and requires careful consideration of the application requirements and the characteristics of the data being processed.

### Sharding/Horizontal partitioning

It involves dividing a database table into multiple partitions or shards, with each partition containing a subset of rows. Each shard is typically assigned to a different database server, which allows for parallel processing and faster query execution times.

For example, consider a social media platform that stores user data in a database table. The platform might partition the user table horizontally based on the geographic location of the users, so that users in the United States are stored in one shard, users in Europe are stored in another shard, and so on. This way, when a user logs in and their data needs to be accessed, the query can be directed to the appropriate shard, minimizing the amount of data that needs to be scanned.

The key problem with this approach is that if the value whose range is used for partitioning isn’t chosen carefully, then the partitioning scheme will lead to unbalanced servers. For instance, partitioning users based on their geographic location assumes an even distribution of users across different regions, which may not be valid due to the presence of densely or sparsely populated areas
![horizontal vs vertical partitioning](/assets/images/horizontal-vs-vertical-partitioning.png)

### Vertical partitioning

Vertical data partitioning involves splitting a database table into multiple partitions or shards, with each partition containing a subset of columns. This technique can help optimize performance by reducing the amount of data that needs to be scanned, especially when certain columns are accessed more frequently than others.

For example, consider an e-commerce website that stores customer data in a database table. The website might partition the customer table vertically based on the type of data, so that personal information such as name and address are stored in one shard, while order history and payment information are stored in another shard. This way, when a customer logs in and their order history needs to be accessed, the query can be directed to the appropriate shard, minimizing the amount of data that needs to be scanned.

### Hybrid partitioning

Hybrid data partitioning combines both horizontal and vertical partitioning techniques to partition data into multiple shards. This technique can help optimize performance by distributing the data evenly across multiple servers, while also minimizing the amount of data that needs to be scanned.

For example, consider a large e-commerce website that stores customer data in a database table. The website might partition the customer table horizontally based on the geographic location of the customers, and then partition each shard vertically based on the type of data. This way, when a customer logs in and their data needs to be accessed, the query can be directed to the appropriate shard, minimizing the amount of data that needs to be scanned. Additionally, each shard can be stored on a different database server, allowing for parallel processing and faster query execution times.
![practical example of partitioning](/assets/images/practical-example-of-partitioning.png)

## Sharding technique

### 1. Range-based Sharding

data is divided into shards based on a specific range of values for a given partitioning key(date, id, roll number etc). Each shard is responsible for a specific range, ensuring that the data is distributed in a predictable manner.

![sharding technique](/assets/images/sharding-technique-1.png)

### 2. Hash-based Sharding

Hash-based sharding involves applying a consistent hash function to the partitioning key, which generates a hash value that determines the destination shard for each data entry. This method ensures an even distribution of data across shards and is particularly useful when the partitioning key has a large number of distinct values or is not easily divided into ranges.

### 3. Directory-based Sharding

Directory-based sharding uses a lookup table, often referred to as a directory, to map each data entry to a specific shard. This method offers greater flexibility, as shards can be added, removed, or reorganized without the need to rehash or reorganize the entire dataset. However, it introduces an additional layer of complexity, as the directory must be maintained and kept consistent.

### 4. Geographical Sharding

Geographical sharding involves partitioning data based on geographical locations, such as countries or regions. This method can help reduce latency and improve performance for users in specific locations by storing their data closer to them.

Example: A global streaming service stores user data and decides to shard it based on the user’s country

### 5. Dynamic Sharding

Dynamic sharding is an adaptive approach that automatically adjusts the number of shards based on the data’s size and access patterns. This method can help optimize resource utilization and performance by creating shards as needed and merging or splitting them as the data grows or shrinks.

Example: An Internet of Things (IoT) platform collects sensor data from a large number of devices.

### 6. Hybrid Sharding: The Best of Many Worlds

Hybrid Sharding is a blend of multiple sharding strategies to optimize performance. It might combine Geo-based with Directory-based sharding, or any other mix that suits a system's needs.
Snapshot: Many cloud service providers, given their diverse clientele and global infrastructure, adopt hybrid sharding. It's their secret sauce to ensure consistent, high-speed services across the board.

## Benefits of Data partitioning

1. Improved Query Performance:- When data is partitioned, queries can be targeted at specific partitions that reduces the amount of data that needs to be processed
2. Enhanced Scalability:- As the dataset grows, new partitions can be added to accommodate the additional data, without negatively impacting the performance of existing partitions.
3. Load Balancing:- Data partitioning helps distribute the workload evenly across multiple storage nodes or servers. This load balancing ensures that no single node becomes a bottleneck, leading to better overall system performance and reliability.
4. Data Isolation:- Failure or corruption of one partition does not impact other partitions. This isolation can help improve the overall robustness and resilience of the system.
5. Parallel Processing:- Multiple partitions can be processed simultaneously by different processors or systems. This parallelism can lead to significant performance improvements, especially for large-scale data processing tasks.
6. Storage Efficiency:- By partitioning data based on usage patterns or data relevance, organizations can achieve more efficient storage utilization. Frequently accessed data can be stored on faster, more expensive storage resources, while less critical data can be stored on cheaper, slower storage resources.
7. Simplified Data Management:- Data management tasks, such as backup, archiving, and maintenance, more manageable and efficient. By dealing with smaller, more focused partitions, these tasks can be performed more quickly and with less impact on overall system performance.
8. Better Resource Utilization:- Partitioning data based on specific attributes or access patterns can lead to better resource utilization. By aligning the data with the appropriate storage and processing resources, organizations can maximize the performance and efficiency of their data-driven systems.

Example: A weather forecasting service uses horizontal partitioning to store weather data based on geographical locations. This allows the service to allocate more resources to process data for areas with higher user demand, ensuring that resources are used efficiently and in line with user needs.

9. Improved Data Security:- Enhance data security by segregating sensitive information from less sensitive data. By isolating sensitive data in separate partitions, organizations can implement stronger security measures for those partitions, minimizing the risk of unauthorized access or data breaches.
10. Faster Data Recovery:- In the event of a system failure or data loss, By focusing on recovering specific partitions rather than the entire dataset, organizations can reduce downtime and restore critical data more quickly.

## Challenges of Data partitioning
1. Complexity:- it adds complexity to system architecture, design, and management. Organizations must carefully plan and implement partitioning strategies, taking into account the unique requirements of their data and systems. This added complexity can lead to increased development and maintenance efforts, as well as a steeper learning curve for team members.

2. Data Skew:- In some cases, it can result in uneven data distribution across partitions, known as data skew. If the chosen partitioning key or method does not distribute data evenly, leading to some partitions being larger or more heavily accessed than others. it might affect negatively.

3. Partitioning Key Selection:- Choosing the appropriate partitioning key is crucial for achieving the desired benefits of data partitioning. An unsuitable partitioning key can lead to inefficient data distribution, performance bottlenecks, and increased management complexity. Selecting the right key requires a deep understanding of the data and its access patterns, which can be challenging for some organizations.

4. Cross-Partition Queries:- When queries need to access data across multiple partitions, performance can suffer, as the system must search through and aggregate data from several partitions. This can result in increased query latency and reduced overall performance, especially when compared to a non-partitioned system.

5. Data Migration:- Partitioning can sometimes require significant data migration efforts, especially when changing partitioning schemes or adding new partitions. This can be time-consuming and resource-intensive, potentially causing disruptions to normal system operation.

6. Partition Maintenance:- Managing and maintaining partitions can be a challenging and resource-intensive task. As the data grows and evolves, organizations may need to reevaluate their partitioning strategies, which can involve repartitioning, merging, or splitting partitions. This can result in additional maintenance overhead and increased complexity. Here are a few other maintenance challenges:

Backup Challenges: Performing backups isn't straightforward anymore. You need to ensure data consistency across all shards.

Patch Management: When a security update rolls out, it needs to be applied across all shards, sometimes simultaneously, to maintain compatibility and security.

Monitoring Woes: Instead of one set of metrics, DB administrators now need to monitor multiple, making anomaly detection a more daunting task.

7. Cost:- Implementing a data partitioning strategy may require additional hardware, software, or infrastructure, leading to increased costs. Furthermore, the added complexity of managing a partitioned system may result in higher operational expenses.