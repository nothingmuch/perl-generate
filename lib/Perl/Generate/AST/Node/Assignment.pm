#!/usr/bin/perl

package Perl::Generate::AST::Node::Assignment;
use Moose;

with "Perl::Generate::AST::Node::RV";

has lvalue => (
	does => "Perl::Generate::AST::Node::LV",
	is   => "rw",
	required => 1,
);

has rvalue => (
	does => "Perl::Generate::AST::Node::RV",
	is   => "rw",
	required => 1,
);

sub ppi {
	my $self = shift;

	my @lv_ppi = $self->lvalue->ppi;
	my $assignment = PPI::Statement::Expression->new( shift @lv_ppi );
	$assignment->__add_element( $_ ) for @lv_ppi;

	$assignment->__add_element( PPI::Token::Operator->new('=') );

	$assignment->__add_element( $_ ) for $self->rvalue->ppi;

	$assignment;
}

__PACKAGE__;
