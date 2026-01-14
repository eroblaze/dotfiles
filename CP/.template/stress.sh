for ((i = 1; i <= 100; ++i)); do
  echo $i
  ./gen >int
  ./us <int >us_out
  ./brute <int >brute_out
  diff -w us_out brute_out || break
  # diff -w <(./a <int) <(./brute <int) || break
done
