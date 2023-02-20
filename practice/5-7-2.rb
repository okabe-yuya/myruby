require 'minruby'
require_relative '../simple_test'

def evaluate(tree, env)
  case tree[0]
  when 'lit'
    tree[1]
  when '+'
    env['plus_count'] += 1
    evaluate(tree[1], env) + evaluate(tree[2], env)
  when 'func_call'
    p(evaluate(tree[2], env))
  when 'stmts'
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], env)
      i += 1
    end
    last
  when 'var_assign'
    env[tree[1]] = evaluate(tree[2], env)
  when 'var_ref'
    env[tree[1]]
  else
    raise "unsupport operater: #{tree[0]}"
  end
end


it '+が実行された回数が正しく記録される' do
  inputs = "
  plus_count = 0
  x = 1 + 2 + 3
  p(plus_count)
  x = 1 + 2 + 3
  p(plus_count)
  "
  env = {}
  tree = minruby_parse(inputs)
  answer = evaluate(tree, env)
  expect(answer, 4)
end