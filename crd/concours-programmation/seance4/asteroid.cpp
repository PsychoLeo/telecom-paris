/*
* Author:  Léopold Bernard
* Created: 18/03/2025 15:07:42
*/

#include <iostream>
#include <vector>

#define vi vector<int>
#define vvi vector<vi>
#define vb vector<bool>

using namespace std;

int n, k;
vvi adj; // Adjacency list for bipartite graph
vi match;       // match[v] = u if u is matched with v, otherwise -1
vb visited;    // To track visited nodes during DFS

bool augment(int u) {
    if (visited[u]) return false;
    visited[u] = true;

    for (int v : adj[u]) {
        // If v is not matched OR we can find an augmenting path via match[v]
        if (match[v] == -1 || augment(match[v])) {
            match[v] = u; // Match v with u
            return true;  // Found an augmenting path
        }
    }
    return false;
}

int maxBipartiteMatching() {
    int matching = 0;
    for (int u = 0; u < n; u++) {
        fill(visited.begin(), visited.end(), false);
        if (augment(u)) {
			// cout << u << endl;
			matching++;
		}
    }
    return matching;
}

int main() {
	ios_base::sync_with_stdio(0); cin.tie(0); cout.tie(0);
	cin >> n >> k;
	adj.resize(2*n);
	for (int i=0; i<k; ++i) {
		int x, y; cin >> x >> y; --x; --y;
		adj[x].push_back(y+n); adj[y+n].push_back(x);
	}
	match.resize(2*n, -1);
	visited.resize(2*n, false);
	cout << maxBipartiteMatching() << endl;
	return 0;
}
