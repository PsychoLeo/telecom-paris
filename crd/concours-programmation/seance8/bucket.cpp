/*
* Author:  Léopold Bernard
* Created: 15/04/2025 14:44:49
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

int n;
priority_queue<int, vector<int>, greater<int>> buckets;
vvi cows;

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n; cows.resize(n, vi());
	int ans = 0;
	for (int i=1; i<=1000; ++i) buckets.push(i);
	vector<pii> time(1001, mp(-1, -1));
	for (int i=0; i<n; ++i) {
		int si, ti, bi; cin >> si >> ti >> bi;
		time[si] = mp(i, bi);
		time[ti] = mp(i, -1);
	}
	for (int t=1; t<=1000; ++t) {
		if (time[t].fi == -1) continue;
		int i = time[t].fi;
		if (time[t].se == -1) {
			for (int b : cows[i]) buckets.push(b);
		}
		else {
			for (int j=0; j<time[t].se; ++j) {
				int x = buckets.top(); buckets.pop();
				cows[i].pb(x);
				ans = max(ans, x);
			}
		}
	}

	cout << ans << nl;
	return 0;
}
