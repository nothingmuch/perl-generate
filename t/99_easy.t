#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate";

sub foo {
	shift() . "gic";
}

sub gorch { 42 }

our $bar = "ma";

my $var = var('$bar');

ok( $var->does("Perl::Generate::AST::Node::Expr"), "var does expr");

is( eval call( 'foo', var('$bar') )->stringify, "magic", "call with an arg"  );


is( eval assign( var('$bar'), call('gorch') )->stringify, 42, "assignments is rvalue" );

is( $bar, 42, "bar was assigned to" );

our ( $cond1, $cond2 ) = ( 1, 1 );
my ( $m, $e );
sub moose { $m++ }
sub elk { $e++ }

eval cond( var('$cond1'), call('elk') )->stringify;
is( $e, 1, "elk called" );

$cond1 = 0;
eval cond( var('$cond1'), call('elk') )->stringify;
is( $e, 1, "elk not called" );

eval cond( var('$cond1'), call('elk'), call('moose') )->stringify;
is( $e, 1, "elk not called" );
is( $m, 1, "moose called" );

# what lisp?
eval
cond(var('$cond1'),
	call('elk'),
	cond(var('$cond2'),
		call('moose')))->stringify;

is( $e, 1, "elk not called" );
is( $m, 2, "moose called" );

$cond2 = 0;
eval
cond(var('$cond1'),
	call('elk'),
	cond(var('$cond2'),
		call('moose')))->stringify;

is( $e, 1, "elk not called" );
is( $m, 2, "moose not called" );

eval
stmts(
	call('elk'),
	call('elk'),
	call('moose'))->stringify;

is( $e, 3, "elk called twice" );
is( $m, 3, "moose called once" );

my $sub = eval asub( call('moose') )->stringify;

is( ref($sub), "CODE", "got a code ref" );

is( $m, 3, "moose not called" );

$sub->();

is( $m, 4, "moose called" );

eval { lalala() };
ok( $@, "lalala() dies" );

is( $e, 3, "elk not called" );

eval nsub( lalala => call('elk') )->stringify;

eval { lalala() };
ok( !$@, "lalala() doesn't die" );

is( $e, 4, "elk called" );


# constant coercions
{
	my $assign = assign( var('$bar'), 3 );
	isa_ok( $assign->rvalue, "Perl::Generate::AST::Node::Const::Num", "coerced" );
	is( $assign->rvalue->value, 3, , "value is correct" );
}
{
	my $assign = assign( var('$bar'), 'foo' );
	isa_ok( $assign->rvalue, "Perl::Generate::AST::Node::Const::Str", "coerced" );
	is( $assign->rvalue->value, 'foo', , "value is correct" );
}
{
	my $assign = assign( var('$bar'), str(3) );
	isa_ok( $assign->rvalue, "Perl::Generate::AST::Node::Const::Str", "overridden" );
	is( $assign->rvalue->value, 3, , "value is correct" );
}

isa_ok( num(3), "Perl::Generate::AST::Node::Const::Num", "overridden" );
