/*
* Author:  Léopold Bernard
* Created: 14/04/2025 21:00:16
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

vector<pair<int, int>> coords;

ll dist(pii p) {
	ll ans = 0;
	for (pii v: coords) {
		ans += abs(p.fi - v.fi) + abs(p.se - v.se);
	}
	return ans;
}

int main() {
	int n; cin >> n;
	for (int i=0; i<n; ++i) {
		pair<int, int> p; cin >> p.fi >> p.se;
		coords.pb(p);
	}
	sort(coords.begin(), coords.end());
	ll mind = 1e18;
	pii bestp;
	for (int i=0; i<n; ++i) {
		if (dist(coords[i]) < mind) {
			mind = dist(coords[i]);
			bestp = coords[i];
		}
	}
	cout << bestp.fi << " " << bestp.se << nl;
}
