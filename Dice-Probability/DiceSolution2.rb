#Mutel

N=ARGV[0].to_i
M=ARGV[1].to_i

exit 1 if N <= 0 || M < N

def count(n,m)
  return 0 if m < n
  return (m >= 1 && m <= 6) ? 1 : 0 if n == 1
  return (1..6).map {|i| count(n-1, m-i)}.inject(0){|sum, item| sum+item}
end

puts count(N,M)