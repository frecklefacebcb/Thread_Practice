/**
 * @file time_thread.c
 *
 * @author kelly.hathaway
 * @date Initial: Dec 31, 2015
 * @version 1
 * @date Released: Not Released
 * @details
 */


#include <pthread.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


void * timer_thread(void *p_unused)
{
    static const clock_t CLK_INTERVAL = CLOCKS_PER_SEC;
    static const unsigned int MAX_COUNT = 10;
    clock_t mark;
    unsigned int count;

    for(count = 0; count < MAX_COUNT; count++)
    {
        printf("Time %i\n", count);
        mark = clock();
        while(clock() < (mark + CLK_INTERVAL));
    }
    printf("Finished!\n");

    pthread_exit(NULL);
}


int main(int argc, char **argv)
{
    pthread_t thread;
    int rc;
    char in = 0;

    rc = pthread_create(&thread, NULL, timer_thread, NULL);
    if(rc)
    {
        printf("ERROR; return code from pthread_create() is %d\n", rc);
        exit(-1);
    }

    while(in != 'q')
    {
        scanf("%c", &in);
    }

    pthread_exit(NULL);
}
