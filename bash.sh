#!/usr/bin/env bash
sudo lsof -i tcp:5432
sudo kill -9 60654
ps aux | grep postgres

brew services start rabbitmq
brew services restart rabbitmq
brew services stop rabbitmq

pwd #current location
cd ..                   #step back
cd ../feb               #step back and go to folder
touch filename.txt      #create file
ls                      #show all files
   -a                   #lists all contents, including hidden files and directories
   -l                   #lists all contents of a directory in long format
   -t                   #order files and directories by the time they were last modified.
   -alt                 #as -t and show hidden files

: drwxr-xr-x   4   ccuser ccuser 4096 Jul  8  2015 action.txt
acces rights links  user  group  size   datetime    filename


### cp ###
cp frida.txt lincoln.txt                          #copy content of frida.txt to lincoln.txt
cp biopic/cleopatra.txt historical/               #copy cleopatra.txt to historical dir
cp biopic/file1.txt biopic/file2.txt historical/  #copy two files to dir
cp * satire/                                      #copy all files to folder
cp m*.txt scifi/                                  #copy all files start with 'm'


### mv ###
mv superman.txt superhero/                        #move file to other dir
mv wonderwoman.txt batman.txt superhero/          #multiple move
mv batman.txt spiderman.txt                       #cut and past with rename

### rm ###
rm waterboy.txt                                   #remove file
rm -r comedy                                      #remove recursive (rm all files in dir and dir)


###I/O###
echo "Hello"                                      #print 'Hello'
echo "Hello" > hello.txt                          #print to file
cat hello.txt                                     #show file content
cat oceans.txt > continents.txt                   #move file content to other file with overwrite
cat glaciers.txt >> rivers.txt                    #move file content to other file without appends 
cat < hello.txt                                   #same as 'cat hello.txt'
cat volcanoes.txt | wc                            # '|' is a 'pipe' shwos number of lines, words, and characters
cat volcanoes.txt | wc | cat > islands.txt        #write to file number of lines, words, and characters

sort lakes.txt                                    #alpabetically sort lines of file
uniq deserts.txt   
sort deserts.txt | uniq   
sort deserts.txt | uniq > uniq-deserts.txt   

#grep: searches for a text pattern and outputs it.
grep Mount mountains.txt                          #shows lines with specific word
grep -i Mount mountains.txt                       #shows lines with specific word case insensitive
grep -R Arctic /home/ccuser/workspace/geography   #shows files that contain specific word inside
grep -Rl Arctic /home/ccuser/workspace/geography  #same as -R but doesn't show Line from file

#sed : searches for a text pattern, modifies it, and outputs it.
sed 's/snow/rain/' forests.txt                    #replace rain word to snow one time
sed 's/snow/rain/g' forests.txt                   #replace rain words to snow many times

~/.bash_profile              #is where environment settings are stored
source ~/.bash_profile       #run comands that write in file
alias pd="pwd"               #create alias for command
history                      #shows input history

export USER="Jane Doe"       #create variable 
echo $USER                   #call variable
export PS1=">> "             #set style of the command prompt

echo $HOME                   #shows HOME dir     
echo $PATH                   #shows PAT dirs     
env                          #shows all env vars






## examples

# parsing url and download html
links=(
http://localhost:3000/contracts/11
http://localhost:3000/contracts/63
)

for item in ${links[*]}
do
  echo "${item}"
  url="${item}"
  curl  -o "${url##*/}.html"  "${item}"
  echo ""
done
###

## rm by pattern matching
rm -rf -- \
  *" "*[0-9]*/ \   # this one gets directories with spaces before numbers...
  *[0-9]*" "*/
###
