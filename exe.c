

#include <unistd.h>

void exe()
{
    char *cmd = "/bin/sh";
    char *argv[2] = { cmd+5, 0 };
    //execl("/bin/sh", "sh", NULL);
    execve(cmd, argv, 0);
}
