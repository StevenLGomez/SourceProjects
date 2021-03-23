
/**
 * hd - hex dump utility 
 */

// May be compiled with MinGW (g++) using:
// g++ -ansi -Wall -static-libgcc -static-libstdc++ hd.cpp -o hd.exe 

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

const size_t DisplayedWidth = 24;

// function prototype for support function
void hexDump(FILE *);

int main(int argc, char *argv[])
{
    FILE *inputFile;

    if (argc < 2)
    {
        printf("hd (hex dump) utility - Dumps binary files in hex format with text when available\n");
        printf("USAGE: hd filename\n");
        exit(0);
    }

    if ((inputFile = fopen(argv[1], "rb")) == NULL)
    {
        printf("ERROR: Cannot open %s\n", argv[1]);
        exit(0);
    }

    // If you get to this point, the file name has been entered and is opened
    printf(":::  %s  :::\n", argv[1]);

    hexDump(inputFile);

    fclose(inputFile);
    return 0;
}

/**
 * hexDump -- does the actual hex dump of the file
 *
 */

void hexDump(FILE *fp)
{
    long rowAddress = 0;
    unsigned char buffer[DisplayedWidth + 1];   // Buffer for each line of data from file
    size_t n, i;

    while ((n = fread(buffer, 1, DisplayedWidth, fp)) > 0)
    {
        // Display the start address of this row
        printf("%08lX  ", rowAddress);

        // Display this row of hex values
        for (i = 0; i < n; i++)
        {
            printf("%02X", buffer[i]);
            if ((i % 2) == 1) putchar(' ');
        }

        // Fill in the rest of the row of hex data with spaces if not a full line
        if (i < DisplayedWidth)
        {
            for ( ; i < DisplayedWidth; i++) 
            {
                printf("  ");
                if ((i % 2) == 1) putchar(' ');
            }
        }

        // Display printable characters that match hex pairs from above.
        // If not printable, display a period.
        for (i = 0; i < n; i++)
        {
            if (isprint(buffer[i])) putchar(buffer[i]);
            else putchar('.');
        }

        rowAddress += (long)n;
        putchar('\n');
    }

}

