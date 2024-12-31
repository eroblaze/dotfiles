// @eroblaze
#include <bits/stdc++.h>
using namespace std;

#ifdef ERO_LOCAL
#include "algo/debug.h"
#else
#define dbg(...)
#endif

int main() {
  ios_base::sync_with_stdio(false), cin.tie(0);
  mt19937 rng(chrono::steady_clock::now().time_since_epoch().count());
  auto rnd = [&](int a, int b) { return a + rng() % (b - a + 1); };

  return 0;
}
