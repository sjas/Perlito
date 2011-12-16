# Do not edit this file - Generated by Perlito5 7.0
use v5;
use utf8;
use strict;
use warnings;
no warnings ('redefine', 'once', 'void', 'uninitialized', 'misc', 'recursion');
use Perlito5::Perl5::Runtime;
use Perlito5::Perl5::Prelude;
our $MATCH = Perlito5::Match->new();
{
package GLOBAL;
    sub new { shift; bless { @_ }, "GLOBAL" }

    # use v6 
;
    {
    package CompUnit;
        sub new { shift; bless { @_ }, "CompUnit" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
            for my $stmt ( @{(defined $self->{body} ? $self->{body} : ($self->{body} ||= bless([], 'ARRAY')))} ) {
                $stmt->eval($env1)
            }
        }
    }

;
    {
    package Val::Int;
        sub new { shift; bless { @_ }, "Val::Int" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            0+($self->{int})
        }
    }

;
    {
    package Val::Bit;
        sub new { shift; bless { @_ }, "Val::Bit" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            $self->{bit}
        }
    }

;
    {
    package Val::Num;
        sub new { shift; bless { @_ }, "Val::Num" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            0+($self->{num})
        }
    }

;
    {
    package Val::Buf;
        sub new { shift; bless { @_ }, "Val::Buf" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            $self->{buf}
        }
    }

;
    {
    package Lit::Block;
        sub new { shift; bless { @_ }, "Lit::Block" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
            for my $stmt ( @{(defined $self->{stmts} ? $self->{stmts} : ($self->{stmts} ||= bless([], 'ARRAY')))} ) {
                $stmt->eval($env1)
            }
        }
    }

;
    {
    package Lit::Array;
        sub new { shift; bless { @_ }, "Lit::Array" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            (my  $List_a = bless [], 'ARRAY');
            for my $v ( @{(defined $self->{array1} ? $self->{array1} : ($self->{array1} ||= bless([], 'ARRAY')))} ) {
                push( @{$List_a}, $v->eval($env) )
            };
            return scalar ($List_a)
        }
    }

;
    {
    package Lit::Hash;
        sub new { shift; bless { @_ }, "Lit::Hash" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            (my  $Hash_h = bless {}, 'HASH');
            for my $field ( @{(defined $self->{hash1} ? $self->{hash1} : ($self->{hash1} ||= bless([], 'ARRAY')))} ) {
                ((my  $pair) = $field->arguments());
                ($Hash_h->{($pair->[0])->eval($env)} = ($pair->[1])->eval($env))
            };
            return scalar ($Hash_h)
        }
    }

;
    {
    package Index;
        sub new { shift; bless { @_ }, "Index" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ($self->{obj}->eval($env))->[$self->{index_exp}->eval($env)]
        }
    }

;
    {
    package Lookup;
        sub new { shift; bless { @_ }, "Lookup" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ($self->{obj}->eval($env))->{$self->{index_exp}->eval($env)}
        }
    }

;
    {
    package Var;
        sub new { shift; bless { @_ }, "Var" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = ($self->{namespace} . '::'))
            }
            else {
                if ((((($self->{sigil} eq chr(64))) && (($self->{twigil} eq '*'))) && (($self->{name} eq 'ARGS')))) {
                    return scalar ((\@ARGV))
                };
                if (($self->{twigil} eq '.')) {
                    warn(('Interpreter TODO: ' . chr(36) . '.' . $self->{name}));
                    return scalar ((chr(36) . 'self->' . chr(123) . $self->{name} . chr(125)))
                };
                if (($self->{name} eq chr(47))) {
                    warn('Interpreter TODO: ' . chr(36) . chr(47));
                    return scalar (($self->{sigil} . 'MATCH'))
                }
            };
            ((my  $name) = ($self->{sigil} . $ns . $self->{name}));
            for my $e ( @{(($env))} ) {
                if (exists($e->{$name})) {
                    return scalar ($e->{$name})
                }
            };
            warn(('Interpreter runtime error: variable ' . chr(39)), $name, (chr(39) . ' not found'))
        };
        sub plain_name {
            my $self = $_[0];
            if ($self->{namespace}) {
                return scalar (($self->{sigil} . $self->{namespace} . '::' . $self->{name}))
            };
            return scalar (($self->{sigil} . $self->{name}))
        }
    }

;
    {
    package Proto;
        sub new { shift; bless { @_ }, "Proto" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            "".($self->{name})
        }
    }

;
    {
    package Call;
        sub new { shift; bless { @_ }, "Call" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            warn(('Interpreter TODO: Call'));
            ((my  $invocant) = $self->{invocant}->eval($env));
            if (($invocant eq 'self')) {
                ($invocant = chr(36) . 'self')
            };
            if (($self->{hyper})) {

            };
            warn(('Interpreter runtime error: method ' . chr(39)), $self->{method}, ('()' . chr(39) . ' not found'))
        }
    }

