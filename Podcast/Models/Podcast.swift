//
//  Podcast.swift
//  Podcast
//
//  Created by Raidan Shugaa Addin on 2022. 11. 13..
//

import Foundation

// Raw output
struct Result:Codable {

    var count:Int
    var feeds:[Feed] // Podcasts
}

//final class Podcast: NSObject, Decodable, NSCoding {
//
//    var trackName: String?
//    var artistName: String?
//    var artworkUrl600: String?
//    var trackCount: Int?
//    var feedUrlSting: String?
//
//    func encode(with aCoder: NSCoder) {
//        print("Trying to transform Podcast into Data")
//        aCoder.encode(trackName ?? "", forKey: Keys.trackNameKey)
//        aCoder.encode(artistName ?? "", forKey: Keys.artistNameKey)
//        aCoder.encode(artworkUrl600 ?? "", forKey: Keys.artworkKey)
//        aCoder.encode(feedUrlSting ?? "", forKey: Keys.feedKey)
//    }
//
//    init?(coder aDecoder: NSCoder) {
//        print("Trying to turn Data into Podcast")
//        trackName = aDecoder.decodeObject(forKey: Keys.) as? String
//        artistName = aDecoder.decodeObject(forKey: Keys.artistNameKey) as? String
//        artworkUrl600 = aDecoder.decodeObject(forKey: Keys.artworkKey) as? String
//        feedUrlSting = aDecoder.decodeObject(forKey: Keys.feedKey) as? String
//    }
//}


// Actual array of podcasts
struct Feed:Codable{
    var title:String
    var id:Int
   var url:String
   var description:String
  var author:String
   var image:String
   var artwork:String
}





