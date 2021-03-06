package Perlito5::Grammar::Space;

use Perlito5::Grammar::Precedence;


my %space = (
    '#'     => sub {
                    my $m = Perlito5::Grammar::Space->to_eol($_[0], $_[1]);
                    $m->{to};
                },
    chr(9)  => sub { $_[1] },
    chr(10) => sub {
                    my $str = $_[0];
                    my $pos = $_[1];
                    $pos++ if substr($str, $pos, 1) eq chr(13);
                    my $m = Perlito5::Grammar::Space->start_of_line($_[0], $pos);
                    $m->{to};
                },
    chr(12) => sub { $_[1] },
    chr(13) => sub {
                    my $str = $_[0];
                    my $pos = $_[1];
                    $pos++ if substr($str, $pos, 1) eq chr(10);
                    my $m = Perlito5::Grammar::Space->start_of_line($_[0], $pos);
                    $m->{to};
                },
    chr(32) => sub { $_[1] },
);


sub term_space {
    my $str = $_[0];
    my $pos = $_[1];
    my $p = $pos;
    while (exists $space{substr($str, $p, 1)}) {
        $p = $space{substr($str, $p, 1)}->($str, $p+1)
    }
    return term_end( $str, $p )
        if substr($str, $p, 7) eq '__END__'
        || substr($str, $p, 8) eq '__DATA__';
    return { str => $str, from => $pos, to => $p, capture => [ 'space',   ' ' ] }
}

sub term_end {
    my $str = $_[0];
    my $p = $_[1];
    my $is_data = 0;
    if ( substr($str, $_[1], 7) eq '__END__' && $Perlito5::PKG_NAME eq 'main' ) {
        $p = $p + 7;
        $is_data = 1;
    }
    elsif ( substr($str, $_[1], 8) eq '__DATA__' ) {
        $p = $p + 8;
        $is_data = 1;
    }
    my $m = Perlito5::Grammar::Space->to_eol($str, $p);
    $p = $m->{to};
    if ( substr($str, $p, 1) eq chr(10) ) {
        $p++;
        $p++ if substr($str, $p, 1) eq chr(13);
    }
    elsif ( substr($str, $p, 1) eq chr(13) ) {
        $p++;
        $p++ if substr($str, $p, 1) eq chr(10);
    }
    if ($is_data) {
        $Perlito5::DATA_SECTION{ $Perlito5::PKG_NAME } = substr($_[0], $p);
    }
    return { str => $str, from => $_[1], to => length($_[0]), capture => [ 'space',   ' ' ] }
}

Perlito5::Grammar::Precedence::add_term( '#'        => \&term_space );
Perlito5::Grammar::Precedence::add_term( chr(9)     => \&term_space );
Perlito5::Grammar::Precedence::add_term( chr(10)    => \&term_space );
Perlito5::Grammar::Precedence::add_term( chr(12)    => \&term_space );
Perlito5::Grammar::Precedence::add_term( chr(13)    => \&term_space );
Perlito5::Grammar::Precedence::add_term( chr(32)    => \&term_space );
Perlito5::Grammar::Precedence::add_term( '__END__'  => \&term_end );
Perlito5::Grammar::Precedence::add_term( '__DATA__' => \&term_end );


token to_eol {
    [ <!before [ \c10 | \c13 ]> . ]*
};

token pod_pod_begin {
    |   [ \c10 | \c13 ] '=cut' <.to_eol>
    |   . <.to_eol> <.pod_pod_begin>
};

token pod_begin {
    |   [ \c10 | \c13 ] '=end' <.to_eol>
    |   . <.to_eol> <.pod_begin>
};

token start_of_line {
    <.Perlito5::Grammar::String.here_doc>
    [ '='  [
           |  'pod'    <.pod_pod_begin>
           |  'head'  <.pod_pod_begin>
           |  'begin'  <.pod_begin>
           |  'for'    <.pod_begin>  # TODO - fixme: recognize a single paragraph (double-newline)
           ]
    | '#'
        [ ' ' | \t ]*
        'line'
        [ ' ' | \t ]+
        <Perlito5::Grammar::Number.digits>
        [ ' ' | \t ]*

        # TODO: optional filename (specified with or without quotes)

        <.to_eol>
        {
            $Perlito5::LINE_NUMBER = 0 + Perlito5::Match::flat($MATCH->{'Perlito5::Grammar::Number.digits'});

            # TODO: filename
            # $Perlito5::FILE_NAME   = ...;
        }
    | ''
    ]
};

sub ws {
    my $self = shift;
    my $str = shift;
    my $pos = shift;
    my $p = $pos;
    while (exists $space{substr($str, $p, 1)}) {
        $p = $space{substr($str, $p, 1)}->($str, $p+1)
    }
    return term_end( $str, $p )
        if substr($str, $p, 7) eq '__END__'
        || substr($str, $p, 8) eq '__DATA__';
    if ($p == $pos) {
        return 0;
    }
    return { str => $str, from => $pos, to => $p }
}

sub opt_ws {
    my $self = shift;
    my $str = shift;
    my $pos = shift;
    my $p = $pos;
    while (exists $space{substr($str, $p, 1)}) {
        $p = $space{substr($str, $p, 1)}->($str, $p+1)
    }
    return term_end( $str, $p )
        if substr($str, $p, 7) eq '__END__'
        || substr($str, $p, 8) eq '__DATA__';
    return { str => $str, from => $pos, to => $p }
}

1;

=begin

=head1 NAME

Perlito5::Grammar::Space - Grammar for Perlito5 "whitespace"

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

Flavio Soibelmann Glock <fglock@gmail.com>.

=head1 SEE ALSO

=head1 COPYRIGHT

Copyright 2012 by Flavio Soibelmann Glock.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=end

