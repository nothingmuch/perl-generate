#!/usr/bin/perl

package Perl::Generate::AST::Node::Subcall;
use Moose;
use Moose::Util::TypeConstraints;

use Perl::Generate::AST::Node::Bareword;

with qw/
	Perl::Generate::AST::Node::RV
/;

subtype "Perl::Generate::AST::Node::Subcall::ActsLikeCode"
	=> as "Perl::Generate::AST::Node::RV"
	=> where { 1 };

coerce "Perl::Generate::AST::Node::Subcall::ActsLikeCode" =>
	from "Str",
	via { Perl::Generate::AST::Node::Bareword->new( value => $_ ) };

has code => (
	isa => "Perl::Generate::AST::Node::Subcall::ActsLikeCode",
	is  => "rw",
	required => 1,
	coerce   => 1,
);

has args => (
	does => "Perl::Generate::AST::Node::Expr",
	is   => "rw",
	required => 0,
);

sub args_ppi {
	my ( $self, $e ) = @_;

	my $args = PPI::Structure::List->new( PPI::Token::Structure->new('(') );

	if ( my $args_expr = $self->args ) {
		$args->__add_element($_) for $args_expr->ppi;
	}

	$args->_set_finish( PPI::Token::Structure->new(')') );

	return $args;
}

sub code_ppi {
	my ( $self, $e ) = @_;

	my $code = $self->code;

	if ( $code->isa("Perl::Generate::AST::Node::Bareword") ) {
		# bareword form
		return $code->ppi;
	} else {
		# FIXME make parens optional
		# code ref form
		my $code_ppi = PPI::Structure::List->new( PPI::Token::Structure->new('(') );

		$code_ppi->__add_element($_) for $code->ppi;

		$code_ppi->_set_finish( PPI::Token::Structure->new(')') );

		return (
			$code_ppi,
			PPI::Token::Operator->new('->')
		);
	}
}

sub ppi {
	my $self = shift;

	return (
		$self->code_ppi,
		$self->args_ppi,
	);
}

__PACKAGE__;

__END__
