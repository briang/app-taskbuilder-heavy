# - * - mode: perl - * -

use 5.8.3;

use strict;
use warnings;
use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
    ABSTRACT  => '[% abstract %]',
    AUTHOR    => '[% author %] [% email %]',
   #DISTNAME  => '[% distname %]', # defaults to NAME =~ s|::|-|g
    LICENSE   => '[% license %]',
    NAME      => '[% name %]',
    VERSION   => '[% version %]',
    PREREQ_PM => {
        #[% modules %]
        Moose => 1,
    },
    test => {
        TESTS => 't/*.t'
    }
);

my $foo = prompt("Got foo?");
print "$foo\n" for 1..3;

WriteMakefile(%WriteMakefileArgs);
