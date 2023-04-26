#new simulator object 

set ns [new Simulator]



#giving color to packets

$ns color 1 red



#open file 

set nf [open topology_tcp.nam w]



#store all the tracing in nf 

$ns namtrace-all $nf

set np [open topology_tcp.tr w]



#define finish procedure 

proc finish {} {

    global ns nf np

    $ns flush-trace 

    close $nf 

    close $np

    exec nam topology_tcp.nam & 

    exit 0

}



#set node 

set n0 [$ns node] 

set n1 [$ns node]  

set n2 [$ns node]



#create a link between nodes

$ns duplex-link $n0 $n1 10Mb 10ms DropTail 

$ns duplex-link $n1 $n2 5Mb 10ms DropTail 



#give directions to the link 

$ns duplex-link-op $n0 $n1 orient right

$ns duplex-link-op $n1 $n2 orient right



#set queue size 

$ns queue-limit $n1 $n2 5



#monitor queue 

$ns duplex-link-op $n1 $n2 queuePos 0.5 



#setup tcp connection 

set tcp [new Agent/TCP]

$ns attach-agent $n0 $tcp 

set sink [new Agent/TCPSink]

$ns attach-agent $n2 $sink 

$ns connect $tcp $sink 

$tcp set fid_ 1



#setup ftp packet over tcp connection 

set ftp [new Application/FTP]

$ftp attach-agent $tcp



$ftp set type_ FTP

$ftp set packet_size_ 100

$ftp set rate_ 10mb



#schedule event 

$ns at 1.0 "$ftp start"

$ns at 4.0 "$ftp stop"



#call the finish procedure 

$ns at 5.0 "finish"



#run the file 

$ns run
