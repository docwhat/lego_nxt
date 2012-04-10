HAS_NXT = ENV['HAS_NXT'] == 'true'

if not HAS_NXT
  puts "**NOTE** Some tests are marked pending because you did not indicate you have a NXT brick."
  puts "         To run all tests, plugin a NXN brick via USB, power it on, and set"
  puts "         the environment variable 'HAS_NXT' to 'true'."
end

def requires_nxt
  pending("this test requires a NXT brick") unless HAS_NXT
end
