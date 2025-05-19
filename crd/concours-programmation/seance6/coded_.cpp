#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

const int SZ = 70;
int cnt[SZ];


int main() {
    int m, n; cin >> m >> n;
    string s, t; cin >> s >> t;
    for (int i=0; i<min(n, m); ++i) {
        cnt[s[i]-'A']--;
        cnt[t[i]-'A']++;
    }
    int num_equal0 = 0, ans = 0;
    for (int i=0; i<SZ; ++i) if (cnt[i] == 0) ++num_equal0;
    if (num_equal0 == SZ) ans++;
    for (int i=m; i<n; ++i) {
        if (cnt[t[i-m]-'A'] == 0) num_equal0--;
        if (cnt[t[i]-'A'] == 0) num_equal0--;
        cnt[t[i-m]-'A']--;
        cnt[t[i]-'A']++;
        if (cnt[t[i-m]-'A'] == 0) num_equal0++;
        if (cnt[t[i]-'A'] == 0) num_equal0++;
        if (num_equal0 == SZ) ans++; 
    }
    cout << ans << endl;
}