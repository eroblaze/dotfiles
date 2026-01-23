// @eroblaze
#include <bits/stdc++.h>
using namespace std;

int main() {
  ios_base::sync_with_stdio(false), cin.tie(0);
  mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());
  auto rnd = [&](int64_t a, int64_t b) {
    uniform_int_distribution<int64_t> dist(a, b);
    return dist(rng);
  };

  return 0;
}
