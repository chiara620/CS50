#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Prompt for height
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);

    // Prompt for building
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < height; j++)
            if (i + j >= height - 1)
            {
                printf("#");
            }
            else
            {
                printf(" ");
            }
        printf("\n");
    }
}