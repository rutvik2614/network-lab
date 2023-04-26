set ns [new Simulator]



$ns rtproto LS



set nf [open out1.nam w]

$ns namtrace-all $nf



set np [open out1.tr w]

$ns trace-all $np



proc finish { } {

global ns nf np

$ns flush-trace

close $nf

exec nam out1.nam

exit 0

}



set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]



$ns duplex-link $n0 $n1 10Mb 20ms DropTail

$ns duplex-link $n1 $n2 10Mb 20ms DropTail

$ns duplex-link $n2 $n3 10Mb 20ms DropTail

$ns duplex-link $n3 $n0 10Mb 20ms DropTail



$ns duplex-link-op $n0 $n1 orient right

$ns duplex-link-op $n1 $n2 orient down

$ns duplex-link-op $n2 $n3 orient left

$ns duplex-link-op $n3 $n0 orient up



$ns cost $n0 $n1 11

$ns cost $n1 $n2 1 

$ns cost $n2 $n3 7 

$ns cost $n3 $n0 2  



set tcp [new Agent/TCP]

$tcp set class_ 2 

$ns attach-agent $n0 $tcp 

set sink [new Agent/TCPSink]

$ns attach-agent $n2 $sink 

$ns connect $tcp $sink   

$tcp set fid_ 1



set ftp [new Application/FTP]

$ftp attach-agent $tcp

$ftp set type_ FTP

$ftp set packet_size_ 1000

$ftp set rate_ 10mb



$ns at 1.0 "$ftp start"

$ns rtmodel-at 2.0 down $n0 $n3

$ns rtmodel-at 3.0 up $n0 $n3 

$ns at 4.0 "$ftp stop"



$ns at 5.0 "finish"



$ns run
