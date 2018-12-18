# ie332group11

Fall 2018 Project for IE 332 at Purdue University

You have to define the database credentials in the following files:
<ui>
  <li>www/includes/db.php</li>
  <li>www/includes/PhpRbac/database/database.config</li>
</ui>

dbhost=localhost
user=root
password=""
dbname=ie332group11

Grading by Mario
Database design and implementation: (3/5)
-1: why no distinguishing between Owners and Lessees? 
-0.5: multiple relationships with the same name
-0.5: why modeling how contracts are influenced? this is not part of the DB

User interface design and implementation: (3.5/4)
-0.5: dashboards are pretty barren, should have used the space more effectively

Data synthesis: (2/4)
-1: IDs organized as users/owners by <400 and >400 is extremely restrictive going forward, bad design
-1: contracts are too random, do not capture much of the natural/expected correlations

Ranking: (2.5/4.5)
-1: why are user/warehouse ratings not considered in the ranking? 
-0.5: unclear how the difference scores are combined
-0.5: missing explanation for why this is the best way to perform ranking

ML/analytics: (2/4.5)
-2.5: would have liked to see more useful analytics on each dashboard, and some basic ML

Presentation: (3/3)

Final report: (3/3)

Discretionary: (0/0)

Bonus: (5/5)
+0.5: Github/XAMPP
+0.5: PHP-RBAC
+0.5: SQL sanitization
+0.5: notifications
+0.5: leaflet/map layer
+0.5: Zing
+0.5: location search 
+0.5: md5 password hasing
+0.5: .htaccess
+0.5: recaptcha

Latex: (1/1)
