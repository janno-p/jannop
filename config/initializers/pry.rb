# Replace IRB with Pry for rails console
begin
  Object.send(:remove_const, :IRB) if Object.const_defined? :IRB
  IRB = Pry
rescue LoadError
end
