#include <algorithm>
#include <vector>
#include <iostream>

#define vi vector<int>

using namespace std;

int n, c;
vi notes;
vi seq; 

bool isrum(int i) {
    vi co;
    for (int j=0; j<c; ++j) co.push_back(notes[i+j]);
    sort(co.begin(), co.end());
    int delta = co[0] - seq[0];
    for (int j=0; j<c; ++j) if (co[j] != seq[j]+delta) return false;
    return true;
}

int main() {
    cin >> n; 
    notes.resize(n); for (int &x: notes) cin >> x;
    cin >> c;
    seq.resize(c); for (int &x: seq) cin >> x;
    sort(seq.begin(), seq.end());
    int k = 0;
    vi rums;
    for (int i=0; i<=n-c; ++i) {
        if (isrum(i)) {
            ++k; rums.push_back(i);
        }
    }
    cout << k << endl;
    for (int i: rums) cout << i+1 << endl;
}