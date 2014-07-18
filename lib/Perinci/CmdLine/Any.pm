package Perinci::CmdLine::Any;

our $DATE = '2014-07-18'; # DATE
our $VERSION = '0.04'; # VERSION

use 5.010001;
use strict;
use warnings;

sub new {
    my $class = shift;

    my $pericmd_ver = 1.17;

    if ($ENV{PERINCI_CMDLINE_ANY}) {
        my $mod = $ENV{PERINCI_CMDLINE_ANY};
        my $modpm = $mod; $modpm =~ s!::!/!g; $modpm .= ".pm";
        require $modpm;
        if ($mod eq 'Perinci::CmdLine') {
            Perinci::CmdLine->VERSION($pericmd_ver);
        }
        $mod->new(@_);
    } else {
        eval {
            require Perinci::CmdLine;
            Perinci::CmdLine->VERSION($pericmd_ver);
        };
        if ($@) {
            require Perinci::CmdLine::Lite;
            Perinci::CmdLine::Lite->new(@_);
        } else {
            Perinci::CmdLine->new(@_);
        }
    }
}

1;
# ABSTRACT: Use Perinci::CmdLine, fallback on Perinci::CmdLine::Lite

__END__

=pod

=encoding UTF-8

=head1 NAME

Perinci::CmdLine::Any - Use Perinci::CmdLine, fallback on Perinci::CmdLine::Lite

=head1 VERSION

This document describes version 0.04 of Perinci::CmdLine::Any (from Perl distribution Perinci-CmdLine-Any), released on 2014-07-18.

=head1 SYNOPSIS

 In your command-line script:

 #!perl
 use Perinci::CmdLine::Any;
 Perinci::CmdLine::Any->new(url => '/Package/func')->run;

=head1 DESCRIPTION

This module lets you use L<Perinci::CmdLine> if it's available, or
L<Perinci::CmdLine::Lite> as the fallback. The goal is to reduce dependencies
(Perinci::CmdLine::Any only depends on the lightweight Perinci::CmdLine::Lite)
but use the richer Perinci::CmdLine if it's available.

Note that Perinci::CmdLine::Lite provides only a subset of the
functionalities/features of Perinci::CmdLine.

If you want to force using a specific class, you can set the
C<PERINCI_CMDLINE_ANY> environment variable, e.g. the command below will choose
Perinci::CmdLine::Lite even though Perinci::CmdLine is available:

 % PERINCI_CMDLINE_ANY=Perinci::CmdLine::Lite yourapp.pl

=for Pod::Coverage ^(new)$

=head1 ENVIRONMENT

=head2 PERINCI_CMDLINE_ANY => str

=head1 SEE ALSO

L<Perinci::CmdLine>

L<Perinci::CmdLine::Lite>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Perinci-CmdLine-Any>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Perinci-CmdLine-Any>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Perinci-CmdLine-Any>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
