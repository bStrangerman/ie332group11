<!-- generates login and registration errors -->
<?php  if (count($errors) > 0) : ?>
		<?php foreach ($errors as $error) : ?>
			<div class="error">
			<?php echo $error ?>
		</div>
		<?php endforeach ?>
<?php  endif ?>
