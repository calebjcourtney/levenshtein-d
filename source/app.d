import std.stdio;
import std.conv;
import std.algorithm: min;


int levenshteinDistance(string s, string t) {
    int m = s.length.to!int;
    int n = t.length.to!int;

    // Create two work arrays of integer distances
    int[] v0 = new int[n + 1];
    int[] v1 = new int[n + 1];

    // Initialize v0 (the previous row of distances)
    foreach (i; 0 .. n + 1) {
        v0[i] = i;
    }

    foreach (i; 0 .. m) {
        // Calculate v1 (current row distances) from the previous row v0
        v1[0] = i + 1;

        foreach (j; 0 .. n) {
            // Calculating costs for A[i + 1][j + 1]
            int deletionCost = v0[j + 1] + 1;
            int insertionCost = v1[j] + 1;
            int substitutionCost = v0[j] + (s[i] == t[j] ? 0 : 1);

            v1[j + 1] = min(deletionCost, insertionCost, substitutionCost);
        }

        // Copy v1 (current row) to v0 (previous row) for the next iteration
        v0[] = v1[];
    }

    // After the last swap, the results of v1 are now in v0
    return v0[n];
}


unittest
{
    assert(levenshteinDistance("cat", "rat") == 1);
    assert(levenshteinDistance("parks", "spark") == 2);
    assert(levenshteinDistance("abcde", "abcde") == 0);
    assert(levenshteinDistance("abcde", "abCde") == 1);
    assert(levenshteinDistance("kitten", "sitting") == 3);
}


void main() {
    string s = "kitten";
    string t = "sitting";
    int distance = levenshteinDistance(s, t);
    writeln("Levenshtein Distance: ", distance);
}
