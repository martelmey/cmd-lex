def first_three_multiples(num):
  print(num)
  print(num * 2)
  print(num * 3)
  return num * 3

def tip(total, percentage):
  tip_amount = (total * percentage) / 100
  return tip_amount

def introduction(first_name, last_name):
  return last_name + ", " + first_name + " " + last_name

def dog_years(name, age):
  return name+", you are "+str(age * 7)+" years old in dog years"

def lots_of_math(a, b, c, d):
  first = a + b
  second = c - d
  third = first * second
  fourth = third % a
  print(first)
  print(second)
  print(third)
  return fourth