#include <cstdio>
#include <vector>
using namespace std;

const int Tm = 100000 + 5;
char type[Tm]; // each node has a type of grass, 0 is no colored, 1 and 2 are colors
vector<pair<int,char>> nxt[Tm] ; // node -> list of (node,flag)
int nb_nodes, nb_edges, res;

void mark(int n, int color) { // we propagate the constraints on node n
  if(type[n]) { // we already have a color so we check consistency
    if(type[n] != color)
      res = -Tm; // inconsistency found final result is 2^res = 0 with res = -∞
  } else {
    type[n] = color ;
    for(auto [v,t] : nxt[n]) {
      if(t=='S')
        mark(v,color);
      else
        mark(v,3-color);
    }
  }
}

int main () {
  scanf("%d %d\n",&nb_nodes,&nb_edges);
  for(int s = 0 ; s < nb_edges ; s++) {
    char t;
    int from,to ;
    scanf("%c %d %d\n",&t,&from,&to);
    nxt[from].push_back(make_pair(to,t));
    nxt[to].push_back(make_pair(from,t));
  }
  for(int n = 1 ; n <= nb_nodes ; n++)
    if( type[n] == 0) {
      res++;
      mark(n, 1); // we select one color
    }
  if(res<=0)
    printf("0\n");
  else  { // if not inconsistent
    printf("1");
    for(int i = 0 ; i < res ; i++)
      printf("0");
    printf("\n");
  } 
  return 0;
}
