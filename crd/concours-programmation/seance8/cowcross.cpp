/*
* Author:  Léopold Bernard
* Created: 15/04/2025 14:44:51
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

ll n, t; 
vector<vector<vector<pair<pll, ll>>>> adj;
vector<vll> grid;
vector<pll> possib = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-3, 0}, {3, 0}, {0, 3}, {0, -3}, {1, 2}, {1, -2}, {-1, 2}, {-1, -2}, {2, 1}, {2, -1}, {-2, 1}, {-2, -1}};

ll dijkstra() {
	priority_queue<pair<ll, pll>, vector<pair<ll, pll>>, greater<pair<ll, pll>>> pq;
	pq.push(mp(0, mp(0, 0)));
	vvi dist(n, vi(n, -1));
	while (!pq.empty()) {
		pair<ll, pll> p = pq.top();
		pq.pop();
		ll w = p.fi;
		ll x = p.se.fi, y = p.se.se;
		if (dist[x][y] > -1) continue;
		dist[x][y] = w;
		if (x == n-1 && y == n-1) return w;
		for (pair<pll, ll> u: adj[x][y]) {
			ll nw = u.se, nx = u.fi.fi, ny = u.fi.se;
			if (dist[nx][ny] > -1) continue;
			pq.push(mp(w+nw, mp(nx, ny)));
		}
	}
	return -1;
}

signed main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> t;
	// debug(t);
	adj.resize(n, vector<vector<pair<pll, ll>>>(n));
	grid.resize(n, vll(n));
	for (int x=0; x<n; ++x) for (int y=0; y<n; ++y) cin >> grid[x][y];
	for (int x=0; x<n; ++x) {
		for (int y=0; y<n; ++y) {
			for (pii d: possib) {
				int dx = d.fi, dy = d.se;
				if (0<=x+dx && x+dx < n && 0<=y+dy && y+dy<n) {
					adj[x][y].pb(mp(mp(x+dx, y+dy), 3*t + grid[x+dx][y+dy]));
				}
			}
		}
	}
	adj[n-3][n-1].pb(mp(mp(n-1, n-1), 2*t));
	adj[n-2][n-2].pb(mp(mp(n-1, n-1), 2*t));
	adj[n-1][n-3].pb(mp(mp(n-1, n-1), 2*t));
	adj[n-2][n-1].pb(mp(mp(n-1, n-1), t));
	adj[n-1][n-2].pb(mp(mp(n-1, n-1), t));
	cout << dijkstra() << nl;
	return 0;
}
