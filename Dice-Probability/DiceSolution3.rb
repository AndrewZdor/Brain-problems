# Mutel
# http://en.wikipedia.org/wiki/Dice#Probability
# http://en.wikipedia.org/wiki/Sampling_equiprobably_with_dice

n=ARGV[0].to_i
m=ARGV[1].to_i

@countmem=Hash.new {|h,n| h[n]={}}

def count(n,m)
  return 0 if m < n
  return (m >= 1 && m <= 6) ? 1 : 0 if n == 1
  @countmem[n][m] = (1..6).map{|i| count(n-1, m-i)}.inject(0){|sum, item| sum+item} unless @countmem.has_key?(n) && @countmem[n].has_key?(m)
  return @countmem[n][m]
end