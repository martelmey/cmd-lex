def account_generator(first_name,last_name):
  temp_password=first_name[:3]+last_name[:3]
  return temp_password

# ===========

length = len(favorite_fruit)
last_chars = favorite_fruit[length-4:]
print(last_chars)

# ===========

first_name = "Reiko"
last_name = "Matsuki"
def password_generator(first_name,last_name):
  fn_last_3=first_name[len(first_name)-3:]
  ln_last_3=last_name[len(last_name)-3:]
  return fn_last_3+ln_last_3
temp_password=password_generator(first_name,last_name)
print(temp_password)

# ===========

company_motto = "Copeland's Corporate Company helps you capably cope with the constant cacophony of daily life"
second_to_last=company_motto[-2:-1]
print(second_to_last)
final_word=company_motto[-4:]
print(final_word)

# ===========

first_name = "Bob"
last_name = "Daily"
fixed_first_name="R"+first_name[1:]
print(fixed_first_name)

# ===========

def get_length(string):
  count=0
  for letter in string:
    count+=1
  return count

# ===========

def letter_check(word,letter):
  for i in word:
    if i == letter:
      return True
  return False
letter_check("strawberry", "a")
letter_check("strawberry", "o")

# ===========

def contains(big_string,little_string):
  if little_string in big_string:
    return True
  return False
def common_letters(string_one,string_two):
  new_string=[]
  for letter in string_one:
    if (letter in string_two) and not (letter in new_string):
      new_string.append(letter)
  return new_string

# ===========

def username_generator(first_name,last_name):
  username=""
  if len(first_name) < 3 or len(last_name) < 4:
    return first_name+last_name
  else:
    username=first_name[:3]+last_name[:4]
    return username
def password_generator(username):
  password=""
  for i in range(0, len(username)):
    password+=username[i-1]
  return password

# ===========

authors = "Audre Lorde,Gabriela Mistral,Jean Toomer,An Qi,Walt Whitman,Shel Silverstein,Carmen Boullosa,Kamala Suraiyya,Langston Hughes,Adrienne Rich,Nikki Giovanni"
author_names=authors.split(',')
author_last_names=[]
for name in author_names:
  author_last_names.append(name.split()[-1])
print(author_last_names)

# ===========

smooth_chorus = \
"""And if you said, "This life ain't good enough."
I would give my world to lift you up
I could change my life to better suit your mood
Because you're so smooth"""
chorus_lines = smooth_chorus.split('\n')
print(chorus_lines)

# ===========

reapers_line_one_words = ["Black", "reapers", "with", "the", "sound", "of", "steel", "on", "stones"]
reapers_line_one=' '.join(reapers_line_one_words)

# ===========

winter_trees_full='\n'.join(winter_trees_lines)
print(winter_trees_full)

# ===========

love_maybe_lines = ['Always    ', '     in the middle of our bloodiest battles  ', 'you lay down your arms', '           like flowering mines    ','\n' ,'   to conquer me home.    ']
love_maybe_lines_stripped=[]
for line in love_maybe_lines:
  love_maybe_lines_stripped.append(line.strip())
love_maybe_full='\n'.join(love_maybe_lines_stripped)
print(love_maybe_full)

# ===========

toomer_bio_fixed=toomer_bio.replace('Scon','Scone')

# ===========

god_wills_it_line_one = "The very earth will disown you"
disown_placement=god_wills_it_line_one.find('disown')
print(disown_placement)

# ===========

def poem_title_card(title,poet):
  poem_desc="The poem \"{}\" is written by {}.".format(title,poet)
  return poem_desc

# ===========

def poem_description(publishing_date, author, title, original_work):
  poem_desc = "The poem {title} by {author} was originally published in {original_work} in {publishing_date}.".format(publishing_date=publishing_date,author=author,title=title,original_work=original_work)
  return poem_desc

# ===========

