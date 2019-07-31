require_relative '../tester'

# This approach was:
# First mount the map of how many connections each node have.
# Then look the node with more connections, lets call it X
# Then for it, for the nodes it connects with, find who make more connections, lets call it Y
# As nodes only can have one connection with each other, we just need to compute X.connections + Y.connections - 1
# this -1 is the connection between X and Y that is summed twice.
# This approach is also O(n) in time, a bit more complex, but still O(n).
# In space it does still O(n).

def max_network_rank(a, b, n)

  nodes_relation = Hash.new {
    |h, k| h[k] = []
  }

  a.each_with_index do |ai, i|
    bi = b[i]

    nodes_relation[ai] << bi
    nodes_relation[bi] << ai

  end

  node_with_most_relation = nodes_relation.max_by {
    |k, v| v.size
  }

  related_node_with_most_relations_idx = node_with_most_relation[1].max_by {
    |i| nodes_relation[i].size
  }

  node_with_most_relation_2 = nodes_relation[related_node_with_most_relations_idx]

  node_with_most_relation[1].size + node_with_most_relation_2.size - 1
end

def run_tests
  test_cases = [
    TestCase.new([[1, 2, 3, 3, 5], [2, 3, 1, 4, 1], 5], 5),
    TestCase.new([[1, 1, 4, 5], [2, 3, 5, 6], 6], 2),
    TestCase.new([[1, 1, 1, 3, 3, 3, 6, 6], [4, 3, 2, 4, 2, 5, 5, 2], 6], 6)
  ]

  TestSuit.run_tests(test_cases, &method(:max_network_rank))
end

run_tests
