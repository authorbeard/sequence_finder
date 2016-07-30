def find_query_string(string, query)
  string_array=string.split("")
  q=query[0]
  if query.length > string.length
    return "Sorry, I think you got them backward."
  end

  if !string_array.include?(q) 
    return 0
  end

  if query.length == 1
    return string.count(q)
  end
  subs=[]
  string_array.each_with_index{|char, index|
    if char == q
      sub=string.slice(index..-1)
      next if sub.length < query.length #additional check to skip junk at the end
  
  
      sub_check = find_query_string(sub, query.slice(1..-1))
  
      if sub_check != 0
        subs.push(sub)
      end
    end
  }
  subs.collect{|str|
  
    if query.length==2
      str.count(query[1])
    else
      sub_counter(str, query)
    end
  }.reduce(:+)


end


def sub_counter(substring, query, count=0)
  q=query[1]
  q_last=query.slice(-1)
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
    count+=test_array.count(q_last)
    seq=seq.slice(0...-1)
    n-=1
  end

  if s_array.count(q) > 1
    i=substring.index(q)
    s=substring.slice(i+1..-1)
    sub_counter(s, query, count)
  else
    count
  end


end