#!/usr/bin/perl

use strict;
use warnings;
use XML::FeedPP;
use Data::Dumper;

my $offset = 0;

my $tagname = "あとで読む";
my $source = 'http://b.hatena.ne.jp/infinity_th4/atomfeed?tag='.$tagname.'&of='.$offset;

my $feed = XML::FeedPP->new( $source );
print "Title: ", $feed->title(), "\n";

sub allnum {
    my ( $title ) = shift;
    my $num;
    if($title =~ /\s\([0-9]+\)$/){
	my $str = "$&";
	if($str =~ /[0-9]+/){
	    $num = $&;
	    
	}
    }
    return $num;
}

print "All:",allnum($feed->title),"\n";

my $maxnum = allnum($feed->title);
my $i = 0;
while($i<int($maxnum / 20 ) + 1){
    $offset = 20*$i;
    $source = 'http://b.hatena.ne.jp/infinity_th4/atomfeed?tag='.$tagname.'&of='.$offset;
    $feed = XML::FeedPP->new( $source );

    foreach my $item ( $feed->get_item() ) {
	print "Link: ", $item->link(), "\n";
	print "Title: ", $item->title(), "\n";
	my @tags = $item->get("dc:subject");
	print "Tag:\n";
	foreach (@tags){
	    print $_,"\n";
	}
    }
    $i++;
    #print "=====================================\n";
}
=pod
    my $row = $c->model('RemainderDB::Bookmark')->create({
                userid => $userid, #login しているuserid
                memo => $memo,
                #weektimes => $weektimes,
                tag => '',
                fromtime => "$fromtime",
                totime => "$totime",
                days => $daystext,
                notification => $notification,
                #created => 'NOW()',
                #updated => 'NOW()',
							  });
            
        }
}

=cut
