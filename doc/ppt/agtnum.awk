BEGIN { 
AgtNum = 0;
}
{	
 if ($1 == "s" && $4 == "AGT")
     AgtNum++;
}
END{
         printf(" Num of AGT pkts: %d \n", AgtNum);
}
