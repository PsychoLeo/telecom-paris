/*
* Author:  Léopold Bernard
* Created: 18/03/2025 14:43:04
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

vector<vll> ar;
vector<pii> cows;
int n;

struct UF {
    int n;
    vi sz;
    vi repr;

    void init(int nn) {
        n = nn;
        sz.resize(n, 1);
        repr.resize(n);
        for (int i=0; i<n; ++i) repr[i] = i;
    }

    int find(int x) {
        if (repr[x] == x) return x;
        return repr[x] = find(repr[x]);
    }

    bool unite(int a, int b) {
        a = find(a);
        b = find(b);
        if (a == b) return false;
        if (sz[a] > sz[b]) swap(a, b);
        sz[b] += sz[a];
        repr[a] = b;
        return true;
    }
};

ll dist(int u, int v) {
    return 1LL*(cows[u].fi-cows[v].fi)*(cows[u].fi-cows[v].fi) + 1LL*(cows[u].se-cows[v].se)*(cows[u].se-cows[v].se);
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n;
    UF uf; uf.init(n);
    for (int i=0; i<n; ++i) {
        int x, y; cin >> x >> y;
        cows.pb(mp(x, y));
    }
    for (int i=0; i<n; ++i) {
        for (int j=0; j<i; ++j) {
            ar.pb({dist(i, j), i, j});
        }
    }
	sort(all(ar));
	int nbcomps = n;
	//for (int i=0; i<(int)ar.size(); ++i) cout << ar[i][0] << " "<< ar[i][1] << " " << ar[i][2] << nl;
	for (int i=0; i<(int)ar.size(); ++i) {
		ll d = ar[i][0], u = ar[i][1], v = ar[i][2];
		if (uf.unite(u, v)) nbcomps--;
		if (nbcomps == 1) {
			cout << d << nl;
			break;
		}
	}
	return 0;
}
