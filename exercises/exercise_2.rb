require_relative '../tester'

# This exercise to me was much more difficult to understand than to implement.
# The simple way to explain it was something like:
# Imagine a bag of random letters, how many times can we make a word like "XUXU" for example with all letters in that bag?
#
# If is that, what I really hope it is (haha), we just need to understand how many letters we need of each for
# the target word then we need to make a single pass counting each of letters of the bag, then our limit will be
# the minimum groups of required/found letters we found.

# This approach is O(n) in time and space. I really don't thing any way to improve its complexity.
def string_groups(target_string, input_string)
  required_occurrences = group_and_count(target_string.split(''))
  found_occurrences = group_and_count(input_string.split(''))

  groups = required_occurrences.map do |char, char_per_group|
    chars_found = found_occurrences[char]
    chars_found / char_per_group
  end

  groups.min
end

def group_and_count(array)
  array.inject(Hash.new(0)) { |h, e| h[e] += 1; h }
end


def run_tests
  target_string = "BALLON"

  test_cases = [
    TestCase.new([target_string, "QWEORQWLARBSFAASLGNWOTBRYLDFLHNDSH"], 2),
    TestCase.new([target_string, "BSAFLASDFLOWETNYH"], 1),
    TestCase.new([target_string, "BSAFLASDFWETNYKQEJH"], 0),
    TestCase.new([target_string, "BALLON"], 1)
  ]

  TestSuit.run_tests(test_cases, &method(:string_groups))
end

run_tests
