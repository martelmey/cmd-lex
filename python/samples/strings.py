def account_generator(first_name,last_name):
  temp_password=first_name[:3]+last_name[:3]
  return temp_password

length = len(favorite_fruit)
last_chars = favorite_fruit[length-4:]
print(last_chars)

first_name = "Reiko"
last_name = "Matsuki"
def password_generator(first_name,last_name):
  fn_last_3=first_name[len(first_name)-3:]
  ln_last_3=last_name[len(last_name)-3:]
  return fn_last_3+ln_last_3
temp_password=password_generator(first_name,last_name)
print(temp_password)

company_motto = "Copeland's Corporate Company helps you capably cope with the constant cacophony of daily life"
second_to_last=company_motto[-2:-1]
print(second_to_last)
final_word=company_motto[-4:]
print(final_word)

first_name = "Bob"
last_name = "Daily"
fixed_first_name="R"+first_name[1:]
print(fixed_first_name)

def get_length(string):
  count=0
  for letter in string:
    count+=1
  return count

def letter_check(word,letter):
  for i in word:
    if i == letter:
      return True
  return False
letter_check("strawberry", "a")
letter_check("strawberry", "o")

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

authors = "Audre Lorde,Gabriela Mistral,Jean Toomer,An Qi,Walt Whitman,Shel Silverstein,Carmen Boullosa,Kamala Suraiyya,Langston Hughes,Adrienne Rich,Nikki Giovanni"
author_names=authors.split(',')
author_last_names=[]
for name in author_names:
  author_last_names.append(name.split()[-1])
print(author_last_names)

smooth_chorus = \
"""And if you said, "This life ain't good enough."
I would give my world to lift you up
I could change my life to better suit your mood
Because you're so smooth"""
chorus_lines = smooth_chorus.split('\n')
print(chorus_lines)

reapers_line_one_words = ["Black", "reapers", "with", "the", "sound", "of", "steel", "on", "stones"]
reapers_line_one=' '.join(reapers_line_one_words)

winter_trees_full='\n'.join(winter_trees_lines)
print(winter_trees_full)

love_maybe_lines = ['Always    ', '     in the middle of our bloodiest battles  ', 'you lay down your arms', '           like flowering mines    ','\n' ,'   to conquer me home.    ']
love_maybe_lines_stripped=[]
for line in love_maybe_lines:
  love_maybe_lines_stripped.append(line.strip())
love_maybe_full='\n'.join(love_maybe_lines_stripped)
print(love_maybe_full)

toomer_bio_fixed=toomer_bio.replace('Scon','Scone')

god_wills_it_line_one = "The very earth will disown you"
disown_placement=god_wills_it_line_one.find('disown')
print(disown_placement)

def poem_title_card(title,poet):
  poem_desc="The poem \"{}\" is written by {}.".format(title,poet)
  return poem_desc

def poem_description(publishing_date, author, title, original_work):
  poem_desc = "The poem {title} by {author} was originally published in {original_work} in {publishing_date}.".format(publishing_date=publishing_date,author=author,title=title,original_work=original_work)
  return poem_desc

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