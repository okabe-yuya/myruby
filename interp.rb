require 'minruby'

def evaluate(tree)
  case tree[0]
  when 'lit'
    tree[1]
  when '+'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left + right
  when '-'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left - right
  when '*'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left * right
  when '/'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left + right
  when '%'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left % right
  when '**'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left ** right
  when '>'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left > right
  when '<'
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left < right
  when '=='
    left = evaluate(tree[1])
    right = evaluate(tree[2])
    left == right
  else
    raise "unsupport operater: #{tree[0]}"
  end
end

# inputs = gets

tree = minruby_parse('2 * 3 > 2 + 3')

pp tree
answer = evaluate(tree)

p(answer)