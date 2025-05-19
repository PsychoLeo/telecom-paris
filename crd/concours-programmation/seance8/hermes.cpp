/*
* Author:  Léopold Bernard
* Created: 15/04/2025 14:44:54
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

const int Nm = 20001;
const int Zm = 2001;

int n;

int dp[Nm][2][Zm];
int row[Zm];
int col[Zm];

const int taille = 4;

void print() {
	for (int i=0; i<=n; ++i) {
		for (int z=1000; z<=1000+taille; ++z) {
			cout << "row:" << dp[i][0][z] << " " << "col:" << dp[i][1][z] << "\t";
		}
		cout << nl;
	}
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	row[0] = col[0] = 1000;
	for (int b: {0, 1}) for (int z=0; z<Zm; ++z) dp[0][b][z] = abs(z-1000);
	cin >> n;
	for (int i=1; i<=n; ++i) {
		int x, y; cin >> x >> y; x+=1000; y += 1000;
		row[i] = y; col[i] = x;
	}
	for (int i=1; i<=n; ++i) {
		for (int z=0; z<Zm; ++z) {
			dp[i][0][z] = min(dp[i-1][0][z] + abs(row[i]-row[i-1]), dp[i-1][1][row[i]] + abs(col[i-1]-z));
			dp[i][1][z] = min(dp[i-1][1][z] + abs(col[i]-col[i-1]), dp[i-1][0][col[i]] + abs(row[i-1]-z));
		}
	}
	// print();
	int ans = INF;
	for (int z=0; z<Zm; ++z) {
		ans = min(ans, dp[n][0][z]);
		ans = min(ans, dp[n][1][z]);
	}
	cout << ans << nl;
	return 0;
}
