int a
int b

def gcd(int a, int b) -> int:
  while (a != b):
    if (b < a):
      a = a - b
    endef else:
      b = b - a
    endef
  endef
  return a
endef

def main() -> int:
  int x
  int y
  int one
  int four
  a = 18
  b = 9
  x = 2
  y = 14
  four = 2 * 2
  one = 2 / 2
  print(gcd(x,y))
  print(gcd(3,15))
  print(gcd(99,121))
  print(gcd(a,b))
  print(four)
  print(one)
  return 0
endef
