#include <vector>
#include <iostream>

#define vi vector<int>
#define pii pair<int, int>
#define nl "\n"
#define vvi vector<vi>
#define pb push_back
#define mp make_pair

#define INF 1000*1000*1000

using namespace std;

int N, M, C;
const int Nm = 1005;
const int Tm = 1005;
vi m;
vvi adj;

int dp[Nm][Tm];

int main() {
    cin >> N >> M >> C;
    m.resize(N);
    adj.resize(N);
    for (int i=0; i<Nm; ++i) for (int j=0; j<Tm; ++j) dp[i][j] = -INF;
    dp[0][0] = 0;
    for (int &x: m) cin >> x;
    for (int i=0; i<M; ++i) {
        int a, b; cin >> a >> b;
        --a; --b; adj[a].pb(b);
    }
    for (int T=1; T<Tm; ++T) {
        for (int u=0; u<N; ++u) {
            for (int v: adj[u]) 
                dp[u][T] = max(dp[u][T], m[v] + dp[v][T-1]);
        }
    }
    int ans = 0;
    for (int T=1; T<Tm; ++T) ans = max(ans, dp[0][T] - C*T*T);
    cout << ans <<nl;
    return 0;
}