;
    {
    package Apply;
        sub new { shift; bless { @_ }, "Apply" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $ns) = '');
            if ($self->{namespace}) {
                ($ns = ($self->{namespace} . '::'))
            };
            ((my  $code) = ($ns . $self->{code}));
            for my $e ( @{(($env))} ) {
                if (exists($e->{$code})) {
                    return scalar ((($e->{$code})->($env, (defined $self->{arguments} ? $self->{arguments} : ($self->{arguments} ||= bless([], 'ARRAY'))))))
                }
            };
            warn(('Interpreter runtime error: subroutine ' . chr(39)), $code, ('()' . chr(39) . ' not found'))
        }
    }

;
    {
    package If;
        sub new { shift; bless { @_ }, "If" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $cond) = $self->{cond});
            if ($cond->eval($env)) {
                ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
                for my $stmt ( @{((($self->{body})->stmts()))} ) {
                    $stmt->eval($env1)
                }
            }
            else {
                ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
                for my $stmt ( @{((($self->{otherwise})->stmts()))} ) {
                    $stmt->eval($env1)
                }
            };
            return scalar (undef())
        }
    }

;
    {
    package For;
        sub new { shift; bless { @_ }, "For" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $cond) = $self->{cond});
            ((my  $topic_name) = (($self->{body})->sig())->plain_name());
            ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
            for my $topic ( @{(($cond->eval($env)))} ) {
                ($env1->[0] = do {
    (my  $Hash_a = bless {}, 'HASH');
    ($Hash_a->{$topic_name} = $topic);
    $Hash_a
});
                for my $stmt ( @{((($self->{body})->stmts()))} ) {
                    $stmt->eval($env1)
                }
            };
            return scalar (undef())
        }
    }

;
    {
    package When;
        sub new { shift; bless { @_ }, "When" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            die(('TODO - When'))
        }
    }

;
    {
    package While;
        sub new { shift; bless { @_ }, "While" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            die(('TODO - While'))
        }
    }

;
    {
    package Decl;
        sub new { shift; bless { @_ }, "Decl" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $decl) = $self->{decl});
            ((my  $name) = $self->{var}->plain_name());
            if (($decl eq 'has')) {
                warn(('Interpreter TODO: has'))
            };
            if (!((exists(($env->[0])->{$name})))) {
                (($env->[0])->{$name} = undef())
            };
            return scalar (undef())
        };
        sub plain_name {
            my $self = $_[0];
            $self->{var}->plain_name()
        }
    }

;
    {
    package Method;
        sub new { shift; bless { @_ }, "Method" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            warn(('Interpreter TODO: Method'));
            ((my  $sig) = $self->{sig});
            ((my  $invocant) = $sig->invocant());
            ((my  $pos) = $sig->positional());
            ((my  $str) = 'my ' . chr(36) . 'List__ ' . chr(61) . ' ' . chr(92) . chr(64) . '_' . chr(59) . ' ')
        }
    }

;
    {
    package Sub;
        sub new { shift; bless { @_ }, "Sub" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            (my  $List_param_name = bless [], 'ARRAY');
            for my $field ( @{(($self->{sig}->positional()))} ) {
                push( @{$List_param_name}, $field->plain_name() )
            };
            ((my  $sub) = sub  {
    my $env = $_[0];
    my $args = $_[1];
    (my  $Hash_context = bless {}, 'HASH');
    ((my  $n) = 0);
    ($Hash_context->{chr(64) . '_'} = $args);
    for my $name ( @{$List_param_name} ) {
        ($Hash_context->{$name} = ($args->[$n])->eval($env));
        ($n = ($n + 1))
    };
    ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, $Hash_context );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
    (my  $r);
    for my $stmt ( @{(defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))} ) {
        ($r = $stmt->eval($env1))
    };
    return scalar ($r)
});
            if ($self->{name}) {
                (($env->[0])->{$self->{name}} = $sub)
            };
            return scalar ($sub)
        }
    }

;
    {
    package Do;
        sub new { shift; bless { @_ }, "Do" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            ((my  $env1) = do {
    (my  $List_a = bless [], 'ARRAY');
    (my  $List_v = bless [], 'ARRAY');
    push( @{$List_a}, do {
    (my  $Hash_a = bless {}, 'HASH');
    $Hash_a
} );
    ($List_v = ($env));
    for my $x ( @{(bless [0 .. ((scalar( @{$List_v} ) - 1))], 'ARRAY')} ) {
        push( @{$List_a}, $List_v->[$x] )
    };
    $List_a
});
            for my $stmt ( @{(defined $self->{block} ? $self->{block} : ($self->{block} ||= bless([], 'ARRAY')))} ) {
                $stmt->eval($env1)
            }
        }
    }

;
    {
    package Use;
        sub new { shift; bless { @_ }, "Use" }
        sub eval {
            my $self = $_[0];
            my $env = $_[1];
            warn(('Interpreter TODO: Use'));
            ('use ' . $self->{mod})
        }
    }


}

1;