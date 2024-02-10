# Функциональное программирование. Лабораторная работа №1

Вариант: 9, 22

Цель: освоить базовые приёмы и абстракции функционального программирования: функции, поток управления и поток данных,
сопоставление с образцом, рекурсия, свёртка, отображение, работа с функциями как с данными, списки.

В рамках лабораторной работы вам предлагается решить несколько задач [проекта Эйлер](https://projecteuler.net/archives).
Список задач -- ваш вариант.

Для каждой проблемы должно быть представлено несколько решений:

1. монолитные реализации с использованием:
    - хвостовой рекурсии;
    - рекурсии (вариант с хвостовой рекурсией не является примером рекурсии);
2. модульной реализации, где явно разделена генерация последовательности, фильтрация и свёртка (должны использоваться
   функции reduce/fold, filter и аналогичные);
3. генерация последовательности при помощи отображения (map);
4. работа со спец. синтаксисом для циклов (где применимо);
5. работа с бесконечными списками для языков, поддерживающих ленивые коллекции или итераторы как часть языка (к примеру
   Haskell, Clojure);
6. реализация на любом удобном для вас традиционном языке программирования для сравнения.

Требуется использовать идиоматичный для технологии стиль программирования.

Содержание отчёта:

- титульный лист;
- описание проблемы;
- ключевые элементы реализации с минимальными комментариями;
- выводы (отзыв об использованных приёмах программирования).

Примечания:

- необходимо понимание разницы между ленивыми коллекциями и итераторами;
- нужно знать особенности используемой технологии и того, как работают использованные вами приёмы.

## Задача 9. Largest Prime Factor

<p>a^2 + b^2 = c^2, где a < b < c </p>
<p>Найти abc если a+b+c = 1000</p>

https://projecteuler.net/problem=9

### Реализация на C

```C
#include <stdio.h>
#include <time.h>
int main()
{
  unsigned int i,j,t,n;
  long ans;
  scanf("%u",&t);
  while(t>0)
  {
    ans =-1;
    i=2;
    j=1;
    scanf("%u",&n);
    while(1)
    {
      int s = 2*i*i+2*i*j;
      if(s ==n )
      {
        long k = 2*i*j*(i*i+j*j)*(i*i-j*j);
        if (ans<k) ans =k;
        if(i>j+1) j++;
        else
        {
          j=1;
          i++;
        }
      }
      else if(s>n)
      {
        if(j==1) goto end;
        j=1;
        i++;
      }
      else
      {
        int new;
        for(new =2; s*new<=n;new++)
        {
          if(s*new == n)
          {
            long k = 2*i*j*(i*i+j*j)*(i*i-j*j)*new*new*new;
            if (ans<k) ans =k; 
          }
        }
        if(i>j+1) j++;
        else 
        {
          j=1;
          i++;
        }
      }
    }
    end: printf("%li\n",ans);
    t--;
  }
  return 0;
}
```

Результат:

```200 375 425```

### Реализация c рекурсией

```erlang
special_pyth_trip_r(K)->
    special_pyth_trip_r(1, 1, K).

special_pyth_trip_r(A, B, K)->
    C = math:pow(A*A + B*B, 0.5),
    if  A + B + C == K ->
            {A, B, C};
        A + B + C < K ->
            special_pyth_trip_r(A, B+1, K);
        A + B > K->
            {};
        A + B + C > K ->
            special_pyth_trip_r(A+1, A+1, K)
    end.
```

### Реализация с хвостовой рекурсией

```erlang
special_pyth_trip(K)->
    special_pyth_trip(1, 1, math:pow(2, 0.5), K).

special_pyth_trip(A, B, C, K) when A + B + C == K -> {A, B, C};
special_pyth_trip(A, B, C, K) when A + B + C < K -> special_pyth_trip(A, B+1, math:pow(A*A + (B+1)*(B+1), 0.5), K);
special_pyth_trip(A, B, C, K) when A + B > K -> {};
special_pyth_trip(A, B, C, K)-> special_pyth_trip(A+1, A+1, math:pow(2*(A+1)*(A+1), 0.5), K).
```

### Реализация со свёрткой

```erlang
% Fold
is_spicial({A, B, C, K}, {}) when A + B + C == K -> {A, B, C};
is_spicial(_, Acc)-> Acc.

get_fold_special_list(K)-> get_fold_special_list(1, 1, math:pow(2, 0.5), K).

get_fold_special_list(A, B, C, K) when B < K/2-> [{A, B, C, K}| get_fold_special_list(A, B+1, math:pow(A*A + (B+1)*(B+1), 0.5), K)];
get_fold_special_list(A, B, C, K) when A < K/2-> [{A, B, C, K}| get_fold_special_list(A+1, A+1, math:pow(2*(A+1)*(A+1), 0.5), K)];
get_fold_special_list(A, B, C, K) -> [].

special_pyth_trip_f(K)->
    lists:foldl(fun({A, B, C, K1}, Acc)->is_spicial({A, B, C, K1}, Acc) end, {},
    get_fold_special_list(K)).
```

## Задача 22. Number Spiral Diagonals

<p>Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.</p>
<p>What is the total of all the name scores in the file?</p>

https://projecteuler.net/problem=22

### Реализация на C

```C
#include <stdio.h> 
#include <ctype.h>
#include <stdlib.h>

struct str{
    char name[12];
};

char a[12];

int namevalue(char *s)
{
    int i, sum;
    i = sum = 0;
    while(s[i]) {
        sum += (s[i] - 'A' + 1);
        i++;
    }
    return sum;
}

int cmp(const void *a, const void *b)
{
    return strcmp((*(struct str*)a).name, (*(struct str*)b).name);
}

void solve(void)
{
    FILE *fp;
    int i, j, k;
    char *s, c;
    long long sum = 0;

    struct str namestring[5163];

    fp = fopen("0022_names.txt", "r");
    fseek(fp, 0, SEEK_END);
    int file_size;
    file_size = ftell(fp);
    fseek(fp, 0, SEEK_SET);
    s = (char*)malloc(file_size * sizeof(char));
    fread(s, sizeof(char), file_size, fp);

    i = j = k = 0;
    while(i <= file_size) {
        c = s[i++];
        if(!isalpha(c)) {
            if(c == ',') {
                j = 0;
                strcpy(namestring[k++].name, a);
                memset(a,'\0',12 * sizeof(char));
            }
        } else {
            a[j++] = c;
        }
    }
    strcpy(namestring[k].name, a);
    memset(a,'\0',12 * sizeof(char));

    qsort(namestring, 5163, sizeof(namestring[0]),cmp);

    for(i = 0; i <= 5162; i++) {
        sum += (namevalue(namestring[i].name) * (i + 1));
    }
    printf("%lld\n",sum);
}

int main(void)
{
    solve();    
    return 0;
}
```

Результат:

```850081394```

### Общая часть кода c чтенимем из файла

```erlang
read_list_from_file()->
    {ok, Data} = file:read_file("0022_names.txt"),
    List = string:tokens(binary:bin_to_list(Data), ",\"").

word_sum(Word)->word_sum(Word, 0).

word_sum([], Acc)->Acc;
word_sum([Head|Tail], Acc)-> word_sum(Tail, Acc + Head-64).
```

### Реализация с рекурсией

```erlang
names_score_r()->
    names_score_r(read_list_from_file()).

names_score_r([])-> 0;
names_score_r([Head|Tail])->names_score_r(Tail) + word_sum(Head).
```

### Реализация с хвостовой рекурсией и filter

```erlang
names_score()->
    names_score(0, read_list_from_file()).

names_score(Acc, [])-> Acc;
names_score(Acc, [Head|Tail])->names_score(Acc + word_sum(Head),Tail).
```

### Реализация со свёрткой

```erlang
names_score_f()->
    lists:foldl(fun word_sum/2, 0,
    read_list_from_file()).
```

## Выводы

В ходе выполнения работы я ознакомился с языком Erlang и базовыми принципами функционального программирования.
Я реализовал две задачи из проекта Эйлер в нескольких вариантах: с обычной рекурсией, с хвостовой, со свёрткой (fold) с отображением (map).
Во второй задаче была использована библиотке file для чтения данных из файла.
В обоих задача использовались библиотечные функции для листа. К реализациям были написаны тесты.
Также для сравнения обе задачи были реализованы также на языке C.