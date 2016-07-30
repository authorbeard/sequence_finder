def find_query_string(string, query)
  string_array=string.split("")
  first_char=query[0]
  if query.length > string.length
    return "Sorry, I think you got them backward."
  end

  return 0 if !string_array.include?(first_char)
  return string.count(first_char) if query.length ==1

  substring_array=[]
  string_array.each_with_index{|char, index|
    if char == first_char
      sub=string.slice(index..-1)
      next if sub.length < query.length 
      sub_check = find_query_string(sub, query.slice(1..-1))
  
      if sub_check != 0
        substring_array.push(sub)
      end
    end
  }

  substring_array.collect{|str|
    if query.length==2
      str.count(query[1])
    else
      sub_counter(str, query)
    end
  }.reduce(:+)

end


def sub_counter(substring, query, count=0)
  next_char=query[1]
  last_char=query.slice(-1)
  s_array=substring.split("")
  test_array=s_array[1..-1]

  seq=query[0]
  n=1

  while test_array.include?(query[-2])
    until seq.length == query.length-1
      test=test_array.shift
      if test==query[n]
        seq += test
        n+=1
      end 
    end
    count+=test_array.count(last_char)
    seq=seq.slice(0...-1)
    n-=1
  end

  if s_array.count(next_char) > 1
    i=substring.index(next_char)
    s=substring.slice(i+1..-1)
    sub_counter(s, query, count)
  else
    count
  end


end