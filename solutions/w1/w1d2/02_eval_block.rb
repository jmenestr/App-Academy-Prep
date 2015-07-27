def eval_block(*args, &prc)
  if prc.nil?
    raise "NO BLOCK GIVEN!"
  else
    prc.call(*args)
  end
end
