#!/usr/bin/env perl
use strict;
use warnings;

use Net::GitHub::V3;

my %config = do '/secret/github.config';

my $gh = Net::GitHub::V3->new(
	login => $config{'username'},
	pass => $config{'password'}
);

my $gist = $gh->gist;

$gist->create({
		"description" => "the description for this gist",
		"public" => 'true',
		"files"  =>  {
			"file1.txt" => {
				"content" => "String file contents"
			}
		}
	} 
);


