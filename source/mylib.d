module mylib;

import std.range : empty;

auto byteprint(string[] bytedata, int reverse) {
    string ass;
    if (reverse == 0) {
        foreach (line; bytedata) {
            ass ~= line.idup ~ "\n";
        }
    } else if (reverse == 1) {
        foreach_reverse (line; bytedata) {
            ass ~= line.idup ~ "\n";
        }
    } else {
        throw new Exception("0 or 1");
    }
    if (!ass.empty && ass[$-1] == '\n') {
        ass = ass[0 .. $-1];
    }
    return ass;
}
