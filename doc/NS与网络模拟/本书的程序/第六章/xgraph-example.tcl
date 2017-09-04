#Create a simulator object
set ns [new Simulator]

#Define different colors for data flows
#$ns color 1 Blue
#$ns color 2 Red

#Open the nam trace file
set nf [open out-1.nam w]
$ns namtrace-all $nf

set f0 [open out0.tr w]
set f1 [open out1.tr w]

#Define a 'finish' procedure
proc finish {} {
        global ns nf
        $ns flush-trace
	#Close the trace file
        close $nf
	#Execute nam on the trace file
        exit 0
}

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n3 $n2 1Mb 10ms SFQ

#$ns duplex-link-op $n0 $n2 orient right-down
#$ns duplex-link-op $n1 $n2 orient right-up
#$ns duplex-link-op $n2 $n3 orient right

#Monitor the queue for the link between node 2 and node 3
$ns duplex-link-op $n2 $n3 queuePos 0.0

#Create a CBR agent and attach it to node n0
set cbr0 [new Agent/CBR]
$ns attach-agent $n0 $cbr0
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.005
$cbr0 set fid_ 1

#Create a CBR agent and attach it to node n1
set cbr1 [new Agent/CBR]
$ns attach-agent $n1 $cbr1
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 set fid_ 2

set sink0 [new Agent/LossMonitor]
$ns attach-agent $n3 $sink0
set sink1 [new Agent/LossMonitor]
$ns attach-agent $n3 $sink1


$ns add-agent-trace $cbr1 test-trace
$ns add-agent-trace $cbr1 test-trace2

#Connect the traffic sources with the traffic sink
$ns connect $cbr0 $sink0  
$ns connect $cbr1 $sink1

#Schedule events for the CBR agents
$ns at 0.5 "$cbr0 start"
$ns at 1.0 "$cbr1 start"
$ns at 4.0 "$cbr1 stop"
$ns at 4.5 "$cbr0 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

proc record {} {
        global sink0 sink1 f0 f1 	;# 设定这些变量为全局变量
        # 获得ns模拟器的实例
        set ns [Simulator instance]
        # 设定每次统计的时间周期
        set time 0.1
        # 下面两个变量获得接收sink目前的流量
        set bw0 [$sink0 set bytes_]
        set bw1 [$sink1 set bytes_]
        # 获得ns当前时间
        set now [$ns now]
        # 计算这段周期内各流的流量，以MB为单位
        puts $f0 "$now [expr $bw0/$time*8/1000000]"
        puts $f1 "$now [expr $bw1/$time*8/1000000]"
        # 重置每个接收sink的接收量为0
        $sink0 set bytes_ 0
        $sink1 set bytes_ 0
        # 重新安排ns事件，在下个周期继续调用record过程
        $ns at [expr $now+$time] "record"
}

$ns at 0.0 "record"

#Run the simulation
$ns run

