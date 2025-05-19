/*
* Author:  Léopold Bernard
* Created: 18/03/2025 14:43:12
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
map<pii, int> mat;
vi comp;
vi vis;

bool dfs(int dep, int c) {
	vector<pii> tovis = {mp(dep, 1)};
	while (!tovis.empty()) {
		pii p = tovis.back();
		int v = p.fi, x = p.se;
		tovis.pop_back();
		if (vis[v] && x != vis[v]) return false;
		if (vis[v]) continue;
		vis[v] = x;
		comp[v] = c;
		for (int u : adj[v]) {
			if (vis[u] && mat[mp(u, v)] * vis[v] != vis[u]) return false;
			if (!vis[u]) tovis.pb(mp(u, mat[mp(u, v)] * vis[v]));
		}
	}
	return true;
}

string connectedComps() {
	string ans = "1";
	int c = 0;
	for (int i=0; i<n; ++i) {
		if (comp[i] < 0) {
			bool b = dfs(i, c);
			// debug(i); debug(b);
			if (!b) return "0";
			else ans.pb('0');
			++c;
		}
	}
	return ans;
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> m;
	adj.resize(n);
	comp.resize(n, -1);
	vis.resize(n, 0);
	for (int i=0; i<m; ++i) {
		char s; int u, v; cin >> s >> u >> v;
		--u; --v; mat[mp(u, v)] = (s == 'S') ? 1 : -1;
		mat[mp(v, u)] = mat[mp(u, v)];
		adj[u].pb(v);
		adj[v].pb(u);
	}
	cout << connectedComps() << nl;
	return 0;
}
