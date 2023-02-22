require 'minruby'

def evaluate(tree, genv, lenv)
  case tree[0]
  when 'lit'
    tree[1]
  when '+'
    evaluate(tree[1], genv, lenv) + evaluate(tree[2], genv, lenv)
  when '-'
    evaluate(tree[1], genv, lenv) - evaluate(tree[2], genv, lenv)
  when '*'
    evaluate(tree[1], genv, lenv) * evaluate(tree[2], genv, lenv)
  when '/'
    evaluate(tree[1], genv, lenv) / evaluate(tree[2], genv, lenv)
  when '%'
    evaluate(tree[1], genv, lenv) % evaluate(tree[2], genv, lenv)
  when '**'
    evaluate(tree[1], genv, lenv) ** evaluate(tree[2], genv, lenv)
  when '>'
    evaluate(tree[1], genv, lenv) > evaluate(tree[2], genv, lenv)
  when '<'
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when '=='
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when 'func_call'
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i += 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'buildin'
      minruby_call(mhd[1], args)
    else
      # TODO
    end
  when 'stmts'
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], genv, lenv)
      i += 1
    end
    last
  when 'var_assign'
    lenv[tree[1]] = evaluate(tree[2], genv, lenv)
  when 'var_ref'
    lenv[tree[1]]
  when 'if'
    if evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    else
      evaluate(tree[3], genv, lenv)
    end
  when 'while'
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  when 'while2'
    while evaluate(tree[1], genv, lenv)
      evaluate(tree[2], genv, lenv)
    end
  else
    raise "unsupport operater: #{tree[0]}"
  end
end


def add(a, b)
  a + b
end

genv = { 'p' => ['buildin', 'p'], 'add' => ['buildin', 'add'] }
lenv = {}
inputs = minruby_load()
tree = minruby_parse(inputs)
evaluate(tree, genv, lenv)
pp tree
