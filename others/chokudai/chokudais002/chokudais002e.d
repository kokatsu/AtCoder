import std;

void main() {
    int N;
    readf("%d\n", N);

    long res;
    foreach (_; 0 .. N) {
        long A, B;
        readf("%d %d\n", A, B);

        res += min(A/2, B);
    }

    res.writeln;
}