#!/usr/bin/perl

package Perl::Generate::AST::Node::Sub::Anon;
use Moose;

extends "Perl::Generate::AST::Node::Sub::Base";

sub ppi { goto \&Perl::Generate::AST::Node::Sub::Base::ppi }

with qw/
	Perl::Generate::AST::Node::RV
/;

__PACKAGE__;

__END__

