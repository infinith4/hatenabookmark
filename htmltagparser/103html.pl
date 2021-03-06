use strict;
use warnings;
use LWP::UserAgent;
use HTML::TreeBuilder;

#文字コード
#use shiftjis;
#binmode STDERR, ":encoding(shiftjis)";
#binmode STDOUT, ":encoding(shiftjis)";
use Encode;


# urlを指定する
my $url = 'http://www.amazon.co.jp/Web%E5%88%B6%E4%BD%9C%E3%81%AE%E7%8F%BE%E5%A0%B4%E3%81%A7%E4%BD%BF%E3%81%86-jQuery%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3%E5%85%A5%E9%96%80-WEB-PROFESSIONAL-%E8%A5%BF%E7%95%91/dp/4048684116/ref=sr_1_1?ie=UTF8&qid=1351643657&sr=8-1';

# IE8のフリをする
my $user_agent = "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0)";

# LWPを使ってサイトにアクセスし、HTMLの内容を取得する
my $ua = LWP::UserAgent->new('agent' => $user_agent);
my $res = $ua->get($url);
my $content = $res->content;#$contentには、HTMLを文字列として格納したものが入ります。
#$content = encode('utf8', decode_shiftjis($content));
#decode('shiftjis',$content);#$content is shiftjis.
Encode::from_to($content, 'shiftjis', 'utf8');#これで,shiftjisからutf8に変換できる.

# HTML::TreeBuilderで解析する
my $tree = HTML::TreeBuilder->new;
$tree->parse($content);

#ここまではお約束


# DOM操作してトピックの部分だけ抜き出す。
# <div id='topicsfb'><ul><li>....の部分を抽出する

#my @items =  $tree->look_down('id', 'topicsfb')->find('li');#HTML文書中で、id属性がtopicsfbである要素を取得せよ.その要素の中のli要素のリストを取得せよ.(DOM的な感じ)

 
#print $_->as_text."\n" for @items;
#print "\n";

#my $tag = $tree->look_down('class', 'gry txtsmall hlp');
#print $tag->as_text;

print "それぞれの星についてのカスタマーレビューの数:\n";
#for my $tag ( $tree->look_down("class", "tiny")->find("a") ){
#    print $tag->as_text."\n";
#}
#print "\n";
foreach my $tag ($tree->find("table")->find("td")) {
    print $tag->as_HTML,"\n"; # 含まれるHTMLを取り出す
}

if($tree->find("span")->attr('style') == "color: #666666;font-family:Verdana,Arial,Helvetica,Sans-serif;;font-size:10px;"){
    print $tree->find("span")->attr('style')->as_text."\n";
}
#その商品の総合的な評価は<div class="gry txtnormal acrRating">で得る.


print "総合的な評価を取得:\n";
for my $tag ( $tree->look_down("class", "gry txtnormal acrRating") ){
    print $tag->as_text."\n";
}
print "\n";

# 要素 class に値 gry txtsmall hlpをもつものを取り出す
# カスタマーレビューが参考になったかを取得できる.
print "カスタマーレビューが参考になったかを取得:\n";
for my $tag ( $tree->look_down("class", "gry txtsmall hlp") ){
    print $tag->as_text."\n";
}

print "\n";

#いいねの数
print "いいねの数:\n";
#look_down can use regular expression.
for my $tag ( $tree->look_down("id", qr/amznLikeStateCache_/ ) ){
    print $tag->as_text."\n";
}




#class は取得できるか？
##http://dqn.sakusakutto.jp/2010/06/perlhtml.html
