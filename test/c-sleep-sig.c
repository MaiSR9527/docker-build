#include &lt;stdio.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;sys/types.h&gt;
#include &lt;sys/wait.h&gt;
#include &lt;unistd.h&gt;

void sig_handler(int signo)
{
    if (signo == SIGTERM) {
           printf("received SIGTERM\n");
           exit(0);
    }
}

int main(int argc, char *argv[])
{
    signal(SIGTERM, sig_handler);

    printf("Process is sleeping\n");
    while (1) {
           sleep(100);
    }
    return 0;
}
