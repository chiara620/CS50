#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Prompt for start size
    int startsize;
    do
    {
        startsize = get_int("Start size: ");
    }
    while (startsize < 9);


    // Prompt for end size
    int endsize;
    do
    {
        endsize = get_int("End size: ");
    }
    while (endsize <= startsize);


    // Calculate number of years until we reach threshold
    int years = 0;
    while (startsize < endsize)
    {
        startsize = startsize + startsize / 3 - startsize /4;
        years++;
    }


    // Print number of years
    printf("Years: %i\n", years);
}