def to_power(num,power):
	return num**power

def to_sq_root(num):
	return num**0.5

def to_pct(wins,losses):
  return wins/(wins+losses)*100

def get_avg(num1,num2):
  return (num1 + num2) / 2

def get_remain(num1, num2):
  return (2 * num1) % (num2 / 2)

def exponents(bases,powers):
  new_lst=[]
  for base in bases:
    for power in powers:
      new_lst.append(base**power)
  return new_lst