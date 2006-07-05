#!/usr/bin/perl

package Perl::Generate::AST::Node::Const::Num;
use Moose;

with qw/
	Perl::Generate::AST::Node::Const
/;

has value => (
	isa => "Num",
	is  => "rw",
	required => 1,
);

sub ppi {
	my ( $self, $e ) = @_;

	PPI::Token::Number->new($self->value);
}

__PACKAGE__;

__END__
