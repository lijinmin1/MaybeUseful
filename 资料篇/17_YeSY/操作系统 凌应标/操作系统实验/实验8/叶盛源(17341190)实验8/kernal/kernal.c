#include "PCB.h"

extern void cls();
extern char Readchar();
extern void printChar();
extern void RunProm();
extern void loadListFromDisk();
extern void loadbatchFromDisk();
extern void readList();
extern void readbatch();

extern void another_RunProm(int segment,int offset);/*并发执行的加载用户程序过程*/
extern void RunTestProm(int segment,int offset);
extern void setClock();/*设置时钟中断的时间*/

void init_Pro(int flag);

int flag;
int leave_batch;
char in;
char * str;
char command[100];

int sector_number;/*用户程序所在扇区号码*/

void printf(char* str)
{
    int i=0;
    while(str[i])
    {
        printChar(str[i]);
        i++;
    }
}
int if_equal(char* a,char* b)
{
    int i=0,j=0;
    while(a[i]!=0&&b[j]!=0)
    {
        if(a[i]!=b[j])
            return 0;
        i++;
        j++;
    }
    if(a[i]==0&&b[j]==0)
        return 1;
    else
        return 0;
}
void Readcommand(char* command)
{
    int i=0;
    Readchar();
    while(in!=13)
    {
        if(in==8)
        {
            if(i==0) 
            {
                printChar(in);
                printChar('>');
                Readchar();
                continue;
            }
            printChar(in);
            printChar(32);
            i--;
            printChar(in);
            Readchar();
            continue;
        }
        printChar(in);
        command[i]=in;  
        i++;
        Readchar();
    }
    command[i]='\0';
}
void Delay2()
{
	int i = 0;
	int j = 0;
	for( i=0;i<10000;i++ )
		for( j=0;j<10000;j++ )
		{
			j++;
			j--;
		}
}

void Random_Load(char * com)
{
    int i=2;/*从指令第三个字符开始看选择的用户程序*/
    int num;
    int count=0;
    while(com[i]!='\0'&&(com[i]>=0+'0'&&com[i]<=9+'0'))
    {
        num=com[i]-'0';
        if( Segment > 0x6000 )
        {
            printf("\r\nThere have been 4 Processes !");
            break;
        }
        sector_number=num;/*用户程序所在扇区号码*/
        another_RunProm(Segment,sector_number); /*加载这个程序进入内存*/
        Segment+=0x1000;/*下一次加载就到下一个64k内存空间里了*/
        count++;
        /* Program_Num++;/* 加载进入内存后当前正在运行程序数量加一*/
        i++;
        /* 进程编号加1，同时修改Used的值代表这个块被使用 */
        pcb_list[count].Used = 1;
    }
    if(com[i]!='\0')
    {
        printf("\r\nPlease enter correct instructions");
    }
    Program_Num=count;
}
/* 测试程序默认放在第一个PCB块中 */
void run_testPro_EX7()
{
    sector_number=7;
    RunTestProm(Segment,sector_number);
    Segment+=0x1000;
    Program_Num=1;
    pcb_list[1].Used = 1;
}

/* 测试程序默认放在第一个PCB块中 */
void run_testPro_EX8()
{
    sector_number=1;
    RunTestProm(Segment,sector_number);
    Segment+=0x1000;
    Program_Num=1;
    pcb_list[1].Used = 1;
}



