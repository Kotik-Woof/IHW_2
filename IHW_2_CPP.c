#include <stdio.h>
#include <stdlib.h>
#include <string.h>
const int max_length = 10;// кол-во символов, которое используется для ввода размера массива

long inputNumber(long count) {
    char buf[max_length];// временная переменная
    char is_correct;     // проверка на корректность
    long number;         // число
    do {                 // пока пользователь не введёт число, продолжаем ввод
        gets(buf);
        number = atol(buf);
        if (number == 0 && buf[0] != '0') {
            printf("You input a not number.\nnumber = ");
            is_correct = 'F';
        } else if (number > count) {
            printf("You input a number which more than length of text.\nnumber = ");
            is_correct = 'F';
        } else if (number < 0) {
            printf("A negative number cannot be the number of a text element.\nnumber = ");
            is_correct = 'F';
        } else {
            is_correct = 'T';
        }
    } while (is_correct == 'F');

    return number;
}

int main() {
    int symbol;
    int count = 0;
    size_t size = 10000;// допустимое кол-во символов
    printf("Enter text (To complete the text input, type ^END^): ");
    char *stroka = malloc(size);                         // массив, куда будет записываться строка
    while ((symbol = getchar()) != -1 || count < size) {// записали символы в "строку"
        stroka[count] = (char) symbol;
        count++;
        if (stroka[count - 1] == '^' && stroka[count - 2] == 'D' && stroka[count - 3] == 'N' && stroka[count - 4] == 'E' && stroka[count - 5] == '^') {
            count -= 5;
            break;
        }
    }
    getchar();

    // вывод исходной строки
    printf("-----------------\n");
    for (int i = 0; i < count; ++i) {
        printf("%c", stroka[i]);
    }
    printf("-----------------\n");

    printf("\nEnter the segment you want to flip (0, %d)\n", count - 1);
    long N1 = 0, N2 = 0;
    printf("Enter the first number = ");
    N1 = inputNumber(count-1);  // отнимаем единицу, так как работаем с индексами
    printf("\nEnter the second number = ");
    N2 = inputNumber(count-1);


    if (N1 > N2) {// обмен значениями
        long temp = N1;
        N1 = N2;
        N2 = temp;
    }

    char *result_string = malloc(N2 - N1 + 1);

    // переворот участка текста
    for (long i = N2, index = 0; i >= N1; i--, index++) {
        result_string[index] = stroka[i];
    }

    // вывод перевёрнутой строки
    for(int i = 0; i < N2 - N1 + 1; i++) {
        putchar(result_string[i]);
    }
    printf("\n");

    printf("finish.\n");
    free(stroka);
    return 0;
}
