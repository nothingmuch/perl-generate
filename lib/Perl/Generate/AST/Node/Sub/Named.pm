#!/usr/bin/perl

package Perl::Generate::AST::Node::Sub::Named;
use Moose;

extends "Perl::Generate::AST::Node::Sub::Base";

with qw/
	Perl::Generate::AST::Node::Stmt
/;

has name => (
	isa => "Str",
	is  => "rw",
	required => 1,
);

# can't override
sub ppi {
	my $self = shift;

	my @parts = $self->SUPER::ppi( @_ );

	my $sub = PPI::Statement::Sub->new( shift @parts );

	$sub->__add_element( $_ ) for @parts;

	$sub;
}

override ppi_decl => sub {
	my $self = shift;

	return (
		super,
		PPI::Token::Whitespace->new(' '),
		PPI::Token::Word->new( $self->name ),
	);
};

__PACKAGE__;

__END__


