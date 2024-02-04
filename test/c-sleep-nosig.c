#include &lt;stdio.h&gt;
#include &lt;unistd.h&gt;

int main(int argc, char *argv[])
{
       printf("Process is sleeping\n");
       while (1) {
              sleep(100);
       }

       return 0;
}
