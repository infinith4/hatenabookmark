#!/usr/bin/perl

use warnings;
use strict;
use WebService::Hatena::Bookmark::Lite;

my $username = "infinity_th4";
    my $password = "mUHUmkdfmiajfHYHdfs44323";

    my $bookmark = WebService::Hatena::Bookmark::Lite->new(
        username  => $username,
        password  => $password,
    );

    ### add
    # my $edit_ep = $bookmark->add(
    #     url     => $url,
    #     tag     => \@tag_list,
    #     comment => $comment,
    # );

    ### edit
# @tag = ( qw/ kaka tete /);
# $com = 'edit comment';

#     $bookmark->edit(
#         edit_ep => $edit_ep,
#         tag     => \@tag ,
#         comment => $com  ,
#     );

#     ### delete
#     $bookmark->delete(
#         edit_ep => $edit_ep ,
#     );

     # Get Feed
my $feed = $bookmark->getFeed();
print $feed->as_xml;

my $feed = $bookmark->getFeed();
print $feed->as_xml;

