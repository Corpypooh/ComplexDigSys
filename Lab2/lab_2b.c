#include <stdio.h> //for printf() and other functionalities
#include <stdlib.h> //for exit()
#include <stdint.h> //for uint32_t
#include <fcntl.h> //for constants O_RDWR|O_SYNC used in opening serial interface
#include <signal.h> //handles CTRL+C
#include <sys/mman.h> //for mmap() and munmap()
//#include "hps_0.h" //Platform design peripheral description
#define REG_BASE 0xff200000 //LW H2F Bride Base Address
#define REG_SPAN 0x00200000 //LW H2F Bridge Span

#define HEX0_BASE 0x00000050
#define HEX1_BASE 0x00000040
#define HEX2_BASE 0x00000030
#define HEX3_BASE 0x00000020
#define HEX4_BASE 0x00000010
#define HEX5_BASE 0x00000000


	void *base;
	uint32_t *hex0;
	uint32_t *hex1;
	uint32_t *hex2;
	uint32_t *hex3;
	uint32_t *hex4;
	uint32_t *hex5;
	int fd;
	
void handler(int signo) { //Used to free the mapped resource upon exit()
	*hex0 = 0;
        *hex1 = 0;
        *hex2 = 0;
        *hex3 = 0;
        *hex4 = 0;
        *hex5 = 0;
	 munmap(base, REG_SPAN);
	 close(fd);
	 exit(0);
}

int main() {
	
 	int hour = 0;
 	int minute = 0;
 	int second = 0;
 	uint32_t h2, h1, m2, m1, s2, s1;
 	//hex0 and hex1 for seconds
 	//hex2 and hex3 for minutes
 	//hex4 and hex5 for hours
 	
 	
 	
 	
	 fd=open("/dev/mem", O_RDWR|O_SYNC); //try and open the entire memory space
	 
	 if(fd<0) {
		 printf("Can't open memory\n");
		 return -1;
	 }
	 
	 base=mmap(NULL, REG_SPAN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, REG_BASE); //map the lightweight bridge
	 
	 if(base==MAP_FAILED) {
		 printf("Can't map to memory\n");
		 close(fd);
		 return -1;
	 }
	 
	 hex0=(uint32_t*)(base+HEX0_BASE); //peripheral exists at the base address plus the specific offset
	 hex1=(uint32_t*)(base+HEX1_BASE); 
	 hex2=(uint32_t*)(base+HEX2_BASE); 
	 hex3=(uint32_t*)(base+HEX3_BASE); 
	 hex4=(uint32_t*)(base+HEX4_BASE);
	 hex5=(uint32_t*)(base+HEX5_BASE); 
	  
	 signal(SIGINT, handler); //handles CTRL+C
	 //*hex=0x1; //by writing a value to this address, you can directly control the devices!
	
     
   	
 
    while(1)
    {
         
         //clear output buffer in gcc
        fflush(stdout);
         
         //increase second
        second++;
 
        //update hour, minute and second
        if(second==60){
            minute+=1;
            second=0;
        }
        if(minute==60){
            hour+=1;
            minute=0;
        }
        if(hour==24){
            hour=0;
            minute=0;
            second=0;
        }
        
        
        h2 = hour % 10;
        h1 = hour / 10;
        
        m2 = minute % 10;
        m1 = minute / 10;
        
        s2 = second % 10;
        s1 = second / 10;
        
        *hex0 = s1; // dont think this is gonna work given point = int
        *hex1 = s2;
        *hex2 = m1;
        *hex3 = m2;
        *hex4 = h1;
        *hex5 = h2;

        sleep(1);
    }
}