highlighted_poems = "Afterimages:Audre Lorde:1997,  The Shadow:William Carlos Williams:1915, Ecstasy:Gabriela Mistral:1925,   Georgia Dusk:Jean Toomer:1923,   Parting Before Daybreak:An Qi:2014, The Untold Want:Walt Whitman:1871, Mr. Grumpledump's Song:Shel Silverstein:2004, Angel Sound Mexico City:Carmen Boullosa:2013, In Love:Kamala Suraiyya:1965, Dream Variations:Langston Hughes:1994, Dreamwood:Adrienne Rich:1987"
print(highlighted_poems)
highlighted_poems_list=highlighted_poems.split(',')
print(highlighted_poems_list)
highlighted_poems_stripped=[]
for poem in highlighted_poems_list:
  highlighted_poems_stripped.append(poem.strip())
print(highlighted_poems_stripped)
highlighted_poems_details=[]
for poem in highlighted_poems_stripped:
  highlighted_poems_details.append(poem.split(':'))
print(highlighted_poems_details)
titles=[]
poets=[]
dates=[]
for list in highlighted_poems_details:
  titles.append(list[0])
  poets.append(list[1])
  dates.append(list[2])
def poem_description(titles,poets,dates):
  poem_desc="The poem {titles} was published by {poets} in {dates}.".format(titles=titles,poets=poets,dates=dates)
poem_descriptions=poem_description(titles,poets,dates)
print(poem_descriptions)

# =========== Final

