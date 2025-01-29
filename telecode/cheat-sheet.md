# C++ Cheat Sheet

## Setup

### Compilation

compile
```bash
g++ -g -Wall A.cpp
```
memory check:
```bash
valgrind ./a.out < 1.in > 1.out
```

time check:
```bash
time ./a.out < 1.in > 1.out
```

### Compilation file

Create a file `commands.sh` with the following content:
```bash
function compile() {
    g++ -O2 -Wall -Wextra -Wfloat-equal -Wunreachable-code -Wfatal-errors -Wformat=2 -std=gnu++17 -D_GLIBCXX_DEBUG "$1" -o "$(basename "$1" .cpp)"
}

function run() {
    compile "$1"
    valgrind ./"$(basename "$1" .cpp)" < "$2" > "$(basename "$2" .in)".out
}
```

To activate the functions, `source commands.sh`. Use `compile A.cpp` or `run A.cpp input.A.in` to compile or run A.cpp.

### Includes
```cpp
#include <iostream>
#include <string>
#include <sstream>

#include <map>
#include <set>
#include <unordered_set>
#include <vector>
#include <queue>
#include <deque>

#include <utility>
#include <cmath>
#include <algorithm>
#include <complex>
#include <numeric>

using namespace std;
```	

### I/O
Read a line:
```cpp
int N,M; scanf("%d %d\n", &N, &M); // Read two integers
double x; scanf("%f\n", &x); // Read a float
```

Read a line of chars:
```cpp
char s[100]; scanf("%s\n", s);
```

Read undetermined number of integers in file:
```cpp
string line;
while (getline(cin, line)) {
    stringstream s(line);
    string word;
    while (s >> word) {
        // do something with word
    }
}
```

Convert strings
```cpp
string s;
int x = stoi(s);
float x = stof(s);
double x = stod(s);
long double x = stold(s);
```

## Algorithms

### Sorting

Sort a vector of integers:
```cpp
//Returns true if x is smaller than y
bool cmp(const Type& x, const Type& y);

sort(v.begin(), v.end(), cmp);
```

### Binary Search

```cpp	
bool binary_search (ForwardIterator first, ForwardIterator last, const T& val, Compare cmp);
```

## Data structures

### Map

Associative containers that store elements formed by a combination of a key value and a mapped value, following a specific order. Implemented with a self-balancing binary search tree.

```cpp
map<Key, Value> m;

m[key] = value; //Insert or update
m.find(key) != m.end(); //Check if key is in map
m.erase(key); //Remove key
m.size(); //Number of elements
m.empty(); //Check if empty
m.clear(); //Remove all elements

m.begin(); //Iterator to first element, can use * to get the pair
m.end(); //Iterator to last element, can use * to get the pair
```

### Hash Map

Associative containers that store elements formed by a combination of a key value and a mapped value. Implemented with a hash table.

```cpp
unordered_map<Key, Value> m;
// same operations as map
```

### Set

Like map, but only stores keys.

```cpp
set<Type> s;

s.insert(value); //Insert value
// same operations as map
```

### Hash Set

Like unordered_map, but only stores keys.

```cpp
unordered_set<Type> s;
// same operations as set
```


### Vector

Dynamic array that can change in size.

```cpp
vector<int> v (4,100);  // four ints with value 100

v.begin(); v.end(); //Iterators
v.clear(); //Remove all elements
v.size(); //Number of elements
v.push_back(const value_type& val); //Add element at the end
v.pop_back(); //Remove last element
```

### deque

Deque (double-ended queue) is a data structure that allows insertion and deletion at both the front and the back of the queue.

```cpp
deque<int> q;

q.begin(); q.end(); //Iterators
q.cqear(); //Remove all elements
q.size(); //Number of elements
q.push_back(const value_type& val); //Add element at the end
q.pop_back(); //Remove last element
q.push_front(const value_type& val); //Add element at the beginning
q.pop_front(); //Remove first element
q.remove(const value_type& val); //Remove all elements with value
```

### Priority Queue

