<!DOCTYPE html>
<html>
<head>
<meta charset=utf-8 />
<title>Plain Leaflet API</title>
<meta name='viewport' content='initial-scale=1,maximum-scale=1,user-scalable=no' />
<script src='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.js'></script>
<link href='https://api.mapbox.com/mapbox.js/v3.1.1/mapbox.css' rel='stylesheet' />
<style>
  body { margin:0; padding:0; }
  #map { position:absolute; top:0; bottom:0; width:100%; }
</style>
</head>
<body>

<div id='map'></div>

<script>
L.mapbox.accessToken = 'pk.eyJ1IjoiYmhhYmVybWFuIiwiYSI6ImNqb243Zm10bTA5Z2gzd3BveGFsZmc3OWQifQ.I0MogIUCPxeCsFV04fF4YA';
// Replace 'mapbox.streets' with your map id.
var mapboxTiles = L.tileLayer('https://api.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?access_token=' + L.mapbox.accessToken, {
    attribution: '© <a href="https://www.mapbox.com/feedback/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
});

var map = L.map('map')
    .addLayer(mapboxTiles)
    .setView([42.3610, -71.0587], 15);
</script>

</body>
</html>
