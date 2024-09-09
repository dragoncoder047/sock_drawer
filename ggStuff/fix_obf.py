import re


def rep(m):
   return str(int(m.group(1), 16))


s = r"""

"""

print(re.sub(r"0x([a-z\d]+)", rep, s))
