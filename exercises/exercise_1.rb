require_relative '../tester'

# Just the trivial filter multiples of 11 and get the maximum one. O(n) in time
def max_11_multiples(array)
  array.select { |i| i % 11 == 0 }.max
end

def run_tests
  test_cases = [
    TestCase.new([[0, 1, -30, -33, 10, 11, 33, 66, 121]], 121),
    TestCase.new([[-55, -11, -3]], -11)
  ]

  TestSuit.run_tests(test_cases, &method(:max_11_multiples))
end

run_tests
