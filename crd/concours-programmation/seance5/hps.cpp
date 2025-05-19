/*
* Author:  Léopold Bernard
* Created: 25/03/2025 15:12:22
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

int N, K;
const int NN = 100000+5;
const int KK = 21;
int dp[KK][NN][3]; // dp[k][n][m] is the maximum total number of games we can win with k switches left, n games left and current move m
vi j;

// H -> 0
// P -> 1
// S -> 2

bool beats(int m1, int m2) {
	// true if m1 beats m2
	return (m1 == (m2+1)%3);
}

void fill() {
	for (int k=0; k<=K; ++k) for (int m: {0, 1, 2}) dp[k][0][m] = 0;
	for (int k=0; k<=K; ++k) {
		for (int n=1; n<=N; ++n) {
			for (int m:{0, 1, 2}) {
				dp[k][n][m] = beats(m, j[N-n]) + dp[k][n-1][m]; // without changing
				if (k > 0) {
					for (int mm: {(m+1)%3, (m+2)%3}) {
						dp[k][n][m] = max(dp[k][n][m], beats(mm, j[N-n]) + dp[k-1][n-1][mm]);
					}
				}
			}
		}
	}
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> N >> K;
	j.resize(N+1, 0); 
	for (int i=0; i<N; ++i) {
		char c; cin >> c; 
		if (c == 'H') j[i] = 0;
		else if (c == 'P') j[i] = 1;
		else j[i] = 2;
	}
	fill();
	cout << max({dp[K][N][0], dp[K][N][1], dp[K][N][2]}) << nl;
	return 0;
}
