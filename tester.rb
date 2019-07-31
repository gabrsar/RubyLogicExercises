# This is a (much simpler)³ RSpec like class I wrote to test some few things I was
# studding in Ruby.
#
# Basically it has TestCase who handle specific tests and a TestSuit that
# take care of running every test and split it into successful and failed
# groups.

class TestCase

  def initialize(arguments, expected_response)
    @arguments = arguments
    @expected_response = expected_response
  end

  def test(function)
    result = function.call(*@arguments)
    TestResult.new(self, result)
  end

  def arguments
    @arguments
  end

  def expected_response
    @expected_response
  end

  def to_s
    "TestCase(expected_response=#{@expected_response} arguments=#{@arguments})"
  end

end

class TestResult

  def initialize(test_case, response)
    @test_case = test_case
    @response = response
  end

  def success?
    @test_case.expected_response == @response
  end

  def to_s
    "TestResult(success=#{success?} response=#{@response} #{@test_case})"
  end

end

class TestSuit
  def self.run_tests(tests, &function)
    results = tests.map { |t| t.test(function) }.group_by(&:success?)

    puts "Successful cases:"
    puts results[true] || "none"

    puts ""
    puts "Failed cases:"
    puts results[false] || "none"
  end
end