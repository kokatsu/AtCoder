import std;

void main() {
    int N, M;
    readf("%d %d\n", N, M);

    auto cnts = new int[](N);
    auto uf = new UnionFind!int(N);
    foreach (_; 0 .. M) {
        int u, v;
        readf("%d %d\n", u, v);

        --u, --v;
        int a = uf.root(u), b = uf.root(v);
        uf.unite(u, v);
        int r = uf.root(u);
        if (r == a) {
            ++cnts[a];
        }
        else {
            cnts[r] = cnts[a] + cnts[b] + 1;
        }
    }

    bool isOK = true;
    foreach (i; 0 .. N) {
        if (uf.root(i) == i) {
            isOK &= (uf.size(i) == cnts[i]);
        }
    }

    writeln(isOK ? "Yes" : "No");
}

/// Union-Find
struct UnionFind(T)
if (isIntegral!T) {

    /// Constructor
    this(T n) nothrow @safe {
        len = n;
        par.length = len;
        cnt.length = len;
        foreach (i; 0 .. len) {
            par[i] = i;
        }
        cnt[] = 1;
    }

    /// Returns the root of x.
    T root(T x) nothrow @nogc @safe
    in (0 <= x && x < len) {
        if (par[x] == x) {
            return x;
        }
        else {
            return par[x] = root(par[x]);
        }
    }

    /// Returns whether x and y have the same root.
    bool isSame(T x, T y) nothrow @nogc @safe
    in (0 <= x && x < len && 0 <= y && y < len) {
        return root(x) == root(y);
    }

    /// Unites x tree and y tree.
    void unite(T x, T y) nothrow @nogc @safe
    in (0 <= x && x < len && 0 <= y && y < len) {
        x = root(x), y = root(y);
        if (x == y) {
            return;
        }

        if (cnt[x] > cnt[y]) {
            swap(x, y);
        }

        cnt[y] += cnt[x];
        par[x] = y;
    }

    /// Returns the size of the x tree.
    T size(T x) nothrow @nogc @safe
    in (0 <= x && x < len) {
        return cnt[root(x)];
    }

private:
    T len;
    T[] par;
    T[] cnt;
}