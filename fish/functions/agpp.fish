function agpp
  g++ -std=gnu++17 -Wall -Wextra -O2 -DONLINE_JUDGE \
    -I/opt/boost/gcc/include -L/opt/boost/gcc/lib -I/opt/ac-library \
    -o ./a.out $argv;
  and ./a.out
end
