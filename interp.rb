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
  when '>='
    evaluate(tree[1], genv, lenv) >= evaluate(tree[2], genv, lenv)
  when '<'
    evaluate(tree[1], genv, lenv) < evaluate(tree[2], genv, lenv)
  when '<='
    evaluate(tree[1], genv, lenv) <= evaluate(tree[2], genv, lenv)
  when '=='
    evaluate(tree[1], genv, lenv) == evaluate(tree[2], genv, lenv)
  when '!='
    evaluate(tree[1], genv, lenv) != evaluate(tree[2], genv, lenv)
  when 'func_def'
    genv[tree[1]] = ['user_defined', tree[2], tree[3]]
  when 'func_call'
    args = []
    i = 0
    while tree[i + 2]
      args[i] = evaluate(tree[i + 2], genv, lenv)
      i = i + 1
    end
    mhd = genv[tree[1]]
    if mhd[0] == 'buildin'
      minruby_call(mhd[1], args)
    else
      new_lenv = {}
      params = mhd[1]
      i = 0
      while params[i]
        new_lenv[params[i]] = args[i]
        i = i + 1
      end
      evaluate(mhd[2], genv, new_lenv)
    end
  when 'ary_new'
    ary = []
    i = 0
    while tree[i + 1] != nil
      ary[i] = evaluate(tree[i + 1], genv, lenv)
      i = i + 1
    end
    ary
  when 'ary_ref'
    ary = evaluate(tree[1], genv, lenv)
    idx = evaluate(tree[2], genv, lenv)
    ary[idx]
  when 'ary_assign'
    ary = evaluate(tree[1], genv, lenv)
    idx = evaluate(tree[2], genv, lenv)
    ary[idx] = evaluate(tree[3], genv, lenv)
  when 'hash_new'
    h = {}
    i = 0
    while tree[i + 1] != nil
      key = evaluate(tree[i + 1], genv, lenv)
      value = evaluate(tree[i + 2], genv, lenv)
      h[key] = value
      i = i + 22
    end
    h
  when 'stmts'
    i = 1
    last = nil
    while tree[i] != nil
      last = evaluate(tree[i], genv, lenv)
      i = i + 1
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


genv = {
  'p' => ['buildin', 'p'],
  'require' => ['buildin', 'require'],
  'minruby_parse' => ['buildin', 'minruby_parse'],
  'minruby_load' => ['buildin', 'minruby_load'],
  'minruby_call' => ['buildin', 'minruby_call'],
}
lenv = {}
inputs = minruby_load()
tree = minruby_parse(inputs)

evaluate(tree, genv, lenv)