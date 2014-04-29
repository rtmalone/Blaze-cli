require 'rspec/expectations'

def blaze_with_input(*inputs)
  shell_output = ""
  IO.popen('./blaze', 'r+') do |pipe|
    inputs.each do |input|
      pipe.puts input
    end
    pipe.close_write
    shell_output << pipe.read
  end
  shell_output
end
