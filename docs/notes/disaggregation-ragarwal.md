# Notes on Network Requirements for Resource Disaggregation
   
DDC: disaggregated datacenter: Each resource type is built as a standalone resource “blade” and a network fabric interconnects these resource blades. 

Key enabling/blocking: network, low latency communications

Paper evaluating the minimum (bandwidth and latency) requirements the network in DDC.
7 applications: Hadoop, Spark, GraphLab, Timely datflow, Spark Streaming, memcached, HERD, sparkSQL

#### Requirements: 
Bandwidth: 40 – 100Gbps: maintain application-level performance: easy for switch and NIC HW
Network latency 3-5 us. Challenging 
Rack scale: disaggregation at the datacenter scale is feasible
TCP or DCTCP fail to meet requirement for low latency communication

CPU-memory disaggregation: expanding memory hierarchy to include a remote level
Partial CPU-memory disaggregation:  cache coherence traffic cannot be cached and impacts the network. Controller ASIC on blade: implements address translation between CPU’s view and address used internally within the blade. 

Network requirements evaluation methodology
The dominant impact to application performance comes from CPU-memory disaggregation.
Remote memory managed at the page granularity:
2 sources of performance penalty: 1. The software overhead for trap and page eviction 2. Time to transfer pages over the network only consider latter
compare server-centric(legacy) architecture (present worst case) VS disaggregated context 
application: Hadoop wordcount Hadoop sour, Graphlab CF, memcached YCSB, Spark wordcount, Spark Sort, Spark SQL BDB, Timely Dataflow Pagerank, HERD YCSB

swap device backed by remaining physical memory rather than disk: partition main memory into “local” and remote (page replacement algorithms control when and how pages are transferred between the two). Configure the size of the swap device: remaining is local

fault occurs: swapped into remaining part in the machine
measure: job completion time as compared to zero-delay case
results: relative performance degradations over different network configurations: delay is an artificial parameter may result from network congestion by disaggregation

~125GB data equally distributed across an Amazon EC2 cluster 5 m3.2xlarge servers.
Access links not a bottle neck
Batch application in a cluster with 5 workers and 1 master. Application multi-threaded, same as threads as cores.

2 categories: network latency and bandwidth needed to achieve a low performance latency

network latency: 3 us to 5 us
estimate:

#### Meeting Notes

1.   One way path between servers in different racks across three switches(2 ToR and 1 fabric switch)
2.   Inter-rack distances of 40m and intra-rack distances of 4m with a propagation speed of 5ns/m
3.   Cut-through switches

Round trip latency: software overheads, moving the page to/from the NIC at both the sending and receiving endpoints, 6 switches traversals, 4 link traversals , page of 4KB page

3 unavoidable delay: 1. Data transmission time, 2. Propagation delay 3. Switching delay
3.9	      us latency 
RDMA integrated NICs optimizations effectively reduce latencies.
Ignore queuing delay on end-to-end latency and hence application performance. Remedy:

Application-driven input traffic workload. 
Transport protocols for DDC

Network access trace using tcpdump, a disk access trace using blktrace

Splitting each node into one compute, one memory, and one disk blade and assigning memory blades to virtual nodes
All memory and disk accesses are associated with address in corresponding CPU’s global virtual address space.

Match network and disk traces across the cluster: disk access request matches a local flow in tcpdump traces -> assume from remote read, others local CPU

FCT: network layer performance, 
Injecting latencies for page misses.
However: inject the flow completion times obtained from best-performing network design instead of constant latencies. 

Kernel space RDMA block device driver which serves as a swap device:

Sev
Swap device, 
Set up interactive latency critical application

Mango DB, cache in memory, doesn’t fit in memory -> disk (docker container)
1 machine client: 1 server (has Mango DB) workload generator 
load as high as needed
tcp dump server side (timestamp, source destination, header payload) latency: memory or disk
not disk but remote memory
? rerun application(swap device) or replay trace?
Access to cluster using

2 machines, 1 server 1 client
change in home directory run home directory
sudo access 
tcpdmp probably run with sudo
ath 1(submit request, cli) ath 2(ser): 2 servers in 1 rack
tell memory through docker container, docker container- 

Zibian: web search: index in memory, data file in disk

#### Mar 20
No direct memory access between servers
Measure latency from one server to another disks,
measure CPU to local disk latency in the remote server (as with client)
measure CPU to memmory latency in the remote server
Estimate the latency from local CPU to remote memory

Application workload generator coule be used to assess performance
Isolation mechanism: network bandwidth partition(Axial casst load capacity) 

### April 10 
Using MangoDB to measure the latency from memory and from disk
Memory access can be done by access same key-value pair for several times
It will store in local memory after first fetch
Disk access can be done by access different/random/streaming key-value pairs 
Workload Generator: YCSB (contact with Shuang Chen for open-loop YCSB implementation)
Root Authority would be fixed by Christina
Use cluster 3 and cluster 4 to run jobs
Tcpdump may be used later for every request 
YCSB can run in different machine to measure remote disk access time

Expecation: 
How the local and remote memory parts will influence the performance? (different percentage)
Change the request cluster: size, distribution, popularity, interval
Different applicaiton performance over disaggregation: Memcached
Different read/write issues
Overhead of remote access 
Remote access in different racks, what point remote aggregation will make sense

### April 17
The job is divided into 3 parts: 1) further understanding of YCSB 2) How TCP-dump works and how 
use it with YCSB 3) How to inject latency into Mongodb
YCSB: draw the distribution figure of requests for local and remote access; understand the number
of open-loop YCSB

### April 24
Draw the output of different QPS with latency like shown in PARTIES paper
http://www.csl.cornell.edu/~delimitrou/papers/2019.asplos.parties.pdf
Replicate the way they present (99% latency)
Run memory in docker container and set memory MongoDB can use (ask Shuang about it)
Use <key, value> storage in the request to decide which mongodb to get data
Different mongodb by IP address, change YCSB implementation 
One server runs mongodb and one server runs YCSB and mongodb to plot the latency diagram

### May 1
Use containers 
Set 14 cores, CPU set for docker 
Set memory  —cpus=14 
Different machine (YCSB in 3, mongoldb on 4)
Check on the key, set different ip
Presentation: what is , why make sense, what application, challenges, latency ,network bandwidth, describe implementing, applications, highlight the motivation 