daily_sales = \
"""Edith Mcbride   ;,;$1.21   ;,;   white ;,; 
09/15/17   ,Herbert Tran   ;,;   $7.29;,; 
white&blue;,;   09/15/17 ,Paul Clarke ;,;$12.52 
;,;   white&blue ;,; 09/15/17 ,Lucille Caldwell   
;,;   $5.13   ;,; white   ;,; 09/15/17,
Eduardo George   ;,;$20.39;,; white&yellow 
;,;09/15/17   ,   Danny Mclaughlin;,;$30.82;,;   
purple ;,;09/15/17 ,Stacy Vargas;,; $1.85   ;,; 
purple&yellow ;,;09/15/17,   Shaun Brock;,; 
$17.98;,;purple&yellow ;,; 09/15/17 , 
Erick Harper ;,;$17.41;,; blue ;,; 09/15/17, 
Michelle Howell ;,;$28.59;,; blue;,;   09/15/17   , 
Carroll Boyd;,; $14.51;,;   purple&blue   ;,;   
09/15/17   , Teresa Carter   ;,; $19.64 ;,; 
white;,;09/15/17   ,   Jacob Kennedy ;,; $11.40   
;,; white&red   ;,; 09/15/17, Craig Chambers;,; 
$8.79 ;,; white&blue&red   ;,;09/15/17   , Peggy Bell;,; $8.65 ;,;blue   ;,; 09/15/17,   Kenneth Cunningham ;,;   $10.53;,;   green&blue   ;,; 
09/15/17   ,   Marvin Morgan;,;   $16.49;,; 
green&blue&red   ;,;   09/15/17 ,Marjorie Russell 
;,; $6.55 ;,;   green&blue&red;,;   09/15/17 ,
Israel Cummings;,;   $11.86   ;,;black;,;  
09/15/17,   June Doyle   ;,;   $22.29 ;,;  
black&yellow ;,;09/15/17 , Jaime Buchanan   ;,;   
$8.35;,;   white&black&yellow   ;,;   09/15/17,   
Rhonda Farmer;,;$2.91 ;,;   white&black&yellow   
;,;09/15/17, Darren Mckenzie ;,;$22.94;,;green 
;,;09/15/17,Rufus Malone;,;$4.70   ;,; green&yellow 
;,; 09/15/17   ,Hubert Miles;,;   $3.59   
;,;green&yellow&blue;,;   09/15/17   , Joseph Bridges  ;,;$5.66   ;,; green&yellow&purple&blue 
;,;   09/15/17 , Sergio Murphy   ;,;$17.51   ;,;   
black   ;,;   09/15/17 , Audrey Ferguson ;,; 
$5.54;,;black&blue   ;,;09/15/17 ,Edna Williams ;,; 
$17.13;,; black&blue;,;   09/15/17,   Randy Fleming;,;   $21.13 ;,;black ;,;09/15/17 ,Elisa Hart;,; $0.35   ;,; black&purple;,;   09/15/17   ,
Ernesto Hunt ;,; $13.91   ;,;   black&purple ;,;   
09/15/17,   Shannon Chavez   ;,;$19.26   ;,; 
yellow;,; 09/15/17   , Sammy Cain;,; $5.45;,;   
yellow&red ;,;09/15/17 ,   Steven Reeves ;,;$5.50   
;,;   yellow;,;   09/15/17, Ruben Jones   ;,; 
$14.56 ;,;   yellow&blue;,;09/15/17 , Essie Hansen;,;   $7.33   ;,;   yellow&blue&red
;,; 09/15/17   ,   Rene Hardy   ;,; $20.22   ;,; 
black ;,;   09/15/17 ,   Lucy Snyder   ;,; $8.67   
;,;black&red  ;,; 09/15/17 ,Dallas Obrien ;,;   
$8.31;,;   black&red ;,;   09/15/17,   Stacey Payne 
;,;   $15.70   ;,;   white&black&red ;,;09/15/17   
,   Tanya Cox   ;,;   $6.74   ;,;yellow   ;,; 
09/15/17 , Melody Moran ;,;   $30.84   
;,;yellow&black;,;   09/15/17 , Louise Becker   ;,; 
$12.31 ;,; green&yellow&black;,;   09/15/17 ,
Ryan Webster;,;$2.94 ;,; yellow ;,; 09/15/17 
,Justin Blake ;,; $22.46   ;,;white&yellow ;,;   
09/15/17,   Beverly Baldwin ;,;   $6.60;,;   
white&yellow&black ;,;09/15/17   ,   Dale Brady   
;,;   $6.27 ;,; yellow   ;,;09/15/17 ,Guadalupe Potter ;,;$21.12   ;,; yellow;,; 09/15/17   , 
Desiree Butler ;,;$2.10   ;,;white;,; 09/15/17  
,Sonja Barnett ;,; $14.22 ;,;white&black;,;   
09/15/17, Angelica Garza;,;$11.60;,;white&black   
;,;   09/15/17   ,   Jamie Welch   ;,; $25.27   ;,; 
white&black&red ;,;09/15/17   ,   Rex Hudson   
;,;$8.26;,;   purple;,; 09/15/17 ,   Nadine Gibbs 
;,;   $30.80 ;,;   purple&yellow   ;,; 09/15/17   , 
Hannah Pratt;,;   $22.61   ;,;   purple&yellow   
;,;09/15/17,Gayle Richards;,;$22.19 ;,; 
green&purple&yellow ;,;09/15/17   ,Stanley Holland 
;,; $7.47   ;,; red ;,; 09/15/17 , Anna Dean;,;$5.49 ;,; yellow&red ;,;   09/15/17   ,
Terrance Saunders ;,;   $23.70  ;,;green&yellow&red 
;,; 09/15/17 ,   Brandi Zimmerman ;,; $26.66 ;,; 
red   ;,;09/15/17 ,Guadalupe Freeman ;,; $25.95;,; 
green&red ;,;   09/15/17   ,Irving Patterson 
;,;$19.55 ;,; green&white&red ;,;   09/15/17 ,Karl Ross;,;   $15.68;,;   white ;,;   09/15/17 , Brandy Cortez ;,;$23.57;,;   white&red   ;,;09/15/17, 
Mamie Riley   ;,;$29.32;,; purple;,;09/15/17 ,Mike Thornton   ;,; $26.44 ;,;   purple   ;,; 09/15/17, 
Jamie Vaughn   ;,; $17.24;,;green ;,; 09/15/17   , 
Noah Day ;,;   $8.49   ;,;green   ;,;09/15/17   
,Josephine Keller ;,;$13.10 ;,;green;,;   09/15/17 ,   Tracey Wolfe;,;$20.39 ;,; red   ;,; 09/15/17 ,
Ignacio Parks;,;$14.70   ;,; white&red ;,;09/15/17 
, Beatrice Newman ;,;$22.45   ;,;white&purple&red 
;,;   09/15/17, Andre Norris   ;,;   $28.46   ;,;   
red;,;   09/15/17 ,   Albert Lewis ;,; $23.89;,;   
black&red;,; 09/15/17,   Javier Bailey   ;,;   
$24.49   ;,; black&red ;,; 09/15/17   , Everett Lyons ;,;$1.81;,;   black&red ;,; 09/15/17 ,   
Abraham Maxwell;,; $6.81   ;,;green;,;   09/15/17   
,   Traci Craig ;,;$0.65;,; green&yellow;,; 
09/15/17 , Jeffrey Jenkins   ;,;$26.45;,; 
green&yellow&blue   ;,;   09/15/17,   Merle Wilson 
;,;   $7.69 ;,; purple;,; 09/15/17,Janis Franklin   
;,;$8.74   ;,; purple&black   ;,;09/15/17 ,  
Leonard Guerrero ;,;   $1.86   ;,;yellow  
;,;09/15/17,Lana Sanchez;,;$14.75   ;,; yellow;,;   
09/15/17   ,Donna Ball ;,; $28.10  ;,; 
yellow&blue;,;   09/15/17   , Terrell Barber   ;,; 
$9.91   ;,; green ;,;09/15/17   ,Jody Flores;,; 
$16.34 ;,; green ;,;   09/15/17,   Daryl Herrera 
;,;$27.57;,; white;,;   09/15/17   , Miguel Mcguire;,;$5.25;,; white&blue   ;,;   09/15/17 ,   
Rogelio Gonzalez;,; $9.51;,;   white&black&blue   
;,;   09/15/17   ,   Lora Hammond ;,;$20.56 ;,; 
green;,;   09/15/17,Owen Ward;,; $21.64   ;,;   
green&yellow;,;09/15/17,Malcolm Morales ;,;   
$24.99   ;,;   green&yellow&black;,; 09/15/17 ,   
Eric Mcdaniel ;,;$29.70;,; green ;,; 09/15/17 
,Madeline Estrada;,;   $15.52;,;green;,;   09/15/17 
, Leticia Manning;,;$15.70 ;,; green&purple;,; 
09/15/17 ,   Mario Wallace ;,; $12.36 ;,;green ;,; 
09/15/17,Lewis Glover;,;   $13.66   ;,;   
green&white;,;09/15/17,   Gail Phelps   ;,;$30.52   
;,; green&white&blue   ;,; 09/15/17 , Myrtle Morris 
;,;   $22.66   ;,; green&white&blue;,;09/15/17"""

