def odd_indices(lst):
  new_lst=[]
  for index in range(1, len(lst), 2):
    new_lst.append(lst[index])
  return new_lst

def exponents(bases,powers):
  new_lst=[]
  for base in bases:
    for power in powers:
      new_lst.append(base**power)
  return new_lst

def larger_sum(lst1,lst2):
  sum1=0
  sum2=0
  for i in lst1:
    sum1+=i
  for i in lst2:
    sum2+=i
  if sum2 > sum1:
    return lst2
  else:
    return lst1

def over_nine_thousand(lst):
  sum=0
  for i in lst:
    sum+=i
    if sum > 9000:
      break
  return sum

def max_num(nums):
  largest=nums[0]
  for i in nums:
    if i > largest:
      largest=i
  return largest

def same_values(lst1,lst2):
  new_lst=[]
  for index in range(len(lst1)):
    if lst1[index]==lst2[index]:
      new_lst.append(index)
  return new_lst

def reversed_list(lst1,lst2):
  for index in range(len(lst1)):
    if lst1[index] != lst2[len(lst2)-1-index]:
      return False
  return True