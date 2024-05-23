#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <math.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);

int main(void)
{
    string text = get_string("Text: ");

    float nol = count_letters(text);
    float now = count_words(text);
    float nos = count_sentences(text);

    float L = 100 * (nol / now);
    float S = 100 * (nos / now);
    int index = round(0.0588 * L - 0.296 * S - 15.8);

    if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (index >= 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %i\n", index);
    }
}



int count_letters(string text)
{
    int nol = 0;   // nol: number of letters
    for (int i = 0, len = strlen(text); i < len; i++)
    {
        if (isalpha(text[i]))
        {
            nol++;
        }
    }
    return nol;
}


int count_words(string text)
{
    int now = 1;   // now: number of words
    for (int j = 0, len = strlen(text); j < len; j++)
    {
        if (text[j] == 32)
        {
            now ++;
        }
    }
    return now;
}


int count_sentences(string text)
{
    int nos = 0;   // nos: number of sentences
    for (int y = 0, len = strlen(text); y < len; y++)
    {
        if (text[y] == 46 || text[y] == 33 || text[y] == 63)
        {
            nos++;
        }
    }
    return nos;
}