// @eroblaze
#include "bits/stdc++.h"
using namespace std;

template <typename A, typename B> ostream &operator<<(ostream &os, const pair<A, B> &p) {
  return os << '(' << p.first << ", " << p.second << ')';
}
template <typename T_container,
          typename T = typename enable_if<!is_same<T_container, string>::value, typename T_container::value_type>::type>
ostream &operator<<(ostream &os, const T_container &v) {
  os << '{';
  string sep;
  for (const T &x : v)
    os << sep << x, sep = ", ";
  return os << '}';
}

void dbg_out() { cerr << endl; }
template <typename Head, typename... Tail> void dbg_out(Head H, Tail... T) {
  cerr << ' ' << H;
  dbg_out(T...);
}
#ifdef ERO_DEBUG
#define dbg(...) cerr << '[' << __FILE__ << ':' << __LINE__ << "] (" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)
#else
#define dbg(...)
#endif

#define len(x) (int)(x).size()
#define all(x) x.begin(), x.end()

using ll = int64_t;
using pii = pair<int, int>;
using tiii = tuple<int, int, int>;
using vb = vector<bool>;
using vc = vector<char>;
using vs = vector<string>;
using vi = vector<int>;
using vll = vector<ll>;
using vvi = vector<vi>;
using vvll = vector<vll>;
using vvc = vector<vc>;
using vvb = vector<vb>;
using vpii = vector<pii>;
using vtiii = vector<tiii>;

const vpii dirs{{-1, 0}, {1, 0}, {0, 1}, {0, -1}};                                         // For GRAPHS
const vpii dirs_ext{{-1, 0}, {1, 0}, {0, 1}, {0, -1}, {-1, 1}, {1, 1}, {1, -1}, {-1, -1}}; // For GRAPHS
const char nl = '\n';
const int inf = (int)2e8 + 5;

// Reads input into a vector
template <typename T> void read(T &, int);
// Prints out the content of a vector
template <typename T_vector> void output_vector(const T_vector &, bool = 0, int = -1, int = -1);

void solve() {
  int n;
  cin >> n;
}

int main() {
  ios_base::sync_with_stdio(0), cin.tie(0);

  int t = 1;
  // cin >> t;
  while (t--) {
    solve();
  }

  return 0;
}

template <typename T> void read(T &vec, int sz) {
  vec.resize(sz);
  for (int i = 0; i < sz; ++i)
    cin >> vec[i];
}

template <typename T_vector> void output_vector(const T_vector &v, bool add_one, int start, int end) {
  if (start < 0)
    start = 0;
  if (end < 0)
    end = int(v.size());

  for (int i = start; i < end; i++)
    cout << v[i] + (add_one ? 1 : 0) << (i < end - 1 ? ' ' : '\n');
}
