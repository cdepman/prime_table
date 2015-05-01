
class PrimeTable
  
  def initialize(upper_limit = 30)
    generate_prime_table(upper_limit)
  end

  def generate_prime_table(upper_limit)
    primes = prime_generator(upper_limit) # generate primes
    table = Array.new(primes.length+1) {Array.new()} # generate empty table
    table_axis_labeler(table, primes, primes) # set axis labels

    # populate table
    primes.each_index do |index|
      primes.each_index do |index2|
        table[index+1][index2+1] = table[index2+1][index+1] = primes[index] * primes[index2]
      end
    end

    @table = table
  end

  def prime_generator(limit)
    nums = (2...limit).to_a # create initial array of candidate nums
    i = 0;
    while (i < Math.sqrt(limit)) # anything past n^2 will just be repetitive
      if nums[i] != nil
        knockout_multiples(nums, i, nums[i]) # sieve out multiples
      end
      i = next_true_index(i+1, nums) # advance to next legal option
    end
    nums.compact # filter out nil values
  end

  def next_true_index(currentIndex, array)
    while (array[currentIndex] == nil && currentIndex < array.length)
      currentIndex += 1
    end
    currentIndex
  end

  def knockout_multiples(array, startIndex, multiple)
    startIndex += multiple
    for i in (startIndex..array.length).step(multiple)
      array[i] = nil
    end
    array
  end

  def table_axis_labeler(table, x_axis, y_axis)
    table[0] = Array.new(x_axis).unshift(" ")
    table.each_index do |row_index|
      break if row_index == y_axis.length
      table[row_index+1][0] = y_axis[row_index]
    end
  end

  def pretty_print_table()
    @table.each_index do |index|
      if index == 0
        print " "
      elsif index == 1
        puts "   "
        puts "      *" + " -"*((@table.length*2.9)) # create x-axis separator
      elsif index != 0
        puts ""
      end
      @table.each_index do |index2|
        if index2 == 1 && index > 0
          print "|" # create y-axis separator
        end
        if @table[index][index2].to_i < 10 # offset nums according to ten's place
          print "     " + (@table[index][index2]).to_s 
        elsif  @table[index][index2].to_i < 100
          print "    " + (@table[index][index2]).to_s       
        elsif  @table[index][index2].to_i < 1000
          print "   " + (@table[index][index2]).to_s
        elsif  @table[index][index2].to_i < 10000
          print "  " + (@table[index][index2]).to_s
        elsif  @table[index][index2].to_i < 100000
          print " " + (@table[index][index2]).to_s
        else
          print (@table[index][index2]).to_s
        end
      end
    end
    puts ""
  end
end
