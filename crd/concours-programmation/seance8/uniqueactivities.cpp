/*
* Author:  Léopold Bernard
* Created: 15/04/2025 14:45:20
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

#define MOD 1000000007
#define INF (int)1e9

string s;

const ll p = 31;
const ll invp = 129032259;

int occ(int k) {
	unordered_map<ll, int> cnt;
	ll h = 0;
	ll powp = 1;
	for (int i=0; i<k; ++i) {
		h += (s[i]-'A'+1) * powp;
		h %= MOD;
		powp = (powp * p) % MOD;
	}
	ll powpk_1 = (powp * invp) % MOD;
	cnt[h]++;
	for (int i=0; i<sz(s)-k; ++i) {
		h = (h - (s[i]-'A'+1) + MOD) % MOD;
		h = (h * invp) % MOD;
		h += (s[i+k]-'A'+1) * powpk_1;
		h %= MOD;
		cnt[h]++;
	}
	unordered_set<ll> st;
	for (auto [hh, c] : cnt) if (c == 1) st.emplace(hh);
	h = 0;
	powp = 1;
	for (int i=0; i<k; ++i) {
		h += (s[i]-'A'+1) * powp;
		h %= MOD;
		powp = (powp * p) % MOD;
	}
	for (int i=0; i<sz(s)-k; ++i) {
		if (st.find(h) != st.end()) return i;
		h = (h - (s[i]-'A'+1) + MOD) % MOD;
		h = (h * invp) % MOD;
		h += (s[i+k]-'A'+1) * powpk_1;
		h %= MOD;
	}
	return sz(s)-k;
}

bool occurs_once(int k) {
	unordered_map<ll, int> cnt;
	ll h = 0;
	ll powp = 1;
	for (int i=0; i<k; ++i) {
		h += (s[i]-'A'+1) * powp;
		h %= MOD;
		powp = (powp * p) % MOD;
	}
	ll powpk_1 = (powp * invp) % MOD;
	cnt[h]++;
	for (int i=0; i<sz(s)-k; ++i) {
		h = (h - (s[i]-'A'+1) + MOD) % MOD;
		h = (h * invp) % MOD;
		h += (s[i+k]-'A'+1) * powpk_1;
		h %= MOD;
		cnt[h]++;
	}
	for (auto [hh, c] : cnt) if (c == 1) return true;
	return false;
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> s;
	int lo = 1, hi = sz(s);
	// debug(hi);
	while (lo < hi) {
		int mid = (lo + hi) / 2;
		// debug(mid); debug(lo); debug(hi);
		if (occurs_once(mid)) hi = mid;
		else lo = min(hi, mid+1);
	}
	int i = occ(lo);
	for (int j=i; j<i+lo; ++j) cout << s[j];
	cout << nl;
	return 0;
}
