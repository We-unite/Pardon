#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#define DELETE_COMMAND "del"
#else
#define DELETE_COMMAND "rm -rf"
#endif


int main(int argc, char* argv[])
{
    char* command;
    if(argc!=2)
    {
        printf("Number of parameters Wrong!\n");
        printf("Usage: runjv <filename>\n");
        return 1;
    }
    command=(char*)malloc(sizeof(char)*(strlen(argv[1])+10));

    char* classname=strtok(argv[1],".");

    sprintf(command,"javac %s.java",classname);
    int command_status=system(command);

    if(command_status!=0)
    {
        printf("Compile Failed!\n");
        return -1;
    }
    sprintf(command,"java %s",classname);
    system(command);

    sprintf(command,"%s %s.class",DELETE_COMMAND,classname);
    system(command);
    return 0;
}
