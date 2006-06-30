#!/usr/bin/perl

package Perl::Generate::AST::Node::Block;
use Moose;
use Moose::Util::TypeConstraints;

use Perl::Generate::AST::Node::Stmts;

with qw/
	Perl::Generate::AST::Node
/;

coerce "Perl::Generate::AST::Node::Block" =>
	=> from "ArrayRef",
	=> via { Perl::Generate::AST::Node::Stmts->new( body => $_ ) },
	=> from "Perl::Generate::AST::Node",
	=> via { $_->isa(__PACKAGE__) ? $_ : Perl::Generate::AST::Node::Block->new( body => $_ ) };

has body => (
	isa => "Perl::Generate::AST::Node::Stmts",
	is  => "rw",
	required => 0,
	coerce   => 1,
);

sub ppi {
	my $self = shift;

	my $b = PPI::Structure::Block->new(
		PPI::Token::Structure->new('{'),
	);

	if ( my $body = $self->body ) {
		$b->__add_element( $_ ) for $body->ppi;
	}

	$b->_set_finish( PPI::Token::Structure->new('}') );

	return $b;
}

__PACKAGE__;

__END__
