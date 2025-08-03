module mylib;

import std.range : empty;
import std.process : pipeShell, Redirect, execute;
import std.stdio;
import core.stdc.stdlib : exit;
import std.conv : to;
import std.algorithm : strip;

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

void clipcopy(string text) {
    string cmd = "xclip -selection clipboard";

    auto pipe = pipeShell(cmd, Redirect.stdin);
    scope(exit) pipe.stdin.close();

    pipe.stdin.write(text);
    pipe.stdin.flush();
}

string clippaste() {
    auto result = execute(["xclip", "-selection", "clipboard", "-o"]);
    return result.output;
}