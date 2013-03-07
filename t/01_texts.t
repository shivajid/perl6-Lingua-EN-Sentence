use v6;
use Test;
use Lingua::EN::Sentence;

my @tests = dir 't/data', test => /'.txt' $$/;

say @tests.elems;
plan @tests.elems;


for @tests -> $test {
 $test ~~ /(.+) '.txt' $$/;
 my $name = $0;
 my $text = slurp "t/data/$test";
 my @sentences = slurp("t/data/$name.sents").split("\n-----\n");
 my @new_sentences = $text.sentences;
 my Str $diff="\n";
 my Str $expected_diff="\n";
 for @sentences Z @new_sentences -> $s1, $s2 {
     if ($s1 ne $s2) {
       $diff ~= "Expected: $s1\nGot: $s2\n"; 
     }
 }
 is($expected_diff,$diff);
}

# my $fh = open 't/data/new.sents', :w;
# $fh.say( $text.sentences.join("\n-----\n") );
# $fh.close();