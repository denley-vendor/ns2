set term png medium #000000
set output "eaqos-delay.png"
set ylabel "Query latencies(ms)"
set xlabel "Pause time(s)"  
set size 0.7,0.7 
set xrang [0:410]
set yrang [0:800]
set key top box
set title "Query Latencies Ananysis"
plot "delay3.data" title "Framwork" with linespoints lt -1 pt 8,"delay2.data" title "Naive" with linespoints lt -1 pt 4,"delay.data" title "EAQOS" with linespoints lt -1 pt 2  