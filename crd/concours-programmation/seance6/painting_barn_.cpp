#include <iostream>
#include <algorithm>

using namespace std;

int n, k; 
const int Tm = 1005;

int l[Tm][Tm], p[Tm][Tm];

int main() {
    cin >> n >>k;
    for (int i=0; i<n; ++i) {
        int x1, y1, x2, y2; cin >> x1 >> y1 >> x2 >> y2;
        x1++; y1++; x2++; y2++;
        p[x1][y1]++;
        p[x2][y1]--;
        p[x2][y2]++;
        p[x1][y2]--;
    }
    for (int x=1; x<Tm; ++x) {
        for (int y=1; y<Tm; ++y) {
            l[x][y] = l[x-1][y] + l[x][y-1] + p[x][y] - l[x-1][y-1];
        }
    }
    cout << count(l[0], l[Tm], k) << endl;
}