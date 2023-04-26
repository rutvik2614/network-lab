set ns [new Simulator]



$ns color 1 blue



set nf [open dup1.nam w]

$ns namtrace-all $nf



proc finish {} {

global ns nf

$ns flush-trace

close $nf

exec nam dup1.nam &

exit 0

}



set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]



$ns duplex-link $n0 $n1 10mb 10ms DropTail

$ns duplex-link $n1 $n2 7mb 10ms DropTail

$ns duplex-link $n2 $n3 10mb 10ms DropTail

$ns duplex-link $n3 $n0 10mb 10ms DropTail



$ns duplex-link-op $n0 $n1 orient right

$ns duplex-link-op $n1 $n2 orient down

$ns duplex-link-op $n2 $n3 orient left

$ns duplex-link-op $n3 $n0 orient up





$ns queue-limit $n1 $n2 5



$ns duplex-link-op $n1 $n2 queuePos 0.5 



set udp [new Agent/UDP]

$ns attach-agent $n0 $udp

set null [new Agent/Null]

$ns attach-agent $n2 $null

$ns connect $udp $null

$udp set fid_ 1



set cbr [new Application/Traffic/CBR]

$cbr attach-agent $udp

$cbr set type_ FTP

$cbr set packet_size_ 1000

$cbr set rate_ 8mb



$ns at 1.0 "$cbr start"

$ns at 3.0 "$cbr stop"

$ns at 3.5 "finish"



$ns run



