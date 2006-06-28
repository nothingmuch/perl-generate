#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use ok "Perl::Generate::AST::Node::Assignment";

use Perl::Generate::AST::Node::Var::Scalar;

can_ok( "Perl::Generate::AST::Node::Assignment", "lvalue" );
can_ok( "Perl::Generate::AST::Node::Assignment", "rvalue" );