Constant time lookup of the largest (by default) element, at the expense of logarithmic insertion and extraction. Implemented with a vector.

```cpp
priority_queue<D, vector<D>, Compare<D,D>> pq;

pq.emplace(value); //Insert value
pq.pop(); //Remove top element
pq.top(); //Access top element
pq.size(); //Number of elements
pq.empty(); //Check if empty

```


### Union Find

Maintain a collection of non-overlapping sets with the following operations
• Add a new element, in its own set
• Get the set of an element
• Merge two sets

```cpp
struct UnionFindSet {
	vector<int> parent;
	void init(int nn) {
		parent.resize(nn + 1);
		for (int i = 0; i < parent.size(); i++)
			parent[i] = i;
	}

	void merge(int x, int y) {
		parent[find(x)] = find(y);
	}
	int find(int x) {
		return x == parent[x] ? x : parent[x] = find(parent[x]);
	}
	bool together(int x, int y) {
		return find(x) == find(y);
	}
};
```

## String

### KMP

```cpp

int kmp(string& par, string& ori) {
    vector<int> ne(ori.size(), -1); // next[], if par[i] not matched, jump to i = ne[i]
    ne[0] = -1;
    for (int p = ne[0], i = 1; i < par.length(); i++) {
        while (p >= 0 && par[p+1] != par[i])
            p = ne[p];
        if (par[p+1] == par[i])
            p++;
        ne[i] = p;
    }

    int match = 0;
    for (int p = -1, q = 0; q < ori.length(); q++) {
        while (p >= 0 && par[p+1] != ori[q])
            p = ne[p];
        if (par[p+1] == ori[q])
            p++;
        if (p + 1 == par.length()) { // match!
            p = ne[p];
            match++;
        }
    }

    return match; // return number of occurance
}

int main () {
    int n; cin >> n;
    string par, ori;
    while (cin >> par >> ori)
        cout << kmp(par, ori) << endl;
    return 0;
}
```

## Graphs

### BFS / DFS

```cpp	
/* Returns true if there is a path from source 's' to sink
  't' in residual graph. Also fills parent[] to store the
  path */
bool bfs(int rGraph[V][V], int s, int t, int parent[])
{
    bool visited[V];
    fill(visited, visited+sizeof(visited), 0);

    queue<int> q; // vector for DFS
    q.push_back(s);
    visited[s] = true;
    parent[s] = -1;

    while (!q.empty()) {
        int u = q.front(); // q.back() for DFS
        q.pop_front(); // q.pop_back() for DFS
 
        for (int v = 0; v < V; v++) {
            if (visited[v] == false && rGraph[u][v] > 0) {
                if (v == t) {
                    parent[v] = u;
                    return true;
                }
                q.push_back(v);
                parent[v] = u;
                visited[v] = true;
            }
        }
    }
    return false;
}
```

### Dijkstra

Used for finding the shortest path from a single source vertex to all other vertices in a positive weighted graph, in O(E log(V)) time.

```cpp
const D INF;
using Entry = pair<D, int>;

vector<D> dijkstra(
    vector<vector<pair<int, D>>> const &edges,
    int source, int target,
    vector<int> &prev)
/* Returns a vector of the shortest distances to all nodes from the source,
 * but stops whenever target is encountered (set target = -1 to compute
 * all distances).
 * Populates prev with the predecessors to each node (-1 when no predecessor).
 * Nodes numbered from 0 to N - 1 where N = edges.size().
 * Distances are INF if there is no path.
 */
{    
    int const N = edges.size();
    vector<bool> visited(N, false);
    prev.assign(N, -1);

    vector<D> dist(N, INF);
    dist[source] = 0;

    priority_queue<Entry, vector<Entry>, greater<Entry>> Q;
    Q.emplace(0, source);
    while (!Q.empty())
    {
        D node_dist;
        int node;
        tie(node_dist, node) = Q.top();
        Q.pop();
        if (visited[node])
            continue;
        visited[node] = true;
        if (node == target)
            break;
        for (pair<int, D> const &edge : edges[node])
        {
            int child;
            D edge_len;
            tie(child, edge_len) = edge;
            if (!visited[child] && node_dist + edge_len < dist[child])
            {
                dist[child] = node_dist + edge_len;
                prev[child] = node;
                Q.emplace(dist[child], child);
            }
        }
    }
    return dist;
}
```

