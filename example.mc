int a;
int b;

def gcd(int a, int b) -> int {
  while (a != b) {
    if (b < a) a = a - b;
    else b = b - a;
  }
  return a;
}

def main() -> int {
  int x;
  int y;
  a = 18;
  b = 9;
  x = 2;
  y = 14;
  print(gcd(x,y));
  print(gcd(3,15));
  print(gcd(99,121));
  print(gcd(a,b));
  return 0;
}
