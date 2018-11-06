<!-- generates login and registration errors -->
<?php
function errors($errors)
{
	if (count($errors) > 0) {
		foreach ($errors as $error) { ?>
			<div class="error">
				<?php echo $error ?>
			</div>
		<?php }
	}
}
?>
