#!/usr/bin/env perl
use strict;
use warnings;
use CGI qw/-utf8 :standard/;
use DateTime::Format::W3CDTF;

my $req = CGI->new;

# キーの比較
if ($req->param('key') ne 'xxxxxxxxxxx') {
    die "Authentication failed";
}

# ユーザーの情報
my $username = $req->param('username');

# エントリーの情報
my $url    = $req->param('url');
my $title = $req->param('title');
my $count  = $req->param('count');

# ブックマークの情報
my $status    = $req->param('status'); # 'add' or 'update' or 'delete'
my $timestamp = DateTime::Format::W3CDTF->parse_datetime($req->param('timestamp'));
my $comment     = $req->param('comment');
my $is_private = $req->param('is_private'); # 0 or 1

# ここに好きな処理を実装する
print $comment;


print header('text/plain');
print 'ok';
