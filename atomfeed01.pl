#!/usr/local/bin/perl
use strict;
use warnings;

use XML::Atom::Feed;
use Data::Dumper;

my $url = "http://b.hatena.ne.jp/infinity_th4/atomfeed?tag=%E3%81%82%E3%81%A8%E3%81%A7%E8%AA%AD%E3%82%80&of=0";


my $feed = XML::Atom::Feed->new($url);

print $feed->title, "\n";

#print "ns: ", $feed->ns,"\n";

my @entries = $feed->entries;
foreach my $entry (@entries){
    print $entry->title,"\n";

    my @rellink  = grep {$_->rel eq 'related'} $entry->link;
    print $rellink[0]->href if(@rellink),"\n";

    print Dumper $entry->category();
    print "\n";

}
=pod
printf "lang: %sn", $feed->language;
printf "updated: %sn", $feed->updated;
printf "(modified: %s)n", $feed->modified;
print $feed->link, "n";
printf "generator: %sn", $feed->generator;
printf "id: %sn", $feed->id;
printf "%sn", "-"x25;


=cut
