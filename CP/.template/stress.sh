for ((i = 1; i <= 100; ++i)); do
  echo $i
  ./gen >int
  ./usaco2 <int >out1
  ./correct <int >out2
  diff -w out1 out2 || break
  # diff -w <(./a <int) <(./brute <int) || break
done
