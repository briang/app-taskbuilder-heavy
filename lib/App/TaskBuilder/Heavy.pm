package App::TaskBuilder::Heavy;

use 5.8.3;

use strict;
use warnings;
use Carp qw(croak);

use Data::Dump; # XXX

=head1 NAME

App::TaskBuilder::Heavy - create Task distributions;

=cut

our $VERSION = '0.01';

=head1 VERSION

0.01 - 2011-08-23

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 ATTRIBUTES

ATHC has the following attributes. Each can be passed (as a key=>value
pair) to new(). Most are mandatory, but some have default or
calculated values.

Each attribute has a accessor associated with it, using the perl norm of

  my $author = $cfg->author;

being the getter, and

  my $new_author = $cfg->author('Jane Doe');

being the setter. Note that the setter returns the new name;

=head2 XXXX

=cut

my $attributes = {
};

eval <<EOC for keys %$attributes;
sub $_ {
    \$_[0]->{$_} = \$_[1] if \@_ > 1;
    return \$_[0]->{$_};
}
EOC

=head1 CONSTRUCTOR

As noted above, any of the class's attributes may be passed to new()
as key=>value pairs. Some are mandatory, some have defaults and some
are calculated from other attributes.

new() will merge default values with those provided with the call.
Any missing attributes (or set to undef) that are required will throw
an exception.

See L<ATTRIBUTES> for more details.

=cut

sub new {
    my ($class, %args) = @_;
    my $self = bless {%$attributes}, $class;

    my @errors;

    # replace default args with those provided

    for (keys %args) {
        push @errors, "unknown attribute '$_'"
          unless exists $attributes->{$_};
        $self->$_( $args{$_} );
    }

    # check all attributes are initialised

    for (keys %$attributes) {
        push @errors, "attribute '$_' must be initialised"
          unless defined $self->$_;
    }

    if (@errors) {
        croak "The following errors were encountered in ", __PACKAGE__, "->new\n",
          join "\n", map "    $_", @errors;
    }

    return $self;
}

=head1 METHODS

XXX

=cut

=head1 AUTHOR

brian greenfield, briang@cpan.org

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by brian greenfield.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

1;
