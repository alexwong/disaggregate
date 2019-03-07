# disaggregate
Emulator for a simple scalable disaggregated system/datacenter. We will use a physical cluster and emulate storage disaggregation by exposing an API to access memory with different latencies depending on the location on the rack. We will use several applications to benchmark scaling such as Memcached as well as how applying different isolation mechanisms affect this.
