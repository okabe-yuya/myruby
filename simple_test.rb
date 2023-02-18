def expect(result, expect)
  [result, expect]
end

def it(name, &block)
  result, expect = yield
  if result == expect
    printf "Case: #{name}: "
    print "\e[32m"; puts 'success'; print "\e[0m"
  else
    raise "unexpected result\nexpect(#{expect})\nresult(#{result})"
  end
end
