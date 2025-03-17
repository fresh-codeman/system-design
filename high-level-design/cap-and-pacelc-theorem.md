# CAP and PACELC Theorem
## test yourself
1. cap theorem and define all of its properties.
2. create all possible systems based on CAP and discuss wit examples
3. PACLEC theorem and examples
4. CRDTs Theorem, application specific tradeoffs
5. What things we consider in interview. 

## CAP theorem
The CAP theorem, also known as Brewer's theorem, is a fundamental concept in distributed systems design. It was introduced by Eric Brewer in 2000. The CAP theorem provides a framework for understanding the trade-offs between three essential properties of distributed systems: consistency, availability, and partition tolerance.

**it is impossible for a distributed system to simultaneously provide all three properties: consistency, availability, and partition tolerance**

![cap](/assets/images/cap-thorem.png)

1. Consistency (C): In the context of CAP, it means every read receives the result of the most recent write – no matter which replica node it connects to. This is often referred to as strong consistency.

2. Availability (A): The system is always available to serve requests, even if some nodes fail. An available system can tolerate node failures with trade off of consistency.

3. Partition Tolerance (P): The system continues to function even when there is network partition (communication failure between nodes). network partitions can happen (due to outages, delays, etc.). it Sacrifice immediate consistency.

CAP theorem tells us that when a network partition occurs, a system must choose between being Consistent or being Available – it cannot be both. If there is no partition, you can have both C and A. But you must design assuming a partition will eventually happen.
## Tread-offs in CAP
Now let's discuss the heart of CAP: the trade-offs. Why can’t a distributed system have Consistency, Availability, and Partition tolerance all at once?, Depending on which trade-off a system makes, we categorize it as CP, AP, or CA under CAP theorem:
### CP (Consistency + Partition tolerance, no guarantee of Availability)
These systems cannot allow conflicting updates on different sides of the partition. So at least one side of the partition must stop accepting operations (to avoid divergence). until update goes through the system. That means some part of the system becomes unavailable (not serving requests)choose consistency over availability  

These systems are suitable for use cases where data integrity is paramount – for example, financial applications prefer CP, as seen in banking: it’s better for the system to refuse an operation than to allow inconsistent money transfers.

Examples: 
1. MongoDB is a popular NoSQL database which, by default, prioritizes consistency. It uses a primary-secondary replication model. Only the primary can accept writes, and if the primary is lost (partitioned away or down), the system elects a new primary. During that failover window, writes are not accepted – a sacrifice of availability to ensure no two primaries exist (consistency). Once a new primary is in place and secondaries are synchronized, the cluster resumes normal operations. 
2. ZooKeeper is a coordination service often used for configuration management, leader election, and other tasks in distributed applications. It is famously a CP system. ZooKeeper uses an algorithm (Zab) that requires a majority quorum of nodes to operate. If a network split leaves the cluster without a quorum, the minority side will stop functioning (becoming unavailable) to preserve a single consistent state. if it cannot guarantee the latest state, it simply won’t respond. This makes ZooKeeper ideal for things like distributed locks and config.   

### AP (Availability + Partition tolerance, no immediate Consistency guarantee)
These systems must keep serving requests on all sides of the partition. That means each side might proceed independently, leading to inconsistencies (different parts have different data until they can sync up later).thus usually providing eventual consistency.

AP systems are great for use cases like caches, shopping carts, or social media feeds – where it’s more important that the system is up than absolutely in sync at every moment.

Examples: 
1. Cassandra is a distributed database, It has no single primary node – any node can accept writes at any time. This yields high availability and scalability. If a partition happens, Cassandra keeps all sides running; writes might conflict, but the system will reconcile them (using timestamps, hinted handoff, repair jobs, etc.) after the fact. Thus, Cassandra is willing to return older data rather than fail a request. It provides tunable consistency (you can configure how many replicas must ack a read/write), but the default philosophy is “always be available.” Many large-scale websites use Cassandra for features like user activity feeds, where it’s okay if one replica is briefly behind as long as the service is up
2. DynamoDB, a cloud key-value store from Amazon, is built on the principles of Amazon’s Dynamo paper. DynamoDB is designed to scale across multiple data centers and remain available. It replicates data across zones and continues serving even if some replicas or network links fail, favoring availability. By default, reads are eventually consistent (you might read slightly stale data if a partition occurred), though it offers an option for strongly consistent reads within a region. Amazon’s goal with DynamoDB is that operations (especially writes to things like a shopping cart or user preference) should succeed even in the face of outages – they’ll sort out any inconsistencies later.
3. DNS (the domain name system) is another everyday example of AP: it’s virtually always available globally, but updates (like changing a domain’s IP) take time to propagate, meaning not everyone sees the change immediately. 
 
### CA (Consistency + Availability, no Partition tolerance)
These systems provide consistency and availability as long as the system is whole. it means your system is not built to handle network failures between nodes. The only realistic way to be “CA” is to have all components so tightly coupled (or even running on one node) that a partition can’t happen. 

A common example: a single-node relational database can be viewed as CA – it is consistent (thanks to ACID properties) and available (when the node is up), but if that one node fails, or if you consider a partition between the app and the db, the system doesn’t gracefully tolerate it (it just fails). Some relational DB clusters that use synchronous replication can also be seen as CA until a network split happens – at which point they usually stop functioning rather than allow divergence.

