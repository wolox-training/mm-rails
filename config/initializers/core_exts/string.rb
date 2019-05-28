class String
  def contains_only_digits?
    self !~ /\D/
  end
end
