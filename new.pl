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

my($worker,$build)=@ARGV;

my $filename = "/var/lib/jenkins/jobs/assimmon/configurations/axis-label/$worker/builds/$build/log";

open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!"

while (my $row = <$fh>) {
	chomp $row;
	print "$row\n";
}
__END__

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


