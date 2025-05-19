/*
* Author:  Léopold Bernard
* Created: 01/04/2025 12:51:07
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
#define INF (ll)1e18

int n; 
vll l;
vector<vll> dp;

void print() {
	for (int i=0; i<n+1; ++i) {
		for (int j=0; j<n+1; ++j) {
			cout << dp[i][j] << " ";
		}
		cout << nl;
	}
}

ll cut(int i, int j) {
	// i inclus, j exclu
	if (dp[i][j] > -1) return dp[i][j];
	ll ans = INF;
	for (int k=i; k<j; ++k) {
		ans = min(ans, l[j+1]-l[i] + cut(i, k) + cut(k+1, j));
	}
	return dp[i][j] = ans;
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n; l.resize(n+1);
	// debug(n);
	dp.resize(n, vll(n, -1));
	ll s = 0;
	for (int i=0; i<=n; ++i) {
		l[i] = s;
		ll x; cin >> x; s += x;
		if (i < n) dp[i][i] = 0;
	}
	cout << cut(0, n-1) << nl;
	// print();
	return 0;
}
