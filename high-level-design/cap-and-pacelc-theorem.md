# CAP and PACELC Theorem
## test yourself
1. cap theorem and define all of its properties.

## CAP theorem
The CAP theorem, also known as Brewer's theorem, is a fundamental concept in distributed systems design. It was introduced by Eric Brewer in 2000. The CAP theorem provides a framework for understanding the trade-offs between three essential properties of distributed systems: consistency, availability, and partition tolerance.

**it is impossible for a distributed system to simultaneously provide all three properties: consistency, availability, and partition tolerance**

![cap](/assets/images/cap-thorem.png)

1. Consistency (C): In the context of CAP, it means every read receives the result of the most recent write – no matter which replica node it connects to. This is often referred to as strong consistency.

2. Availability (A): The system is always available to serve requests, even if some nodes fail. An available system can tolerate node failures with trade off of consistency.

3. Partition Tolerance (P): The system continues to function even when there is network partition (communication failure between nodes). network partitions can happen (due to outages, delays, etc.). it Sacrifice immediate consistency.

CAP theorem tells us that when a network partition occurs, a system must choose between being Consistent or being Available – it cannot be both. If there is no partition, you can have both C and A. But you must design assuming a partition will eventually happen.