#include <iostream>
#include <vector>
#include <algorithm>

#define vi vector<int>
#define ll long long
#define vvi vector<vi>
#define pii pair<int, int>
#define fi first
#define se second
#define pll pair<ll, ll>

using namespace std;

struct UF {
    int n;
    vi repr, rank;

    void init(int nn) {
        n = nn;
        rank.resize(n,1);
        for (int i=0; i<n; ++i) repr.push_back(i);
    }

    int find(int x) {
        if (x == repr[x]) return x;
        return repr[x] = find(repr[x]);
    }

    bool unite(int a, int b) {
        a = find(a);
        b = find(b);
        if (a==b) return false;
        if (rank[a] > rank[b]) swap(a, b);
        repr[a] = b; rank[b] += rank[a];
        return true;
    }
};

ll sq(int y) {
    return 1LL*y*y;
}

ll dist(pll a, pll b) {
    return sq(a.fi-b.fi) + sq(a.se-b.se);
}

int main() {
    int n; cin >> n;
    UF uf; uf.init(n);
    vector<pll> v;
    vector<vector<ll>> t;
    for (int i=0; i<n; ++i) {
        int x, y; cin >> x >> y;
        v.push_back(make_pair(x, y));
        for (int j=0; j<(int)v.size()-1; ++j) t.push_back({dist(v[i],v[j]), i, j});
    }
    sort(t.begin(), t.end());
    int numComp = n;
    int dmin = 1000*1000*1000;
    for (int i=0; numComp > 1; ++i) {
        vector<ll> a = t[i];
        int d = a[0], k = a[1], j = a[2];
        if (uf.unite(k, j)) numComp--;
        dmin = d;
    }
    cout << dmin << endl;
}