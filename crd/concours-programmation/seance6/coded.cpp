/*
* Author:  Léopold Bernard
* Created: 01/04/2025 14:35:57
*/

#include <cstdio>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <deque>
#include <unordered_map>
#include <map>
#include <unordered_set>
#include <set>
#include <stack>
#include <queue>
#include <complex>
#include <string>
#include <vector>
#include <array>
#include <random>

using namespace std;

#define pb push_back
#define mt make_tuple
#define mp make_pair
#define fi first
#define se second

#define all(c) (c).begin(), (c).end()
#define sz(x) (int)(x).size()
#define nl "\n"

template<class T> inline bool chmax(T& a, T b) { if (a < b) { a = b; return 1; } return 0; }
template<class T> inline bool chmin(T& a, T b) { if (a > b) { a = b; return 1; } return 0; }

template<class T> long long sum(const T& a){ return accumulate(a.begin(), a.end(), 0LL); }
template<class T> auto min(const T& a){ return *min_element(a.begin(), a.end()); }
template<class T> auto max(const T& a){ return *max_element(a.begin(), a.end()); }


typedef vector<int> vi;
typedef vector<double> vd;
typedef vector<bool> vb;
typedef long long ll;
typedef long double ld;
typedef unsigned int ui;
typedef unsigned long long ull;
typedef pair<int, int> pii;
typedef pair<long long, long long> pll;
typedef vector<vector<int>> vvi;
typedef vector<vector<bool>> vvb;
typedef vector<long long> vll;
typedef vector<vector<long long>> vvl;

#define DEBUG true
#ifdef DEBUG
#define debug(x) cout << #x << "=" << x << "\n"
#else
#define debug(x)
#endif

#define INF (int)1e9

int n, m;
string s, t;
//const int p = 31;
//const ll MOD = 1e9+7;

/*
ll _hash(string str, vi cnt) {
	for (char c: str) cnt[c-'a']++;
	ll ans = 0;
	int pp = 1;
	for (int i=0; i<26; ++i) {
		s += 1LL * cnt[i] * pp;
		ans %= MOD;
		pp = (pp*p)%MOD;
	}
	return s;
}
*/



int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> m >> s >> t;
	vi cnt(57, 0);
	for (char c: s) cnt[c-'A']++;
	vi curr_cnt(57, 0);
	for (int i=0; i<min(n, m); ++i) {
		curr_cnt[t[i]-'A']++;
	}
	int ans = 0;
	for (int i=n; i<m; ++i) {
		if (curr_cnt == cnt) ans++;
		curr_cnt[t[i-n]-'A']--;
		curr_cnt[t[i]-'A']++;
	}
	if (curr_cnt == cnt) ans++;
	cout << ans << nl;
	return 0;
}