### Bellman-Ford

Used for finding the shortest path from a single source vertex to all other vertices in a weighted graph, even with negative weights, in O(V*E) time.

```cpp
// The main function that finds shortest
// distances from src to all other vertices
// using Bellman-Ford algorithm.
// The row graph[i] represents i-th edge with
// three values u, v and w.
int[] BellmanFord(int graph[][3], int V, int E, int src)
{
    fill(dis, dis + V, INF);
	dis[src] = 0;

	for (int i = 0; i < V - 1; i++) {

		for (int j = 0; j < E; j++) {
			if (dis[graph[j][0]] != INF && 
                dis[graph[j][0]] + graph[j][2] < dis[graph[j][1]])
				dis[graph[j][1]] = dis[graph[j][0]] + graph[j][2];
		}
	}

	return dis;
}
```

### Maximum Matching

A matching in a Bipartite Graph is a set of the edges chosen in such a way that no two edges share an endpoint. A maximum matching is a matching of maximum size (maximum number of edges). 

```cpp
bool bpm(bool bpGraph[M][N], int u,
         bool seen[], int matchR[])
{
    for (int v = 0; v < N; v++) {
        if (bpGraph[u][v] && !seen[v]) {
            seen[v] = true; 
            if (matchR[v] < 0 || bpm(bpGraph, matchR[v], seen, matchR)) {
                matchR[v] = u;
                return true;
            }
        }
    }
    return false;
}
 
// Returns maximum number of matching from M to N
int maxBPM(bool bpGraph[M][N])
{
    int matchR[N];

    memset(matchR, -1, sizeof(matchR));

    int result = 0; 
    for (int u = 0; u < M; u++)
    {
        bool seen[N];
        memset(seen, 0, sizeof(seen));
        if (bpm(bpGraph, u, seen, matchR))
            result++;
    }
    return result;
}
```

### Minimum Spanning Tree

```cpp
struct Graph {
    struct Edge {
    	int from;
        int to;
        int len;
    };

    const static int MAXNODE = 3 * 1e5 + 2;
    vector<int> g[MAXNODE];
    vector<Edge> edge;
    int n;
    void init(int nn) {
        n = nn;
        for (int i = 0; i <= n; i++)
            g[i].clear();
        edge.clear();
    }

    void add_e(int x, int y, int len) {
        g[x].push_back(edge.size());
        edge.push_back((Edge){x, y, len});
        g[y].push_back(edge.size());
        edge.push_back((Edge){y, x, len});
    }

    void show() {
    	for (int i = 0; i <= n; i++) {
    		printf("%d:", i);
    		for (int ie : g[i])
    			printf(" %d", edge[ie].to);
    		printf("\n");
    	}
    	printf("\n");
    }

    UnionFindSet ufs;
    void mst(vector<vector<pair<D,int>>> edges, int start) {
    	ufs.init(n);
    	vector<Edge> eee = edge;
    	sort(begin(eee), end(eee), [](const Edge& a, const Edge& b) {
    		return a.len < b.len;
    	});

    	int need = n - 1;
    	for (const auto& e : eee) {
    		if (!ufs.together(e.from, e.to)) {
    			// add Edge e
    			ufs.merge(e.from, e.to);
    			need--;
    			if (!need)
    				break;
    		}
    	}
    }
};
```
### Maximum Flow

The maximum flow problem involves determining the maximum amount of flow that can be sent from a source vertex to a sink vertex in a directed weighted graph, subject to capacity constraints on the edges. 

time complexity : O(max_flow * E)

