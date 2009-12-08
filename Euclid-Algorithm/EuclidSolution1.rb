# Mutel
# taken from http://en.wikipedia.org/wiki/Extended_Euclidean_algorithm , iterative method

def egcd(a,b)
x, y = 0, 1
lx,ly = 1, 0

while b != 0
  q, r = a.divmod(b)
  a, b = b, r
  x, lx = lx - q*x, x
  y, ly = ly - q*y, y
end
return [lx, ly, a]
end

def egcdn(lnum)
lcoef=[]
xa, xb, d = egcd(lnum[0], lnum[1])
lcoef[0] = xa
lcoef[1] = xb
(2...lnum.length).each {|i|
xa, xb, d = egcd(d, lnum[i])
(0...i).each {|j| lcoef[j]*=xa }
lcoef[i] = xb
}
return lcoef, d
end

# main part

LNUM=ARGV.map{|s|s.to_i}
lcoef, d = egcdn(LNUM)

d0 = (0...lcoef.length).inject(0){|sum,i| sum+LNUM[i]*lcoef[i]}
s="#{lcoef[0]}*#{LNUM[0]}"
(1...lcoef.length).each {|i|
s+="+" if lcoef[i] >= 0
s+="#{lcoef[i]}*#{LNUM[i]}"
}

puts "#{s}=#{d}(#{d0})"

