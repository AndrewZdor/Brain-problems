#dseverin

start = Time.now

def C(n, k)
  return 0 if k < 0  || k > n
  return 1 if k == 0 || k == n
  p1 = 1
  p2 = 1
  for i in 1..k
    p1 *= n - i + 1
    p2 *= i
  end
  p1 / p2
end


S = 6 # sides on die
N = ARGV[0].to_i # dice number
M = ARGV[1].to_i # value

require 'benchmark'
require 'rational'

for m in M..M
sum = 0
p = q = r = 1 # ruby1.9 would make them block-local otherwise
for k in 0..( (m - N) / S ) # sum(k=0..[(N-M)/S]; (-1)^k*C(N,k)*C(M - s * k - 1, N-1)) -- from Wikipedia
  t = m - S * k - 1

  if ARGV[2] || k == 0
    q = C( N , k )
    r = C( t , N - 1)
  else
    q = q * ( N - k + 1) / k
    p1 = 1
    p2 = 1
    for l in 1..S
      p1 *= t + l
      p2 *= t + l - (N - 1)
    end
    r = r * p2 / p1
  end

  sum += p * q * r
  p = -p
end

print m, " "
puts ((Rational(sum) / Rational(S ** N)).to_f)
end

run_time = Time.now - start
p sprintf("%d min ", run_time / 60) + sprintf("%0.2f sec", run_time % 60)