```cpp 

// Returns the maximum flow from s to t in the given graph
int fordFulkerson(int graph[V][V], int s, int t)
{
    int u, v;
 
    // Create a residual graph and fill the residual graph
    // with given capacities in the original graph as
    // residual capacities in residual graph
    int rGraph[V]
              [V]; // Residual graph where rGraph[i][j]
                   // indicates residual capacity of edge
                   // from i to j (if there is an edge. If
                   // rGraph[i][j] is 0, then there is not)
    for (u = 0; u < V; u++)
        for (v = 0; v < V; v++)
            rGraph[u][v] = graph[u][v];
 
    int parent[V]; // This array is filled by BFS and to
                   // store path
 
    int max_flow = 0; // There is no flow initially
 
    // Augment the flow while there is path from source to
    // sink
    while (bfs(rGraph, s, t, parent)) {
        // Find minimum residual capacity of the edges along
        // the path filled by BFS. Or we can say find the
        // maximum flow through the path found.
        int path_flow = INT_MAX;
        for (v = t; v != s; v = parent[v]) {
            u = parent[v];
            path_flow = min(path_flow, rGraph[u][v]);
        }
 
        // update residual capacities of the edges and
        // reverse edges along the path
        for (v = t; v != s; v = parent[v]) {
            u = parent[v];
            rGraph[u][v] -= path_flow;
            rGraph[v][u] += path_flow;
        }
 
        // Add path flow to overall flow
        max_flow += path_flow;
    }
 
    // Return the overall flow
    return max_flow;
}
```


## Geometry

### Point operations

```cpp
complex<double> x, y, a;

abs(x - y); // distance
arg(x - y); // angle
(conj(x)*y).real(); // dot product
(conj(x)*y).imag(); // cross product

x * (conj(x)*y).real() / (conj(x)*x).real(); // projection of y on x
abs((conj(b-a)*(x-a)).imag()) / abs(b-a); // distance from x to line ab
```

### Convex hull

Graham scan algorithm to find the convex hull of a set of points. In O(n log n) time.

```cpp
using pt = complex<double>;

int orientation(pt a, pt b, pt c) {
    pt v1 = b-a, v2 = c-a;
    double v = (conj(v1)*v2).imag();
    if (v < 0) return -1; // clockwise
    if (v > 0) return +1; // counter-clockwise
    return 0;
}

bool cw(pt a, pt b, pt c, bool include_collinear) {
    int o = orientation(a, b, c);
    return o < 0 || (include_collinear && o == 0);
}
bool collinear(pt a, pt b, pt c) { return orientation(a, b, c) == 0; }

void convex_hull(vector<pt>& a, bool include_collinear = false) {
    pt p0 = *min_element(a.begin(), a.end(), [](pt a, pt b) {
        return make_pair(a.real(), a.imag()) < make_pair(b.real(), b.real());
    });
    sort(a.begin(), a.end(), [&p0](const pt& a, const pt& b) {
        int o = orientation(p0, a, b);
        if (o == 0)
            return abs(p0 - a) < abs(p0 - b);
        return o < 0;
    });
    if (include_collinear) {
        int i = (int)a.size()-1;
        while (i >= 0 && collinear(p0, a[i], a.back())) i--;
        reverse(a.begin()+i+1, a.end());
    }

    vector<pt> st;
    for (int i = 0; i < (int)a.size(); i++) {
        while (st.size() > 1 && !cw(st[st.size()-2], st.back(), a[i], include_collinear))
            st.pop_back();
        st.push_back(a[i]);
    }

    if (include_collinear == false && st.size() == 2 && st[0] == st[1])
        st.pop_back();

    a = st;
}
```

### Signed area of polygon

Given ordered coordinates of a polygon with n vertices.

```cpp
double signed_area(vector<complex<double>> &points) {
    double s = 0;
    for (unsigned  j = 0; j < points.size(); j++) {
        complex<double> p1 = points[j];
        complex<double> p2 = points[(j+1)%points.size()];
        s += ((conj(p2-p1))*(p3-p1)).imag()/2;
    }
    return s;
}
```

## Math

### GCD and LCM

```cpp
gcd(a, b); // Greatest common divisor (pgcd)
lcm(a, b); // Least common multiple (ppcm)
```


