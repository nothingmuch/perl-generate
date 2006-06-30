#!/usr/bin/perl

package Perl::Generate::AST::Node::Sub::Base;
use Moose;

use Perl::Generate::AST::Node::Block;

# this does not 'with "Perl::Generate::AST::Node"; because it's not actually a useful node

has proto => (
	isa => "Str",
	is  => "rw",
	required => 0,
);

has body => (
	isa => "Perl::Generate::AST::Node::Block",
	is  => "rw",
	coerce  => 1,
	lazy    => 1,
	default => sub { Perl::Generate::AST::Node::Block->new },
);

sub ppi {
	my $self = shift;

	return (
		$self->ppi_decl,
		PPI::Token::Whitespace->new(' '),
		$self->ppi_proto,
		$self->ppi_body,
	);
}

sub ppi_decl {
	return PPI::Token::Word->new('sub'),
}

sub ppi_proto {
	my $self = shift;
	return (
		defined($self->proto)
		? ( PPI::Token::Prototype->new( '(' . $self->proto . ')' ), PPI::Token::Whitespace->new(' ') )
		: ()
	);
}

sub ppi_body {
	my $self = shift;

	$self->body->ppi;
}

__PACKAGE__;

__END__
