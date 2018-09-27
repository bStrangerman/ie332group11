<?php
function crawl_page($url, $depth = 5)
{
  static $seen = array();
  if (isset($seen[$url]) || $depth === 0) {
    return;
  }

  $seen[$url] = true;

  $dom = new DOMDocument('1.0');
  @$dom->loadHTMLFile($url);

  $anchors = $dom->getElementsByTagName('a');
  foreach ($anchors as $element) {
    $href = $element->getAttribute('href');
    if (0 !== strpos($href, 'http')) {
       /* this is where I changed hobodave's code */
        $host = "http://".parse_url($url,PHP_URL_HOST);
        $href = $host. '/' . ltrim($href, '/');
    }
    crawl_page($href, $depth - 1);
  }

  echo "New Page:<br /> ";
  echo "URL:",$url,PHP_EOL,"<br />","CONTENT:",PHP_EOL,$dom->saveHTML(),PHP_EOL,PHP_EOL,"  <br /><br />";
}

crawl_page("http://www.loopnet.com/for-lease/west-lafayette-in/", 9);
?>