//
//<rss xmlns:admin="http://webns.net/mvcb/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:wfw="http://wellformedweb.org/CommentAPI/" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:sy="http://purl.org/rss/1.0/modules/syndication/" xmlns:slash="http://purl.org/rss/1.0/modules/slash/" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:media="http://search.yahoo.com/mrss/" xmlns:googleplay="http://www.google.com/schemas/play-podcasts/1.0" xmlns:podcast="https://github.com/Podcastindex-org/podcast-namespace/blob/main/docs/1.0.md" version="2.0">
//<script/>
//<div id="link-utilities-chrome-extension-identificator" class="link-utilities-chrome-extension-identificator"/>
//<channel>
//<atom:link href="https://engineered.network/sleep/feed/index.xml" rel="self" type="application/rss+xml"/>
//<atom:link href="https://pubsubhubbub.appspot.com/" rel="hub"/>
//<title>Sleep</title>
//<link>https://engineered.network/sleep</link>
//<language>en-us</language>
//<copyright>
//<![CDATA[ John Chidgey ]]>
//</copyright>
//<docs>https://engineered.network/sleep</docs>
//<managingEditor>john@engineered.network (john@engineered.network)</managingEditor>
//<itunes:owner>
//<itunes:name>
//<![CDATA[ The Engineered Network ]]>
//</itunes:name>
//<itunes:email>john@engineered.network</itunes:email>
//</itunes:owner>
//<itunes:author>The Engineered Network</itunes:author>
//<itunes:explicit>clean</itunes:explicit>
//<itunes:image href="https://engineered.network/img/sleep/sleepfeed.png"/>
//<itunes:keywords>Sleep</itunes:keywords>
//<itunes:subtitle>Sleep</itunes:subtitle>
//<itunes:summary>
//<![CDATA[ Helping you fall asleep. Let me talk to you. Just for a few moments ]]>
//</itunes:summary>
//<googleplay:author>The Engineered Network</googleplay:author>
//<googleplay:email>john@engineered.network</googleplay:email>
//<googleplay:description>Helping you fall asleep. Let me talk to you. Just for a few moments </googleplay:description>
//<googleplay:image href="https://engineered.network/img/sleep/sleepfeed.png"/>
//<description>
//<![CDATA[ Helping you fall asleep. Let me talk to you. Just for a few moments ]]>
//</description>
//<itunes:block>No</itunes:block>
//<itunes:category text="Education">
//<itunes:category text="Self-Improvement"/>
//</itunes:category>
//<itunes:type>episodic</itunes:type>
//<itunes:new-feed-url>https://engineered.network/sleep/feed/index.xml</itunes:new-feed-url>
//<lastBuildDate>Sun, 13 Nov 2022 12:53:26 GMT</lastBuildDate>
//<sy:updatePeriod>hourly</sy:updatePeriod>
//<sy:updateFrequency>1</sy:updateFrequency>
//<image>
//<url>https://engineered.network/img/sleep/sleepfeed.png</url>
//<title>Sleep</title>
//<link>https://engineered.network/sleep</link>
//</image>
//<podcast:locked owner="john@engineered.network">yes</podcast:locked>
//<podcast:funding url="https://patreon.com/johnchidgey">Sleep on Patreon</podcast:funding>
//<podcast:value type="lightning" method="keysend" suggested="0.00000010000">
//<podcast:valueRecipient name="podcaster" type="node" address="02ec5c61cff2be8207851d909b72c15ec27d16d5aeeecf74b9170cb1f8ee6e0d64" split="100"/>
//</podcast:value>
//<podcast:guid>84fa6893-0123-5433-a7bb-8b1dc5beb76e</podcast:guid>
//<podcast:trailer pubdate="Sun, 29 Mar 2020 06:00:00 +1000" url="https://mediastore.engineered.network/sleep/Sleep-E000-Trailer.mp3" length="785615" type="audio/mp3">Trailer</podcast:trailer>
//<podcast:license>CC-BY-SA-4.0</podcast:license>
//<podcast:medium>podcast</podcast:medium>
//<podcast:images srcset="https://engineered.network/img/sleep/sleep.png 150w, https://engineered.network/img/sleep/sleep@2x.png 300w, https://engineered.network/img/sleep/sleepfeed.png 1400w, https://engineered.network/img/sleep/sleeplarge.png 600w, https://engineered.network/img/sleep/sleeplarge@2x.png 1200w"/>
//<generator>TEN RSS Generator</generator>
//<item>
//<title>20: Outpost Atari</title>
//<itunes:author>The Engineered Network</itunes:author>
//<itunes:explicit>clean</itunes:explicit>
//<googleplay:explicit>No</googleplay:explicit>
//<itunes:subtitle>
//<![CDATA[ David Small and Art Leyenberger bring news from a recent visit to Atari and about new books of interest to Atari users. From the July 1984 edition of the Creative Computing Magazine. ]]>
//</itunes:subtitle>
//<description>
//<![CDATA[ David Small and Art Leyenberger bring news from a recent visit to Atari and about new books of interest to Atari users. From the July 1984 edition of the Creative Computing Magazine.<br>With John Chidgey.<br><p>Reading Material:</p> <ul> <li><a href="https://archive.org/details/creativecomputing-1984-07/page/n215/mode/2up">Creative Computing Magazine (July 1984) Volume 10 Number 07</a></li> </ul> <p>Other shows on the network:</p> <ul> <li><a href="/causality">Causality</a></li> <li><a href="/pragmatic">Pragmatic</a></li> </ul> <br>Support Sleep on <a rel="payment" href="http://patreon.com/johnchidgey" title="Sleep on Patreon"> Patreon</a><br><br>Episode Gold Producers: &#39;r&#39; and Steven Bridle.<br>Episode Silver Producers: Mitch Biegler, Kevin Koch, Lesley, Shane O’Neill, Hafthor, Jared, Bill, Joel Maher, Katharina Will and Dave Jones. ]]>
//</description>
//<googleplay:description>
//<![CDATA[ David Small and Art Leyenberger bring news from a recent visit to Atari and about new books of interest to Atari users. From the July 1984 edition of the Creative Computing Magazine.<br>With John Chidgey.<br><p>Reading Material:</p> <ul> <li><a href="https://archive.org/details/creativecomputing-1984-07/page/n215/mode/2up">Creative Computing Magazine (July 1984) Volume 10 Number 07</a></li> </ul> <p>Other shows on the network:</p> <ul> <li><a href="/causality">Causality</a></li> <li><a href="/pragmatic">Pragmatic</a></li> </ul> <br>Support Sleep on <a rel="payment" href="http://patreon.com/johnchidgey" title="Sleep on Patreon"> Patreon</a><br><br>Episode Gold Producers: &#39;r&#39; and Steven Bridle.<br>Episode Silver Producers: Mitch Biegler, Kevin Koch, Lesley, Shane O’Neill, Hafthor, Jared, Bill, Joel Maher, Katharina Will and Dave Jones. ]]>
//</googleplay:description>
//<link>
//<![CDATA[ https://engineered.network/sleep/episode-20-outpost-atari ]]>
//</link>
//<guid isPermaLink="true">
//<![CDATA[ https://engineered.network/sleep/episode-20-outpost-atari ]]>
//</guid>
//<content:encoded>
//<![CDATA[ David Small and Art Leyenberger bring news from a recent visit to Atari and about new books of interest to Atari users. From the July 1984 edition of the Creative Computing Magazine.<br>With John Chidgey.<br><p>Reading Material:</p> <ul> <li><a href="https://archive.org/details/creativecomputing-1984-07/page/n215/mode/2up">Creative Computing Magazine (July 1984) Volume 10 Number 07</a></li> </ul> <p>Other shows on the network:</p> <ul> <li><a href="/causality">Causality</a></li> <li><a href="/pragmatic">Pragmatic</a></li> </ul> <br>Support Sleep on <a rel="payment" href="http://patreon.com/johnchidgey" title="Sleep on Patreon"> Patreon</a><br><br>Episode Gold Producers: &#39;r&#39; and Steven Bridle.<br>Episode Silver Producers: Mitch Biegler, Kevin Koch, Lesley, Shane O’Neill, Hafthor, Jared, Bill, Joel Maher, Katharina Will and Dave Jones. ]]>
//</content:encoded>
//<pubDate>Tue, 20 Sep 2022 06:00:00 +1000</pubDate>
//<itunes:image href="https://engineered.network/img/sleep/defaultEpisodeImage.jpg"/>
//<googleplay:image href="https://engineered.network/img/sleep/defaultEpisodeImage.jpg"/>
//<itunes:summary>David Small and Art Leyenberger bring news from a recent visit to Atari and about new books of interest to Atari users. From the July 1984 edition of the Creative Computing Magazine.</itunes:summary>
//<enclosure url="https://mediastore.engineered.network/sleep/Sleep-E020-Outpost-Atari.mp3" length="7688243" type="audio/mpeg"/>
//<category>Podcasts</category>
//<itunes:duration>00:15:51</itunes:duration>
//<itunes:keywords>Sleep</itunes:keywords>
//<itunes:episode>20</itunes:episode>
//<itunes:title>Outpost Atari</itunes:title>
//<itunes:episodeType>full</itunes:episodeType>
//<dc:creator>The Engineered Network</dc:creator>
//<toothashtag>#Engineered_Net</toothashtag>
//<tootimage href="https://engineered.network/img/sleep/defaultEpisodeImage.jpg"/>
//<tootwith>with @chidgey@engineered.space</tootwith>
//<podcast:person group="Cast" role="host" href="https://www.podchaser.com/creators/john-chidgey-107ZzlNYaO" img="https://engineered.network/img/people/john-chidgey.jpg">John Chidgey</podcast:person>
//<podcast:season name="TEN">1</podcast:season>
//<podcast:episode display="20">20</podcast:episode>
//<itunes:season>1</itunes:season>
//</item>