void Menu()
{
    printf("=================================================================\n\r");
    printf("|                       Welcome to my OS!                       |\n\r");
    printf("|                     Build on March 25 2018                    |\n\r");
    printf("|          Author:Ye Shengyuan & Student Number:17341190        |\n\r");
    printf("=================================================================\n\r");
    printf("Please enter instruction below. Enter -h to view instruction list\n\r");
    printf("Please enter -test to test project 8 testfile\r\n");
}
void help()
{
    printf("\n\r-h:view instruction list\n\r");
    printf("-cls:clear the display\n\r");
    /*printf("-p1:run the user program 1\n\r");
    printf("-p2:run the user program 2\n\r");
    printf("-p3:run the user program 3\n\r");
    printf("-p4:run the user program 4\n\r");
    printf("-p5:run the user program 5\n\r");*/
    printf("-p1234:run the uer program 1 2 3 4 at the same time\n\r");
    printf("-test:run the test program of EX8\r\n");
    printf("-ls:show the file list\n\r");
    printf("-b:begin processing batch\n\r");
    printf("-q:exit the operating system\n\r");
}
void list()
{
    char name[10];
    char size[10];
    int sector;
    int i=1;
    int j=0;
    int x;
    int count;
    readList(0);
    count=str[0];
    name[9]='\0';
    size[9]='\0';
    printf("\n\rTotal Files:");
    printChar(count+'0');
    printf("\n\r FileName     FileSize\n\r");
    while(count--)
    {
        j=0;
        for(x=0;x<9;x++)
        {
            name[x]=32;
            size[x]=32;
        }
        while(str[i]!=0)
        {
            name[j]=str[i];
            j++;
            i++;
        }
        i++,j=0;
        while(str[i]!=0)
        {
            size[j]=str[i];
            j++;
            i++;
        }
        size[j]='B';
        i=i+3;
        printChar(6-count-1+'0');
        printf(".");
        printf(name);
        printf("   ");
        printf(size);
        printf("\n\r"); 
    }
}
void runcommand(char * com)
{
    if(if_equal(com,"-h"))
    {
        help();
    }
    else if(if_equal(com,"-cls"))
    {
        cls();
    }
    else if(com[0]=='-'&&com[1]=='p')
    {
        printf("\r\nPlease enter -test to test project 8 testfile");
        return;
        cls();
        Random_Load(com);
        Delay2();
        cls();
    }
    else if(com[0]=='-'&&com[1]=='t'&&com[2]=='e'&&com[3]=='s'&&com[4]=='t')
    {
        cls();
        run_testPro_EX8();
        Delay2();
        cls();
    }
    else if(if_equal(com,"-b"))
    {
        cls();
        printf("please enter your instructions queue.\n\rPlease separate instructions by Spaces.Enter -qb to leave batch processing.\n\r");
        Readcommand(command);
        batch(command);
    }
    else if(if_equal(com,"-ls"))
    {
        list();
    }
    else if(if_equal(com,"-q"))
    {
        flag=0;
    }
    else if(if_equal(com,"-qb"))
    {
        leave_batch=0;
    }
    else {
        printf("\r\nPlease enter correct instructions");
    }
}


batch(char* com){
    int i;
    int j;
    char subcommand[10];
    flag=1;
    i=0;
    j=0;
    leave_batch=1;
    while(com[i]!='\0'&&flag&&leave_batch)
    {
        if(com[i]!=32)
        {
            subcommand[j]=com[i];
            i++;
            j++;
        }
        else
        {
            subcommand[j]='\0';
            runcommand(subcommand);
            init_Pro(0);
            i++;
            j=0;
        }
    }
    if(com[i]=='\0')
    {
        subcommand[j]='\0';
        runcommand(subcommand);
    }
}

void init_Pro(int flag)  /*创建内核和4个用户程序的PCB块*/
{
    if(flag==1)
	    init(&pcb_list[0],0x1000,0x100);
	init(&pcb_list[1],0x2000,0x100);
	init(&pcb_list[2],0x3000,0x100);
	init(&pcb_list[3],0x4000,0x100);
	init(&pcb_list[4],0x5000,0x100);
}


cmain(){
    /*loadListFromDisk(); */ 
    /* loadbatchFromDisk();*/
    setClock();

    init_Pro(1);/*创建内核和4个用户程序的PCB块*/
    initsema();/* 初始化实验8中要使用的信号量 */
    cls();
    /*
    readbatch();
    batch(str);
    cls();
    */

    Menu();
    flag=1;
    while(flag)
    {  
        init_Pro(0);/*创建4个用户程序的PCB块 ，每次循环都初始化更新一次*/
        printf("\n\r>>");
        Readcommand(command);
        runcommand(command);
    }
    cls();
    printf("\n\rThank you for using!\n\rBye-Bye!\n\r");
    Readchar();
}

