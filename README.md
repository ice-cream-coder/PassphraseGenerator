# PassphrasesGenerator

This is an executable swift command line tool for generating reasonably secure memorable passphrases.

Each time the executable runs is will generate a new pass-phrase with the format:
Adjective Noun Verb Noun Adverb

This format makes the pass phrase easier to remember, but limitting parts of speach does  make the password weaker if the hacker know your format. Using the tool to get ideas, and making custom edits that include punctuation may make the pass phrase stronger and easier to remember.

The definitions of the words in the passphrase are also printed out to help with memorization.
The strength of the passphrase is printed out. It is calculated assuming the the hacker knows the method used to generate the passphrase.
The strenght of a randomly generated 12 character password is printed out for comparison.

For other sentance structures, feel free to edit the code before building.
