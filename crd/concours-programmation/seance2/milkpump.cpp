/*
* Author:  Léopold Bernard
* Created: 04/03/2025 14:36:28
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

int n, m;
vvi adj;
vvi c;
vvi f;
vi list_f;

void print_adj() {
	for (int i=0; i<n; ++i) {
		for (int u: adj[i]) cout << u << " ";
		cout << nl;
	}
}

int dijkstra(int fmin) {
	vb vis(n, false);
	priority_queue<pii, vector<pii>, greater<pii>> tovis; // noeud de départ
	tovis.push(mp(0, 0));
	while (!tovis.empty()) {
		pii p = tovis.top();
		int w = p.fi, node = p.se;
		tovis.pop();
		if (vis[node]) continue;
		vis[node] = true;
		//debug(node);
		//debug(w);
		if (node == n-1) {
			return w;
		}
		for (int u : adj[node]) {
			if (!vis[u] && (f[node][u] >= fmin)) {
				tovis.push(mp(w+c[node][u], u));
			}
		}
	}
	return -1;
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> m;
	adj.resize(n, vi());
	c.resize(n, vi(n, 0));
	f.resize(n, vi(n, 0));
	for (int i=0; i<m; ++i) {
		int a, b, ci, fli; cin >> a >> b >> ci >> fli;
		list_f.push_back(fli);
		--a; --b; 
		c[a][b] = ci;
		c[b][a] = ci;
		f[a][b] = fli;
		f[b][a] = fli;
		adj[a].pb(b);
		adj[b].pb(a);
	}
	// print_adj();
	sort(all(list_f));
	pii best = mp(0, 1);
	for (int fmin : list_f) {
		int s = dijkstra(fmin);
		//debug(fmin);
		//debug(s);
		if (s > 0 && (fmin * best.se > s * best.fi)) {
			best = mp(fmin, s);
		}
	}
	// cout << best.fi << " " << best.se << nl;
	ld ans = (ld) best.fi / (ld) best.se;
	ans *= 1e6;
	cout << floor(ans) << nl;
	return 0;
}
