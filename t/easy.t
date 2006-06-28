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


