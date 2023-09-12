cat input.txt | python3 program.py | diff -q - expected.txt >/dev/null && echo "WIN" || echo "FAIL"
