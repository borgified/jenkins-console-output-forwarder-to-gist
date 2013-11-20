#!/usr/bin/env perl
use strict;
use warnings;
use Data::Dumper;

use Net::GitHub::V3;

my %config = do '/secret/github.config';

my $gh = Net::GitHub::V3->new(
	login => $config{'username'},
	pass => $config{'password'}
);

my $gist = $gh->gist;

my($worker,$build)=@ARGV;

my $filename = "/var/lib/jenkins/jobs/assimmon/configurations/axis-label/$worker/builds/$build/log";

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my $log = do { local $/; <$fh> };


$log =~ /cat (.*)sudo apt-get update\n/s;
my $details=$1;

my %gistconfig = do '/secret/gists.config';


my $r = $gist->update( $gistconfig{$worker}, {
		description => "build: $build $details",
		"files"  =>  {
			"build.log" => {
				"content" => $log,
			}
		}
	}
);

my $raw_url = $r->{files}->{'build.log'}->{raw_url};

my $all_log = $gist->gist(7542687);
my $all_log_content = $all_log->{files}->{'all.log'}->{content};

$gist->update( 7542687, {
		"files" => {
			"all.log" => {
				"content" => "$worker:$build:$raw_url\n$all_log_content",
			}
		}
	}
);




#open (my $f,'>>',"/tmp/gists");
#print $f "$worker => \'$a->{id}\'\n";


__END__

#6544858

$gist->update( 6544858, {
description => "",
"files"  =>  {
"file1.txt" => {
"content" => $log,
}
}
}
);


__END__

my $a = $gist->create({
"description" => "console output for $worker\n$details",
"public" => 'true',
"files"  =>  {
"build.log" => {
"content" => $log,
}
}
} 
);


