#!/usr/bin/perl

#Murtaza Haque, mh1272, 207-5, your's truly, yada yada shabang kaboom
#Perl is cool! I made this Piglatin converter in Perl for a CSCE 2110 assignment
#Unfortunately I can't take in Piglatin and convert it to English, but hey maybe one day I might add that feature (almost never lol)


use Switch; #Funny Perl module (I don't know how this worked because I installed it in many different ways BEFORE VSCode updated and checked it so I can't verify the correct method)

print "\n\nThis program was not sponsored by but would I hope would be sponsored by the RAO (https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html)\n\n";
$break = 0; #A surprise variable that will help us later ;)


#Subroutine (Function in PERL) for the actual meat and potatoes of the code and stuff
sub Prompt {
    print "Enter in a sentence to convert to Piglatin, or type 'q' to stop: \n";


    $str = <>;
    chomp($str); #The developers of this language are legends.

    print "\n";

    #If they say quit, let em quit
    if($str eq "q") {
        $break = 1;
        return;
    }

    @store = split(" ", $str); #We'll have to chop up this intake

    #Here are the rules:

    #If word starts with consonant, move it to back and add "ay" to word
    #If word starts with 2 consonants, move them both back and add "ay" to word
    #If word starts with a vowel, simply append "yay" to the back of the word
    #Keep in mind case for capitalization preservation
    #Keep in mind case for punctuation preservation


    #Now for each object in @store (an arrray)...
    for(@store) {

        #If these are a lot of vars, don't judge, I just started this language lol
        #You cannot use booleans :(
        $consCt = 0;
        $iter = 0;
        $vowelCheck = "";
        $puncAddB = "";
        $puncAddF = "";
        $isCapital = 0;

        #In built regex goes so hard vvv
        while($vowelCheck !~ /[aeiouAEIOU]/ && $iter < length($_)) {
            $vowelCheck = substr($_, $iter, $iter+1);
            last if $vowelCheck =~ /[aeiouAEIOU]/;
            $consCt++;
            $iter++;
        }

        #Check for punctuation:
        if(substr($_, length($_)-1, length($_)) =~ /[^\w\s]+/) {
            $puncAddB = substr($_, length($_)-1, length($_));
            $_ = substr($_, 0, length($_)-1);       
        }
        if(substr($_, 0, 1) =~ /[^\w\s]+/) {
            $puncAddF = substr($_, 0, 1);
            $_ = substr($_, 1, length($_));
        }
        
        #Check for capitalization:
        if($_ =~ /[A-Z]/) {
            $isCapital = 1;
        }

        #The funny syntax from the funny use import
        switch($consCt) {
            case 0 { #vowel leading word
                $_ = $_."yay";
                last;
            }
            case 1 { #consonant leading word 
                $_ = substr($_, 1, length($_)).substr($_, 0,1)."ay";
                last;
            }
            case 2 { #words like child, photo, etc
                $_ = substr($_, 2, length($_)).substr($_, 0,1).substr($_, 1,2)."ay";
                last;
            }
            else {
                $_ = $_."way";
                last;
            }
        }

        #Recapitalize the word:
        if($isCapital == 1) {
            $_ = lc($_);
            $_ = ucfirst($_);
        } 

        #Reintroduce punctuation (if any):
        $_ = $puncAddF.$_.$puncAddB;

    }

    #And output:
    print "Piglatin -->\t\" ";
    foreach (@store) {
        print $_." ";
    }
    print "\"\n\n";
}

#Once again, no booleans, sue me (and the devs, just for this one)
$one = 1;

while($one == 1) {
    Prompt();
    if($break == 1) {last;} #This was an important line (once again, noooo boooleans :(  )
}

#And that's the game! T'was real fun learning this language. This "German University CS Course" structure is really fun!