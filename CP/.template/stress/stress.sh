#!/usr/bin/env bash

# Loop from 1 to 100
for ((i = 1; i <= 100; ++i)); do
  echo "Test Case: $i"

  # 1. Generate random input
  ./gen >gen_input

  # 2. Run the main solution (located in the parent directory)
  ../sol <gen_input >sol_output

  # 3. Run the brute force solution
  ./brute <gen_input >brute_output

  # 4. Compare results using custom output script if available, else diff
  if command -v output >/dev/null 2>&1; then
    # Use custom script
    output sol_output brute_output || break
  else
    # Fallback to standard diff
    diff -w sol_output brute_output || break
  fi
done
