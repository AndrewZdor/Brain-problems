# Mutel

start = Time.now

S=6
@countmem=Hash.new {|h,n| h[n]={}}

def count(n,m)
  return 0 if n <= 0 || m < n || m > n*S
  return (m >= 1 && m <= S) ? 1 : 0 if n == 1

  if @countmem.has_key?(n) && @countmem[n].has_key?(m)
    return @countmem[n][m]
  else
    x=n/2
    y=n-x
    @countmem[n][m] = (x..[m, y*S].min).map{|i|count(x,i)*count(y,m-i)}.inject(0){|sum, item| sum+item}
    return @countmem[n][m]
  end
end

if ARGV.size == 0
  puts 'Usage : '+__FILE__+' N M , where N is number of dices, M is required sum'
  exit 1
end

N=ARGV[0].to_i
M=ARGV[1].to_i

puts 'Warning: N should be positive' if N < 0
puts "Warning: M should be between #{N} and #{N*S}" if M<N || M>N*S

c=count(N,M)

run_time = Time.now - start

puts c, Float(c)/S**N
p sprintf("%d min ", run_time / 60) + sprintf("%0.2f sec", run_time % 60)