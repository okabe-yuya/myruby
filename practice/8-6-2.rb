def even?(n)
  if n == 0
    true
  else
    odd?(n-1)
  end
end

def odd?(n)
  if n == 0
    false
  else
    even?(n-1)
  end
end


even?(3)