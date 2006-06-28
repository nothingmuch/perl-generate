#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Var::Scalar";

can_ok( "Perl::Generate::AST::Node::Var::Scalar", "name" );
can_ok( "Perl::Generate::AST::Node::Var::Scalar", "sigil" );
can_ok( "Perl::Generate::AST::Node::Var::Scalar", "fullname" );

my $v = Perl::Generate::AST::Node::Var::Scalar->new( name => "moose" );

is( $v->name, "moose", "name" );
is( $v->sigil, '$', "sigil" );
is( $v->fullname, '$moose', "full name" );

our $moose = "lalala";

is( eval $v->stringify, "lalala", "eval" );

