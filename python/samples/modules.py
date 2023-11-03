# Import datetime from datetime below:
from datetime import datetime
current_time=datetime.now()
print(current_time)

# ===========

import random
random_list=[random.randint(1,101) for i in range(101)]
print(random_list)
randomer_number=random.choice(random_list)
print(randomer_number)

# ===========

import codecademylib3_seaborn
from matplotlib import pyplot as plt
import random
numbers_a=range(1,13)
numbers_b=random.sample(range(1000),12)
plt.plot(numbers_a,numbers_b)
plt.show()

# ===========

# Import Decimal below:
from decimal import Decimal
# Fix the floating point math below:
two_decimal_points = Decimal('0.2') + Decimal('0.69')
print(two_decimal_points)
four_decimal_points = Decimal('0.53') * Decimal('0.65')
print(four_decimal_points)