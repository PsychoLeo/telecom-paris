#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

int C, R;
vector<string> garden;
pair<int, int> start, destination;
vector<vector<bool>> visited;
vector<vector<char>> parent;
vector<pair<int, int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
vector<char> dir_chars = {'U', 'D', 'L', 'R'};

void bfs() {
    queue<pair<int, int>> q;
    q.push(start);
    visited[start.first][start.second] = true;
    
    while (!q.empty()) {
        auto [x, y] = q.front();
        q.pop();
        
        if (x == destination.first && y == destination.second) {
            string path;
            while (make_pair(x, y) != start) {
                char d = parent[x][y];
                path.push_back(d);
                if (d == 'U') x++;
                else if (d == 'D') x--;
                else if (d == 'L') y++;
                else if (d == 'R') y--;
            }
            reverse(path.begin(), path.end());
            cout << path << endl;
            return;
        }
        
        for (int i = 0; i < 4; ++i) {
            int nx = x + directions[i].first;
            int ny = y + directions[i].second;
            if (nx >= 0 && nx < R && ny >= 0 && ny < C && !visited[nx][ny] && garden[nx][ny] != '#') {
                visited[nx][ny] = true;
                parent[nx][ny] = dir_chars[i];
                q.push({nx, ny});
            }
        }
    }
}

int main() {
    cin >> C >> R;
    garden.resize(R);
    visited.assign(R, vector<bool>(C, false));
    parent.assign(R, vector<char>(C, ' '));
    
    for (int i = 0; i < R; ++i) {
        cin >> garden[i];
        for (int j = 0; j < C; ++j) {
            if (garden[i][j] == 'R') start = {i, j};
            if (garden[i][j] == 'D') destination = {i, j};
        }
    }
    
    bfs();
    
    return 0;
}