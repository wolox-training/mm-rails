class String
  def is_number?
    self !~ /\D/
  end
end
