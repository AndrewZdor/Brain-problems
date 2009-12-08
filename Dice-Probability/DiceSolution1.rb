# Performance can be increased by 2 time faster if we will calculate half combinations, 
# because this probability is binominal distribution

# Быстродействие можно увеличить в 2 раза просчитывая комбинации до половины,
# поскольку вероятность выпадения числа есть биноминальное распределение.
# Хотя и так укладывается во временные рамки. около 3 sec для 300 костей на Core 2 Duo 2.00 Ghz


if ARGV.size == 0
  puts 'Usage : '+__FILE__+' N M , where N is number of dices, M is required sum'
  exit 1
end

N=ARGV[0].to_i # dice number
M=ARGV[1].to_i # value
S = 6 # sides on die

puts 'Warning: N should be positive' if N < 0
puts "Warning: M should be between #{N} and #{N*S}" if M < N || M > N*S

arr1 = [1]*S
arr2 = [1]*S

start = Time.now
for i in 2..N do
  (2..S).each do
    arr2.unshift(0)
    arr2.each_index {|x| arr1[x] = arr1[x].to_i + arr2[x].to_i }
  end
  arr2.replace(arr1)
end
run_time = Time.now - start

puts arr2[M-N]/(S**N).to_f
#p sprintf("%d min ", run_time / 60) + sprintf("%0.2f sec", run_time % 60)