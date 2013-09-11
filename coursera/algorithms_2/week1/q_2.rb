input = ARGV[0]

jobs = []
File.open(input) do |f|
  f.gets.to_i.times { jobs << f.gets.split(" ").map(&:to_i) }
end


jobs.map!{ |job| [job[0], job[1], job[0].to_f/job[1]] }
jobs.sort! do |a, b|
  if a[2] < b[2]
    1
  elsif a[2] > b[2]
    -1
  else
    if a[0] < b[0]
      1
    else
      -1
    end
  end
end

weighted_sum = 0
time = 0
jobs.each do |job|
  time += job[1]
  weighted_sum += time * job[0]
end

p weighted_sum
