/*
* Author:  Léopold Bernard
* Created: 11/03/2025 14:36:56
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

int b, e, p, n, m;
vvi adj;
vvi d; // d(1, x), d(2, x), d(N, x)

void bfs(int dep) {
    vb vis(n, false);
    deque<pii> tovis = {mp(0, dep)};
    while (!tovis.empty()) {
        pii pi = tovis.front();
        int w = pi.fi, v = pi.se;
        tovis.pop_front();
        if (vis[v]) continue;
        vis[v] = true;
        if (dep == n-1) d[2][v] = w;
        else d[dep][v] = w;
        for (int u: adj[v]) {
            if (!vis[u]) tovis.push_back(mp(w+1,u));
        }
    }
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> b >> e >> p >> n >> m;
    adj.resize(n, vi());
    d.resize(3, vi(n, 0));
    for (int i=0; i<m; ++i) {
        int u, v; cin >> u >> v;
        --u; --v;
        adj[u].pb(v);
        adj[v].pb(u);
    }
    int ans = 1000*1000*1000;
    bfs(0); bfs(1); bfs(n-1);
    for (int u=0; u<n; ++u) {
        // debug(u);
        ans = min(ans, b*d[0][u] + e*d[1][u] + p*d[2][u]);
    }
    cout << ans << nl;
	return 0;
}