Partition tolerance plays a “less important role” in these systems, but in a true distributed environment you can’t really avoid P. It’s important to note that pure CA systems are theoretical in distributed context, because you can’t avoid network faults.

## Other Theorems
### PACELC Theorem
introduced by Daniel Abadi around 2010. PACELC expands on CAP by asking: not only what happens during a Partition (P), but also what happens Else (E) when there’s no partition. In formal terms, PACELC says:
- If a partition (P) occurs: the system must choose either Availability (A) or Consistency (C) (this is essentially the CAP theorem trade-off during a failure).
- Else (no partition): the system must choose between Latency (L) and Consistency (C)
In shorthand, “if P then A or C; else L or C.” 

Examples
1. Cassandra under PACELC: We said Cassandra is AP in CAP terms. Under PACELC, we classify it as PA/EL – Partition tolerant + Available, and Else (when no partition) it prefers low Latency over full consistency. Cassandra’s design optimizes for fast writes and reads (low latency) rather than blocking to synchronize every replica on each request. So it’s Available under partition, and in normal times it’s still favoring performance (with eventual consistency).
2. MongoDB under PACELC: MongoDB was CP in CAP. Under PACELC, it’s often described as PC/EC – Partition tolerant + Consistent, and Else Consistent. That means even with no partition, MongoDB (by default) chooses consistency over latency (it funnels writes through one primary and replicates synchronously to secondaries). During a partition, it sacrifices availability to keep data consistent (only a majority partition can accept writes). So MongoDB is PC/EC by default configuration.
### CRDTs and Hybrid Systems
Convergent Replicated Data Types (CRDTs) are data structures designed to allow multiple replicas to be updated independently and converge to a consistent state without requiring coordination. CRDTs can help system designers achieve both strong eventual consistency and high availability. By combining CRDTs with other techniques, it is possible to build hybrid systems that provide tunable consistency guarantees, enabling applications to make trade-offs based on their specific requirements.
### Application-specific trade-offs
The CAP theorem and its extensions provide valuable insights into the fundamental trade-offs in distributed systems design. However, it is crucial to remember that real-world systems often involve more complex and application-specific trade-offs. As a system designer, it is important to understand the unique requirements and constraints of your application and make informed decisions about the trade-offs that best meet those needs.

## Interview perspective
When it comes to system design (especially in interviews), understanding CAP isn’t just theoretical – it guides real decisions. Interviewers often present scenarios where you need to decide between consistency and availability. Here’s how to think about it:

1. Understand the requirements of the scenario Ask yourself: is it worse for this system to show incorrect/out-of-date data, or to not respond at all? The answer will hint at consistency vs availability. 

For example, in a banking system, an inconsistent account balance is unacceptable. On the other hand, consider a social media news feed or an analytics dashboard – showing slightly stale results is usually fine, but the service being down is not.

2. Recognize that partition tolerance is usually a given if you’re designing a distributed system. This means you’re inherently in a CAP trade-off situation.

A good answer will mention something like, “Since network partitions can occur, we have to choose whether to favor consistency or availability in this design.”

3. Use real-world analogies or references: You can mention known systems as examples to justify your choice. For instance: “We might choose a design similar to Cassandra or DynamoDB which prioritize availability, because in our use case (say, a cache for product catalog) it’s more important that the system is always up than absolutely up-to-date. The data can sync eventually.” Or “We could use an approach like ZooKeeper or a SQL database cluster for this config service, because we need strong consistency – it’s okay if during a network split the service pauses, as long as we never get conflicting configs.” Demonstrating knowledge of how big companies solve it adds credibility. For example, you might say “Amazon’s Dynamo was designed for an always-on shopping cart, so they chose an AP design with eventual consistency. I’d apply the same principle here because user experience should never be interrupted for this feature.” Or, “Google uses Spanner for their ad database to ensure global consistency – in our case of a financial ledger, we’d also lean CP, even if it means a bit more latency.”

4. Acknowledge the trade-off and possible mitigation: A strong answer doesn’t just pick C or A blindly; it discusses the impact and how to mitigate downsides. For example, “If we choose availability, we’ll need to handle conflicts from concurrent updates (perhaps using timestamps or last-write-wins). The data might be temporarily inconsistent, so we must ensure eventual reconciliation.” Or “If we choose consistency, we should implement retries or graceful degradation for when the service is unavailable during a partition, so that users see a friendly error or limited functionality instead of total failure.” This shows you understand the practical implications.

5. Mention tunable or nuanced approaches if relevant: Modern systems often allow tuning the consistency level per request (for instance, Cassandra lets you choose consistency level per query). In an interview, you could mention this: “We could even make it tunable – e.g., a read that absolutely must be up-to-date can be routed to the leader (sacrificing some latency), whereas other reads can go to any replica for speed. This way the system isn’t strictly one or the other, but offers a spectrum depending on the operation.” Eric Brewer himself noted that within one system, some operations can be handled in a more available way and others in a more consistent way. This kind of answer shows maturity – real systems often mix approaches.

