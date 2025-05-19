/*
* Author:  Léopold Bernard
* Created: 01/04/2025 14:36:09
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

int n, k;

const int xm = 1005;
const int ym = 1005;

vvi grid;
vvi pf;
vvi g;

void print() {
	for (int x=0; x<10; ++x) {
		for (int y=0; y<10; ++y) {
			cout << g[x][y] << " ";
		}
		cout << nl;
	}
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> k;
	grid.resize(xm, vi(ym, 0));
	pf.resize(xm, vi(ym, 0));
	g.resize(xm, vi(ym, 0));
	for (int i=0; i<n; ++i) {
		int x1, y1, x2, y2; cin >> x1 >> y1 >> x2 >> y2;
		grid[x1][y1]++;
		grid[x2][y2]++;
		grid[x2][y1]--;
		grid[x1][y2]--;
	}
	for (int x=0; x<xm; ++x) {
		pf[x][0] = grid[x][0];
		for (int y=1; y<ym; ++y) {
			pf[x][y] = grid[x][y] + pf[x][y-1];
		}
	}
	for (int y=0; y<ym; ++y) {
		g[0][y] = pf[0][y];
		for (int x=1; x<xm; ++x) {
			g[x][y] = g[x-1][y] + pf[x][y];
		}
	}
	// print();
	int ans = 0;
	for (int x=0; x<xm; ++x) {
		for (int y=0; y<ym; ++y) {
			ans += (g[x][y] == k);
		}
	}
	cout << ans <<nl;
	return 0;
}
