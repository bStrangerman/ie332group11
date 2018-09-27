<?php

require('simple_html_dom.php');

// Create DOM from URL or file
$html = file_get_html('https://loopnet.com/for-lease');

// creating an array of elements
$locations = [];

// Find top ten videos
$i = 1;
foreach ($html->find('<section class="spaces-available include-in-page" for-lease="">') as $locations) {
        if ($i > 10) {
                break;
        }

        // Find item link element
        $locationName = $locations->find('<h2 class="listing-name">', 0);

        // get title attribute
        $videoTitle = $videoDetails->title;

        // get href attribute
        $videoUrl = 'https://youtube.com' . $videoDetails->href;

        // push to a list of videos
        $videos[] = [
                'title' => $videoTitle,
                'url' => $videoUrl
        ];

        $i++;
}

var_dump($videos);
