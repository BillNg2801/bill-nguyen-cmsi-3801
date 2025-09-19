## 1. Why is the null reference so hideous?

Tony Hoare introduced the null reference in 1965 while designing ALGOL W. It gave programmers a uniform way to represent “no object” with a special pointer value, which made linked structures and optional parameters easy and efficient to implement.
But the tradeoff was huge: every reference could secretly be null, so every dereference might crash. This led to decades of bugs and vulnerabilities. Hoare later called it his “billion-dollar mistake.”
Edsger Dijkstra had argued against it from the start, since introducing an unchecked “absent” state violated safety and reasoning principles in programs. At the time, though, type systems didn’t yet offer safer constructs (like Option or Maybe), so null seemed like the pragmatic shortcut

