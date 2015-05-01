require "minitest/autorun"
require 'benchmark'
require './prime_table.rb'

class TestPrimeTable < MiniTest::Unit::TestCase
  
  def setup
    @prime_table = PrimeTable.new()
  end

  def test_print_30
     @prime_table.pretty_print_table
  end

  def test_print_70
    @prime_table.generate_prime_table(70)
    @prime_table.pretty_print_table
  end

  def test_print_100
    @prime_table.generate_prime_table(100)    
    @prime_table.pretty_print_table
  end

end

class BenchMarkPrimeTable
  
  test_limits = [100, 500, 1000, 10000]

  Benchmark.bm do |bm|
    prime_table = PrimeTable.new()

    bm.report('100:') do
      prime_table.generate_prime_table(test_limits[0])
    end

    bm.report('500:') do
      prime_table.generate_prime_table(test_limits[1])
    end    

    bm.report('1000:') do
      prime_table.generate_prime_table(test_limits[2])
    end    

    bm.report('10000:') do
      prime_table.generate_prime_table(test_limits[3])
    end
  end
end