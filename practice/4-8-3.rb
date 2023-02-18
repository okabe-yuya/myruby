require 'minruby'
require_relative '../simple_test'

def search_max(tree)
  if tree[0] == 'lit'
    tree[1]
  else
    left = search_max(tree[1])
    right = search_max(tree[2])

    left > right ? left : right
  end
end


it '1 + 4 + 3 + 2 + 6 + 1 から6が選ばれる' do
  tree = minruby_parse('1 + 4 + 3 + 2 + 6 + 1')
  answer = search_max(tree)
  expect(answer, 6)
end

it '1 + 3 * 2 から3が選ばれる' do
  tree = minruby_parse('1 + 3 * 2')
  answer = search_max(tree)
  expect(answer, 3)
end