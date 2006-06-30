#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Sub::Named";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok( "Perl::Generate::AST::Node::Sub::Named", "body" );
can_ok( "Perl::Generate::AST::Node::Sub::Named", "name" );
can_ok( "Perl::Generate::AST::Node::Sub::Named", "ppi" );
can_ok( "Perl::Generate::AST::Node::Sub::Named", "stringify" );

my $sub = Perl::Generate::AST::Node::Sub::Named->new(
	name => "moose",
	body => Perl::Generate::AST::Node::Block->new(),
);

is( $sub->stringify, "sub moose {}", "empty sub" );

my $ret_var = Perl::Generate::AST::Node::Sub::Named->new(
	name => "elk",
	body => Perl::Generate::AST::Node::Var::Scalar->new( name => 'moose' ),
);

is( $ret_var->stringify, 'sub elk {$moose;}', "return a sub" );

my $many = Perl::Generate::AST::Node::Sub::Named->new(
	name => "bison",
	body => Perl::Generate::AST::Node::Stmts->new(
		substatements => [
			Perl::Generate::AST::Node::Var::Scalar->new( name => 'foo' ),
			Perl::Generate::AST::Node::Var::Scalar->new( name => 'bar' ),
		],
	),
);

is( $many->stringify, 'sub bison {$foo;$bar;}', "body as statements" );

my $proto = Perl::Generate::AST::Node::Sub::Named->new(
	name => "oink",
	proto => '$$',
);

is( $proto->stringify, 'sub oink ($$) {}', "sub with proto" );

