# Replace IRB with Pry for rails console
begin
  unless Rails.env.production?
    Object.send(:remove_const, :IRB) if Object.const_defined? :IRB
    IRB = Pry
  end
rescue LoadError
end
