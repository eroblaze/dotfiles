#ifndef DEBUG_H
#define DEBUG_H

// -----------------------------------------------------------------------------
// DEBUG.H
// A lightweight, header-only debugging utility for C++
// Provides pretty-printing for most STL containers and a simple dbg(...) macro
// for structured logging (file, line, variable names, and values).
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// SUPPORTED DATA STRUCTURES FOR PRINTING
// -----------------------------------------------------------------------------
// ✅ Primitive types (int, double, char, bool, etc.)
// ✅ std::string
// ✅ std::pair<A, B>
// ✅ std::tuple<...> (any size)
// ✅ std::bitset<N>
//
// ✅ Generic iterable containers:
//    - std::vector<T>
//    - std::set<T>
//    - std::multiset<T>
//    - std::map<K, V>
//    - std::multimap<K, V>
//    - std::unordered_set<T>
//    - std::unordered_multiset<T>
//    - std::unordered_map<K, V>
//    - std::unordered_multimap<K, V>
//
// ✅ Sequential containers (special handling):
//    - std::deque<T>
//    - std::queue<T>
//    - std::stack<T>
//    - std::priority_queue<T>
//
// ⚙️ Works recursively for nested containers, e.g.:
//    - std::vector<std::pair<int, int>>
//    - std::map<int, std::vector<int>>
//    - std::queue<std::set<std::string>>
// -----------------------------------------------------------------------------

#include <algorithm>
#include <bitset>
#include <deque>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <type_traits>
#include <vector>

// -----------------------------------------------------------------------------
// FORWARD DECLARATIONS
// To break the circular dependency where the container printer needs the pair/tuple
// printer, and the pair/tuple printer might need the container printer.
// -----------------------------------------------------------------------------
template <typename A, typename B> std::ostream &operator<<(std::ostream &os, const std::pair<A, B> &p);

template <typename... Args> std::ostream &operator<<(std::ostream &os, const std::tuple<Args...> &t);

// -----------------------------------------------------------------------------
// Print general iterable containers (e.g., vector, set, map, etc.)
// Defined early to be visible by other printers.
// -----------------------------------------------------------------------------
template <typename T_container,
          // SFINAE check: This overload is only enabled for types that are not std::string
          // and have a nested `iterator` type, which is a good proxy for being an iterable container.
          typename = typename std::enable_if<!std::is_same<T_container, std::string>::value>::type,
          typename = typename T_container::iterator>
std::ostream &operator<<(std::ostream &os, const T_container &v) {
  os << '{';
  std::string sep;
  // Use `const auto&` for the loop variable for maximum compatibility and safety.
  for (const auto &x : v) {
    os << sep << x;
    sep = ", ";
  }
  return os << '}';
}

// -----------------------------------------------------------------------------
// Print std::bitset<N>
// -----------------------------------------------------------------------------
template <size_t N> std::ostream &operator<<(std::ostream &os, const std::bitset<N> &b) {
  for (size_t i = 0; i < N; ++i) { os << (b.test(N - 1 - i) ? '1' : '0'); }
  return os;
}

// -----------------------------------------------------------------------------
// Print std::pair as (first, second)
// -----------------------------------------------------------------------------
template <typename A, typename B> std::ostream &operator<<(std::ostream &os, const std::pair<A, B> &p) {
  return os << '(' << p.first << ", " << p.second << ')';
}

// -----------------------------------------------------------------------------
// Print std::tuple of any size: (a, b, c, ...)
// -----------------------------------------------------------------------------
template <typename Tuple, std::size_t... Is>
void print_tuple_impl(std::ostream &os, const Tuple &t, std::index_sequence<Is...>) {
  ((os << (Is == 0 ? "" : ", ") << std::get<Is>(t)), ...);
}

template <typename... Args> std::ostream &operator<<(std::ostream &os, const std::tuple<Args...> &t) {
  os << '(';
  print_tuple_impl(os, t, std::index_sequence_for<Args...>{});
  return os << ')';
}

// -----------------------------------------------------------------------------
// Print std::queue (copying elements to avoid modifying the original queue).
// -----------------------------------------------------------------------------
template <typename T> std::ostream &operator<<(std::ostream &os, std::queue<T> q) {
  os << '{';
  std::string sep;
  while (!q.empty()) {
    os << sep << q.front();
    q.pop();
    sep = ", ";
  }
  return os << '}';
}

// -----------------------------------------------------------------------------
// Print std::deque
// -----------------------------------------------------------------------------
template <typename T> std::ostream &operator<<(std::ostream &os, const std::deque<T> &dq) {
  os << '{';
  std::string sep;
  for (const T &x : dq) os << sep << x, sep = ", ";
  return os << '}';
}

// -----------------------------------------------------------------------------
// Print std::stack (copies to preserve original order).
// -----------------------------------------------------------------------------
template <typename T> std::ostream &operator<<(std::ostream &os, std::stack<T> s) {
  os << '{';
  std::string sep;
  std::vector<T> temp;
  while (!s.empty()) temp.push_back(s.top()), s.pop();
  std::reverse(temp.begin(), temp.end());
  for (const T &x : temp) os << sep << x, sep = ", ";
  return os << '}';
}

// -----------------------------------------------------------------------------
// Print std::priority_queue (copies since it has no iterators).
// -----------------------------------------------------------------------------
template <typename T> std::ostream &operator<<(std::ostream &os, std::priority_queue<T> pq) {
  os << '{';
  std::string sep;
  while (!pq.empty()) {
    os << sep << pq.top();
    pq.pop();
    sep = ", ";
  }
  return os << '}';
}

// -----------------------------------------------------------------------------
// Variadic debug printer: prints multiple values separated by spaces
// Example: dbg_out(1, "abc", vector<int>{2,3}) → "1 abc {2, 3}"
// -----------------------------------------------------------------------------
inline void dbg_out() { std::cerr << std::endl; }

template <typename Head, typename... Tail> void dbg_out(Head H, Tail... T) {
  std::cerr << ' ' << H;
  dbg_out(T...);
}

// -----------------------------------------------------------------------------
// dbg(...) macro
// Prints:
// [<file>:<line>] (<variable names>): <values>
//
// Example:
// int x = 5; std::vector<int> v = {1,2,3};
// dbg(x, v);
// → [main.cpp:25] (x, v): 5 {1, 2, 3}
// -----------------------------------------------------------------------------
#define dbg(...) std::cerr << '[' << __FILE__ << ':' << __LINE__ << "] (" << #__VA_ARGS__ << "):", dbg_out(__VA_ARGS__)

#endif // DEBUG_H
