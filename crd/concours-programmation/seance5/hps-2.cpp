#include <vector>
#include <iostream>

using namespace std;

const int Nm = 100005, Km = 22, Pm = 3;

int dp[Nm][Km][Pm];
int moves[Nm];
int N, K;

bool wins(int a, int b) {
    return ((a+2) % 3 == b);
}

int main() {
    cin >> N >> K;
    for (int i=0; i<N; ++i) {
        char c; cin >> c; 
        moves[i] = (c == 'H') ? 0 : ((c == 'P') ? 1 : 2);
    }
    for (int k=0; k<=K; ++k) for (int m:{0, 1, 2}) dp[0][k][m] = 0;
    for (int n=1; n<=N; ++n) {
        for (int k=0; k<=K; ++k) {
            for (int m: {0, 1, 2}) {
                dp[n][k][m] = dp[n-1][k][m] + wins(m, moves[N-n]);
                for (int mm : {(m+1)%3, (m+2)%3}) {
                    if (k>0) dp[n][k][m] = max(dp[n][k][m], dp[n-1][k-1][mm] + wins(mm, moves[N-n]));
                }
            }
        }
    }
    cout << max(max(dp[N][K][0], dp[N][K][1]), dp[N][K][2]) << endl;
    return 0;
}