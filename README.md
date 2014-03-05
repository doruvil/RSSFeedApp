RSSFeedApp
==========

This app has been developed in order to show the content from a RSS Feed URL. A list of songs, and when one song is selected, then the content is shown.

Requirements:

The app should be able to show the content of the RSS Feed from the following URL:
http://itunes.apple.com/WebObjects/MZStore.woa/wpa/MRSS/newreleases/limit=5/rss.xml

The app should show the list of 5 songs, each element should contain the minimum info: title, artist, date as format:
hh:mm dd/MM/yy and one single image as the cover-art (downloaded and shown from the link of the song).

Further requirements:
The app should show more than just one feed (like a table), using navigation elements to show the list and than the content. The screen resolution should not mess the app contents, but also the app should be implemented according to the iOS 7 rules. (Xcode 5 as IDE).

Features:
- master-detail pattern from iOS
- both portrait and landspace orientation supported
- getting data from the feed
- parsing the XML data
- caching mechanism + asynchronous download mechanism for the images