#------------------------------------------------
# Start coding below!
daily_sales_replaced=daily_sales.replace(";,;",":")
#print(daily_sales_replaced)
daily_transactions=daily_sales_replaced.split(',')
#print(daily_transactions)
daily_transactions_split=[]
for transaction in daily_transactions:
  daily_transactions_split.append(transaction.split(":"))
#print(daily_transactions_split)
transactions_clean=[]
for transaction in daily_transactions_split:
  transaction_clean=[]
  for data_point in transaction:
    transaction_clean.append(data_point.replace("\n","").strip(" "))
    transactions_clean.append(transaction_clean)
#print(transactions_clean)
customers=[]
sales=[]
thread_sold=[]
for data_point in transactions_clean:
  customers.append(data_point[0])
  sales.append(data_point[1])
  thread_sold.append(data_point[2])
#print(customers)
#print(sales)
#print(thread_sold)
total_sales=0
for sale in sales:
  total_sales+=float(sale.strip("$"))
#print(total_sales)
#print(thread_sold)
thread_sold_split=[]
for thread in thread_sold:
  for color in thread.split("&"):
    thread_sold_split.append(color)
#print(thread_sold_split)
def color_count(color):
  count=0
  for thread in thread_sold_split:
    if color==thread:
      count+=1
  return count
#print(color_count('white'))
colors=['red','yellow','green','white','black','blue','purple']
for color in colors:
  print("Thread Shed sold {0} threads of {1} thread today.".format(color_count(color),color))

