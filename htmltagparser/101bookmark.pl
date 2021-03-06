#!/usr/bin/perl -w

use strict;
use warnings;
use XML::Atom::Client;

my $ROOT_URL = "http://b.hatena.ne.jp/atom";
my $POST_URI = $ROOT_URL . "/post/";
my $EDIT_URI = $ROOT_URL . "/edit/";
my $FEED_URI = $ROOT_URL . "/feed";
my $USER     = "infinith4";
my $PASS     = "mwinazk5";

# Initialize
my $api = XML::Atom::Client->new;
$api->username($USER);
$api->password($PASS);


my $recentFeed = $api->getFeed($FEED_URI);
my @eidList    = getEIDList($recentFeed->as_xml);
while (scalar @eidList > 0) {
    foreach my $eid (@eidList) {
        print "[DELETE] eid:$eid/" . $api->getFeed($EDIT_URI . $eid) . ".\n";
    }
    $recentFeed = $api->getFeed($FEED_URI);
    @eidList    = getEIDList($recentFeed->as_xml);
}

##

sub getEIDList {
    my $feed = shift;
  
    my @lines   = split("\n", $feed);
    my @eidList = ();
    foreach my $line (@lines) {
        if ($line =~ /rel\=\"service.edit\"/) {
            $line =~ /href\=\".+\/edit\/([0-9]+)\"/;
            push(@eidList, $1);
        } else {
        }
    }
  
    return @eidList;
}
