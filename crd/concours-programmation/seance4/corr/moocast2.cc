#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

const int Tm = 1000 + 1 ;
long long x[Tm], y[Tm], N;
vector<pair<long long,pair<int,int>>> edges;

// UNION FIND DATASTRUCTURE
int repr[Tm];

int find(int x) {
  if(repr[x] < 0)
    return x;
  return repr[x]=find(repr[x]);
}

bool unite(int a, int b) {
  a = find(a);
  b = find(b);
  if(a==b)
    return false;
  if(repr[a] > repr[b])
    swap(a,b);
  repr[a] += repr[b] ;
  repr[b] = a;
  return true;
}
// END OF UNION FIND


long long sq(long long a) { return a*a ;} // computer square
long long dist(int i, int j) { return sq(x[i]-x[j])+sq(y[i]-y[j]) ;}


int main () {
  fill(repr,repr+Tm,-1); // Initialize union-find
  scanf("%lld\n",&N);
  for(int i = 0 ; i < N ; i++)
    scanf("%lld %lld\n",x+i, y+i); // Read positions
  for(int i = 0 ; i < N ; i++)
    for(int j = i+1 ; j<N ; j++)
      edges.push_back( { dist(i,j), {i,j}} ); // add edges with weight first (order starts by 1st element)

  // Kruskal 
  sort(edges.begin(),edges.end());
  long long max_x = -1;
  for(auto [d,e] : edges)
    if(unite(e.first,e.second))
      max_x = d; // sinces edges are sorted this is the biggest edge used
  printf("%lld\n",max_x);
  return 0;
}
