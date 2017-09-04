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

 
#ӛ�Ŀǰ��ߵ�packet ID
   if ( packet_id > highest_packet_id )
                highest_packet_id = packet_id;
 
#ӛ䛷���Ă��͕r�g
   if ( start_time[packet_id] == 0 )  
               start_time[packet_id] = time;
 
#ӛ�CBR (flow_id=2) �Ľ��Օr�g
   if ( flow_id == 2 && action != "d" ) {
      if ( action == "r" ) {
         end_time[packet_id] = time;
      }
   } else {
#�Ѳ���flow_id=2�ķ��������flow_id=2���˷����drop�ĕr�g�O��-1
      end_time[packet_id] = -1;
   }
}                                                                                                           
END {
#���Y����ȫ���xȡ���ᣬ�_ʼӋ����Ч����Ķ��c�����c���t�r�g 
    for ( packet_id = 0; packet_id <= highest_packet_id; packet_id++ ) {
       start = start_time[packet_id];
       end = end_time[packet_id];
       packet_duration = end - start;
 
#ֻ�ѽ��Օr�g��춂��͕r�g��ӛ��г���
       if ( start < end ) printf("%f %f\n", start, packet_duration);
   }
}