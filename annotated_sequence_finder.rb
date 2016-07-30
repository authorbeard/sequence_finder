# find number of occurrences of smaller string within larger string
# —chars need to occur sequentially, but don’t have to be adjacent
# —no guarantees about length/composition of either string (ie, string might not just be query string repeating, could be mixture of types of characters)


def find_query_string(string, query)
  string_array=string.split("")
  q=query[0]
## A FEW QUICK TESTS, FOR BOTH RECURSION BASE CASES AND SOME EDGE CASES ##
  if query.length > string.length
    return "Sorry, I think you got them backward."
  end

  return 0 if !string_array.include?(q)
  return string.count(q) if query.length == 1
## query is more than 1 letter long, first letter is in string
## begin looking for substrings beginning with first letter of query and containing at least one complete query sequence
  subs=[]
  string_array.each_with_index{|char, index|
    if char == q
      sub=string.slice(index..-1)
      next if sub.length < query.length #additional check to skip junk at the end
    ## Check for next letter of query in section of string from first match to end.
    ## recursion time: walk through both query and substring; as soon as I encounter a missing part of the query sequence, I move on to the next substring
      sub_check = find_query_string(sub, query.slice(1..-1))
    ## All of the query letters are present in the correct order, so save that substring to examine later
      if sub_check != 0
        subs.push(sub)
      end
    end
  }
## Now I need to see how many versions of the sequence occur in each string
## I'm going to check every occurence of every character between the first and the last.
## Note: at present, this breaks for strings longer than 5 chars. 
  subs.collect{|str|
    ## Check for easy cases: ##
    if query.length==2
      str.count(query[1])
    else
      sub_counter(str, query)
    end
  }.reduce(:+)


end


def sub_counter(substring, query, count=0)
## I know the substring contains the first letter of the query. I need to look for combinations of the rest of the sequence. I'll use the second letter later for the recursion, so I'll store that first. 
  q=query[1]
## Since I can't just call #last on a string, I'll store the last char in a variable
  q_last=query.slice(-1)
## One loop will be altering the array it uses, but I might have to walk through this string several times, so I'll probably need a 'canonical' version of the string as an array. Don't want to type this again and again, so again: set it now. 
  s_array=substring.split("")
## This is the array I'll need to check; I can skip the first char, since substrings, by definition here, all begin with the first letter of the query sequence and I don't care about other occurences of that letter. If any of them start a new occurence of the query sequence, they'll have their own substrings that will get checked here later. 
  test_array=s_array[1..-1]

## finally, two more things to increment: 
## First, I'm walking through until I find the first ocurrence of each char in the query string. When I do, I need to walk through and look for the next one. So I'll store each char in a variable I can compare to the query in some way, then create a counter so I can move the query sequence forward. 
## Ruby's #next will cause errors here, since it refers to the next X in some sequence other than the sequence at hand. There's no guarantee that my sequence will proceed in that order (it could be '1h56z'), so I can't just use that. 
  seq=query[0]
  n=1

## The loops: The only place I can be sure that simply counting one char is the last step is when I've found all but one of the query sequence. But I'll always be at the first intance of those chars for the given string. So I need to two things: 
## 1. check each instance of the next-to-last char for any following occurences of last char
## 2. start again with next instance of query[1] to see if the query sequence repeats afterward, then count up all the variations. 
## The outer loop here does #1, handily whittling down the size of the test array as it goes.
  while test_array.include?(query[-2])
    until seq.length == query.length-1
      test=test_array.shift
      if test==query[n]
        seq += test
        n+=1
      end 
    end
    count+=test_array.count(q_last)
## This makes sure that, each time through until the first line returns false, I'm still looking for the next-to-last char by popping that out of the variable that I'm comparing to the query and turning the counter back by one.     
    seq=seq.slice(0...-1)
    n-=1
  end

## Finally, some recursion: there might be multiple occurrences of the second char of the query string here. 
## Check for that; if there are multiple occurrences, slice off the part of the subtring beginning after the first occurrence and then go from there. If not, just return the count as it stands. 
  if s_array.count(q) > 1
    i=substring.index(q)
    s=substring.slice(i+1..-1)
    sub_counter(s, query, count)
  else
    count
  end


end