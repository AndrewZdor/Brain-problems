#UdontKnowMe

# note: этот код сразу заполняет матрицу вероятностями, за счет чего может накапливаться погрешность.
# если хотим более точно -- нужно на матрице считать исходы. но тогда потеряем в скорости на длинной арифметике
# (те самые 10-15%, о которых говорил в первоначальном посте).
# впрочем, даже если считать исходы в требования должно легко укладываться.

start = Time.now

if ARGV.length != 2
  puts "exactly two arguments expected (N, M)"
  exit(1)
end

DICE_FACES = 6
N = ARGV[0].to_i
M = ARGV[1].to_i

# needed additional method for domain specific operation
class DomainArray < Array
  def safe_at(idx)
    idx >= 0 && idx < length ? at(idx) : 0.0
  end
end

# first step is obvious. actually zero-index dont used.
cur_step = DomainArray.new(DICE_FACES + 1) { |idx| idx == 0 ? 0.0 : 1.0 / DICE_FACES }

(2..N).each do |dice_num|
  prev_step = cur_step

  len = dice_num * DICE_FACES
  cur_step = DomainArray.new(len + 1) { 0.0 }

  idx1 = dice_num - 1 # needed for not to calculate "idx - 1" many times in loop
  ext_len = len + dice_num # needed for not to calculate "len + dice_num" many times in loop
  half_len = ext_len / 2 # symmetry axis

  # main cycle that calculates probabilities
  (dice_num..half_len).each do |idx|
    cur_step[ext_len - idx] = cur_step[idx] = cur_step.at(idx1) +
      (prev_step.safe_at(idx1) - prev_step.safe_at(idx1 - DICE_FACES)) / DICE_FACES
    idx1 = idx
  end
end

probability = cur_step.safe_at(M)

printf("%.10f", probability)

run_time = Time.now - start
p sprintf("%d min ", run_time / 60) + sprintf("%0.2f sec", run_time % 60)
