def append_size(lst):
  lst.append(len(lst))
  return lst

def append_sum(lst):
  lst.append(lst[-1] + lst[-2])
  lst.append(lst[-1] + lst[-2])
  lst.append(lst[-1] + lst[-2])
  return lst

def larger_list(lst1, lst2):
  if len(lst1) >= len(lst2):
    return lst1[-1]
  else:
    return lst2[-1]

def more_than_n(lst, item, n):
  if lst.count(item) > n:
    return True
  else:
    return False

def combine_sort(lst1, lst2):
  unsorted = lst1 + lst2
  sortedList = sorted(unsorted)
  return sortedList

def every_three_nums(start):
  return list(range(start, 101, 3))

def remove_middle(lst, start, end):
  return lst[:start] + lst[end+1:]

def more_frequent_item(lst, item1, item2):
  if lst.count(item1) >= lst.count(item2):
    return item1
  else:
    return item2

def double_index(lst, index):
  # Checks to see if index is too big
  if index >= len(lst):
    return lst
  else:
    # Gets the original list up to index
    new_lst = lst[0:index]
 # Adds double the value at index to the new list 
  new_lst.append(lst[index]*2)
  #  Adds the rest of the original list
  new_lst = new_lst + lst[index+1:]
  return new_lst

def middle_element(lst):
  if len(lst) % 2 == 0:
    sum = lst[int(len(lst)/2)] + lst[int(len(lst)/2) - 1]
    return sum / 2
  else:
    return lst[int(len(lst)/2)]

# List comprehension
words = ["@coolguy35", "#nofilter", "@kewldawg54", "reply", "timestamp", "@matchamom", "follow", "#updog"]
usernames = []
usernames = [word for word in words if word[0] == '@']

single_digits=range(10)
squares=[]
for digit in single_digits:
  squares.append(digit**2)
  print(digit)
print(squares)
cubes=[digit**3 for digit in single_digits]
print(cubes)