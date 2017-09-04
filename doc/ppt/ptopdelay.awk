s 10.1 _1_ AGT  --- 22 tcp 43 [0 2 1 800] ------- [1:0 2:0 30 2] [13 0] 0 0
BEGIN {
     highest_packet_id = 0;
}
{
   action = $1;
   time = $2;
   node = $3;
   objtype = $4;
   reson = $5
   uid = $6;
   pkttype=$7;

 
#記錄目前最高的packet ID
   if ( packet_id > highest_packet_id )
                highest_packet_id = packet_id;
 
#記錄封包的傳送時間
   if ( start_time[packet_id] == 0 )  
               start_time[packet_id] = time;
 
#記錄CBR (flow_id=2) 的接收時間
   if ( flow_id == 2 && action != "d" ) {
      if ( action == "r" ) {
         end_time[packet_id] = time;
      }
   } else {
#把不是flow_id=2的封包或者是flow_id=2但此封包被drop的時間設為-1
      end_time[packet_id] = -1;
   }
}                                                                                                           
END {
#當資料列全部讀取完後，開始計算有效封包的端點到端點延遲時間 
    for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {
       start = start_time[packet_id];
       end = end_time[packet_id];
       packet_duration = end - start;
 
#只把接收時間大於傳送時間的記錄列出來
       if ( start < end ) printf("%f %f\n", start, packet_duration);
   }
}