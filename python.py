print("Hello World!")

# float
quotient  = 7/2   # the value of quotient is 3
quotient1 = 7./2  # the value of quotient1 is 3.5
quotient2 = 7/2.  # the value of quotient2 is 3.5
quotient3 = 7./2. # the value of quotient3 is 3.5

# Multi-line Strings
address_string = """136 Whowho Rd
Apt 7
Whosville, WZ 44494"""


age_is_12 = False
name_is_maria = True

# cast
age = 13
print "I am " + str(age) + " years old!"

string_num = "7.5"
int(string_num)
float(string_num)


# string
len(parrot)
"Ryan".lower() # => downcase
"Ryan".upper() # => upcase
print "Let's not go to %s. 'Tis a silly %s." % (string_1, string_2)

name = raw_input("What is your name? ")
quest = raw_input("What is your quest? ")
color = raw_input("What is your favorite color? ")
print "Ah, so your name is %s, your quest is %s, " \
"and your favorite color is %s." % (name, quest, color)

# datetime
from datetime import datetime

now = datetime.now()
print now.year
print now.month
print now.day
print '%02d-%02d-%04d' % (now.month, now.day, now.year)
print '%02d:%02d:%02d' % (now.hour, now.minute, now.second)
