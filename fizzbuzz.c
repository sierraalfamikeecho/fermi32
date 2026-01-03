#include <stdbool.h>
#include <stdio.h>

//Need to modify to print to debugger once cpu is implemented
bool fizzbuzz(int);
bool fizz(int);
bool buzz(int);

bool fizz(int i) {
    return (i % 3) == 0;
}

bool buzz(int i) {
    return (i % 5) == 0;
}

bool fizzbuzz(int i) {
    return fizz(i) && buzz(i);
}

int main() {
    int a = 15;

    if (fizzbuzz(a)) {
            printf("Fizzbuzz");
        }
    else if (fizz(a)) {
        printf("Fizz");
    }
    else if (buzz(a)) {
        printf("Buzz");
    }

}