# ===========

  letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
# Write your unique_english_letters function here:
def unique_english_letters(word):
  count=0
  for letter in letters:
    if letter in word:
      count+=1
  return count
# Uncomment these function calls to test your function:
print(unique_english_letters("mississippi"))
# should print 4
print(unique_english_letters("Apple"))
# should print 4

# ===========

# Write your count_char_x function here:
def count_char_x(word,x):
  count=0
  for letter in word:
    if x in letter:
      count+=1
  return count
# Uncomment these function calls to test your tip function:
print(count_char_x("mississippi", "s"))
# should print 4
print(count_char_x("mississippi", "m"))
# should print 1

# ===========

# Write your count_multi_char_x function here:
def count_multi_char_x(word,x):
  splits=word.split(x)
  return(len(splits)-1)
# Uncomment these function calls to test your function:
print(count_multi_char_x("mississippi", "iss"))
# should print 2
print(count_multi_char_x("apple", "pp"))
# should print 1

# ===========

# Write your substring_between_letters function here:
def substring_between_letters(word,start,end):
  start_ind=word.find(start)
  end_ind=word.find(end)
  if start_ind > -1 and end_ind > -1:
    return(word[start_ind+1:end_ind])
  return word
# Uncomment these function calls to test your function:
print(substring_between_letters("apple", "p", "e"))
# should print "pl"
print(substring_between_letters("apple", "p", "c"))
# should print "apple"

# ===========

# Write your x_length_words function here:
def x_length_words(sentence,x):
  lst=sentence.split()
  for word in lst:
    if len(word)<x:
      return False
    return True
# Uncomment these function calls to test your tip function:
print(x_length_words("i like apples", 2))
# should print False
print(x_length_words("he likes apples", 2))
# should print True

# ===========

# Write your check_for_name function here:
def check_for_name(sentence,name):
  if name.lower() in sentence.lower():
    return True
  if name.upper() in sentence.upper():
    return True
  else:
    return False
# Uncomment these function calls to test your  function:
print(check_for_name("My name is Jamie", "Jamie"))
# should print True
print(check_for_name("My name is jamie", "Jamie"))
# should print True
print(check_for_name("My name is Samantha", "Jamie"))
# should print False

# ===========

# Write your every_other_letter function here:
def every_other_letter(word):
  every_other=""
  for letter in range(0,len(word),2):
    every_other+=word[letter]
  return every_other
# Uncomment these function calls to test your function:
print(every_other_letter("Codecademy"))
# should print Cdcdm
print(every_other_letter("Hello world!"))
# should print Hlowrd
print(every_other_letter(""))
# should print

# ===========

# Write your reverse_string function here:
def reverse_string(word):
  new_word=""
  for i in range(len(word)-1,-1,-1):
    new_word+=word[i]
  return new_word
# Uncomment these function calls to test your  function:
print(reverse_string("Codecademy"))
# should print ymedacedoC
print(reverse_string("Hello world!"))
# should print !dlrow olleH
print(reverse_string(""))
# should print

# ===========

# Write your make_spoonerism function here:
def make_spoonerism(word1,word2):
  new_word1=word2[0]+word1[1:]
  new_word2=word1[0]+word2[1:]
  return new_word1+" "+new_word2
# Uncomment these function calls to test your function:
print(make_spoonerism("Codecademy", "Learn"))
# should print Lodecademy Cearn
print(make_spoonerism("Hello", "world!"))
# should print wello Horld!
print(make_spoonerism("a", "b"))
# should print b a

# ===========

# Write your add_exclamation function here:
def add_exclamation(word):
  new_word=word
  if len(word)<20:
    while len(new_word)<20:
      new_word+="!"
    return new_word
  else:
    return word
# Uncomment these function calls to test your function:
print(add_exclamation("Codecademy"))
# should print Codecademy!!!!!!!!!!
print(add_exclamation("Codecademy is the best place to learn"))
# should print Codecademy is the best place to learn

# ===========

