package App::TaskBuilder::Heavy::Config;

use strict;
use warnings;
use Carp qw(croak);

=head1 NAME

App::TaskBuilder::Heavy::Config - pico-weight configuration library

=cut

our $VERSION = '0.01';

=head1 VERSION

0.01 - 2011-08-22

=head1 SYNOPSIS

  my $cfg = App::TaskBuilder::Heavy::Config->new(
    abstract => 'Install a collection of Foo::Bar modules',
    author   => 'Joe Doe',
    distname => 'Task-Foo-Bar',
    email    => 'joe@example.com',
    license  => 'perl',
    name     => 'Task::Foo::Bar',
    version  => '0.01',
    modules  => {
      Foo::Bar => '1.0',
      Bar::Foo => '0.01',
      Foo::Foo => '2.1',
      # etc
    }
  );

=head1 DESCRIPTION

App::TaskBuilder::Heavy::Config is a very light-weight configuration
library for use with App::TaskBuilder::Heavy.

=head1 ATTRIBUTES

ATHC has the following attributes. Each can be passed (as a key=>value
pair) to new(). Most are mandatory, but some have default or
calculated values.

Each attribute has a accessor associated with it, using the perl norm of

  my $author = $cfg->author;

being the getter, and

  my $new_author = $cfg->author('Jane Doe');

being the setter. Note that the setter returns the new name;

=head2 abstract

A brief summary of what this collection of distributions relates to.

This attribute is required.

=head2 author (required)

The name of the author, probably you!

This attribute is required.

=head2 distname

The name of the final uploadable tarball, without any suffix. The
likely distname of the Task::Foo::Bar collection would be
Task-Foo-Bar.

This attribute is calulated from name if none is provided.

=head2 email

The author's email address.

This attribute defaults to $ENV{EMAIL} and must be provided if the
environment variable is not set.

=head2 license

The license you would like applied to the distribution generated by
App::TaskBuilder::Heavy.

This attribute defaults to 'perl'.

=head2 name

The name of the collection. See distname above.

This attribute is required.

=head2 version

The version of the generated distribution.

This attribute is required.

=head2 modules

XXX

=cut

my $defaults = {
    abstract => undef,
    author   => undef,
    distname => undef, # defaults to NAME =~ s|::|-|g
    email    => undef,
    license  => 'perl',
    name     => undef,
    version  => undef,
    modules  => { },
};

eval <<EOC for keys %$defaults;
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
    my $self = bless {%$defaults}, $class;

    my @errors;

    # replace default args with those provided

    for (keys %args) {
        push @errors, "unknown attribute '$_'"
          unless exists $defaults->{$_};
        $self->$_( $args{$_} );
    }

    # automatically replace distname, email if not provided

    if ((my $n = $self->name) && ! $self->distname) {
        $n =~ s/::/-/g;
        $self->distname($n);
    }

    if (! defined $self->email && $ENV{EMAIL}) {
        $self->email($ENV{EMAIL});
    }

    # check all attributes are initialised

    for (keys %$defaults) {
        push @errors, "attribute '$_' must be initialised"
          unless defined $self->$_;
    }

    if (@errors) {
        croak "The following errors were encountered in App::TaskBuilder::Heavy::Config->new\n",
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
