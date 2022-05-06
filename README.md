# Bitly Coding Challenge

This challenge was completed using Ruby version 2.7.2. Testing was done using RSpec.


## Setup

Installation for this requires the use of Homebrew which instructions can be found here: https://mac.install.guide/homebrew/3.html

Once you have Homebrew installed, you must install ```rbenv```

In your terminal:

1. Run ```brew update```. This may take a few minutes.
2. Run ```brew install rbenv```. This may take a few minutes.
3. Run ```rbenv init```. The output should look something like:

```
# Load rbenv automatically by appending
# the following to ~/.zshrc:

eval "$(rbenv init - zsh)"
```

4. With a text editor, you will need to open the ```zshrc file```. For example, if you use Visual Studio Code, you can run ```code ~/.zshrc``` to open it. Inside of this file, type or copy-and-paste in ```eval "$(rbenv init - zsh)"```
5. Close the Terminal using ```command + q```.
6. Reopen Terminal and run ```rbenv versions```. As long as you do not get an error message, ```rbenv``` has been installed correctly.
7. In the Terminal, run ```rbenv install 2.7.2```.
8. Run ```rbenv versions```. You should now see 2.7.2 listed
9. Run ```rbenv local 2.7.2```
10. Run ```ruby -v```. The output should look something like:
```
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [arm64-darwin20]
```
If the output does not include ```ruby 2.7.2```, type ```command + q``` to exit the Terminal and try again. If you do not see ```ruby 2.7.2```, check that you correctly followed the step above to edit your .zshrc file.
11. Run ```rbenv global 2.7.2``` then ```rbenv rehash```. No output is expected from this command.


## Running the program
1. Navigate to the directory ```$ cd bitly_challenge```
2. Run ```gem install json```. This is important to allow the use of JSON files for this program.
4. Run ```ruby runner.rb```. Once this command is ran, an output is shown in the Terminal which is the solution to this challenge.


## Design Choices
Initially, I made the decision to import the encodes.csv file and convert them to Ruby objects and left the decodes.json file as is. While I was working on the challenge, I realized that it was difficult to test for the plain JSON file so I also converted the JSON file to Ruby objects. This way it made testing much easier.

This was created with it being dynamic in mind. So in the ```runner.rb``` file, if the file paths for the csv and json files with a similar structure as ```decodes.json``` and ```encodes.csv``` were replaced, it should also work with those files.

## Testing
Testing was done using RSpec. To run tests, go to Terminal, navigate to this directory and run ```rspec```.

I created a json file called 'dummy.json' for testing purposes. This is based on the format of "decodes.json". Difference being is that it contains much less data, making it much easier to test.
