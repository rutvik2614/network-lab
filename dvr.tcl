set ns [new Simulator]

$ns rtproto DV

set nf [open dvr.nam w]

$ns namtrace-all $nf

proc finish {} {

    global ns nf np

    $ns flush-trace 

    close $nf 

    exec nam dvr.nam & 

    exit 0

}

set n0 [$ns node]

set n1 [$ns node]

set n2 [$ns node]

set n3 [$ns node]



$ns duplex-link $n0 $n1 10mb 10ms DropTail

$ns duplex-link $n1 $n2 10mb 10ms DropTail

$ns duplex-link $n2 $n3 10mb 10ms DropTail

$ns duplex-link $n3 $n0 10mb 10ms DropTail



$ns duplex-link-op $n0 $n1 orient right

$ns duplex-link-op $n1 $n2 orient down

$ns duplex-link-op $n2 $n3 orient left

$ns duplex-link-op $n3 $n0 orient up



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

$ns rtmodel-at 2.0 down $n1 $n2

$ns rtmodel-at 3.0 up $n1 $n2

$ns at 4.0 "$ftp stop"

$ns at 5.0 "finish"

$ns run
