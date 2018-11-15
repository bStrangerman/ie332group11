<?php
require_once "../includes/main.php";
include_once "../includes/contracts.php";
require_once "../layouts/sb_admin_2/header.php";
?>
<div id="page-wrapper">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Lessee Survey</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Basic Form Elements
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form action="post" role="form">


<!-- Experience with warehouse -->
<div class="form-group">
    <label>Share with the community your warehouse experience.</label>
    <textarea class="form-control" placeholder="How was your warehouse experience?" rows="3"></textarea>
    </div>
</div>
<br>
<!-- END OF Experience -->




<!-- Private Feedback to Space Owner -->

<!-- END OF PRIVATE FEEDBACK -->







<!-- INSTRUCTIONS -->
                              <div class="form-group">
                                  <label>Static Control</label>
                                  <p class="form-control-static">Please rate your experience on a scale of 1 to 5 on the following categories.</p>
                              </div>
<!-- END OF INSTRUCTIONS -->










<!--Lykert Scale for Accuracy of Listing, Communication with Staff, Friendlyness of Staff, Location of Warehouse, Value of Space -->

                              <!-- Accuracy of Listing -->
                              <div class="form-group">
                                  <label>Accuracy of Listing</label> <br>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                  </label>
                              </div>

                              <!-- Communication with Staff-->
                              <div class="form-group">
                                  <label>Communication with Staff</label> <br>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                  </label>
                              </div>

                              <!-- Friendlyness of Staff-->
                              <div class="form-group">
                                  <label>Friendlyness of Staff</label> <br>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                  </label>
                              </div>


                              <!-- Location of Warehouse-->
                              <div class="form-group">
                                  <label>Location of Warehouse</label> <br>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                  </label>
                              </div>


                              <!-- Value of Space-->
                              <div class="form-group">
                                  <label>Value of Space</label> <br>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                  </label>
                                  <label class="radio-inline">
                                      <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                  </label>
                              </div>

<!-- END OF LYKERT -->






















<!-- Text Input Single Line -->

                            <!--
                                <div class="form-group">
                                    <label>Text Input with Placeholder</label>
                                    <input class="form-control" placeholder="Enter text">
                                </div>
                              -->





<!-- Static Control -->
                                <!-- <div class="form-group">
                                    <label>Static Control</label>
                                    <p class="form-control-static">email@example.com</p>
                                </div> -->


<!--  File Input -->
                                <!-- <div class="form-group">
                                    <label>File input</label>
                                    <input type="file">
                                </div> -->






<!-- TEXT AREA -->
                                <!-- <div class="form-group">
                                    <label>Text area</label>
                                    <textarea class="form-control" rows="3"></textarea>
                                </div> -->




<!-- Check Boxes Vertical List -->
                                <!-- <div class="form-group">
                                    <label>Checkboxes</label>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="">Checkbox 1
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="">Checkbox 2
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="">Checkbox 3
                                        </label>
                                    </div>
                                </div> -->




<!-- Check Boxes Horizontal List -->
                                <!-- <div class="form-group">
                                    <label>Inline Checkboxes</label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox">1
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox">2
                                    </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox">3
                                    </label>
                                </div> -->





<!-- Vertical Radio Buttons -->
                                <!-- <div class="form-group">
                                    <label>Radio Buttons</label>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>Radio 1
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">Radio 2
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label>
                                            <input type="radio" name="optionsRadios" id="optionsRadios3" value="option3">Radio 3
                                        </label>
                                    </div>
                                </div> -->



<!-- Hoziontal Lykert Scale -->
                                <!-- Accuracy -->
                                <!-- <div class="form-group">
                                    <label>Accuracy of Listing</label> <br>
                                    <label class="radio-inline">
                                        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline1" value="option1" checked>1
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline2" value="option2">2
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline3" value="option3">3
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline4" value="option4">4
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optionsRadiosInline" id="optionsRadiosInline5" value="option5">5
                                    </label>
                                </div> -->
<!-- End of Lykert Scale -->




<!-- Drop Down Menu -->
                                <!-- <div class="form-group">
                                    <label>Selects</label>
                                    <select class="form-control">
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                    </select>
                                </div> -->





<!-- Selection Menu -->
                                <!-- <div class="form-group">
                                    <label>Multiple Selects</label>
                                    <select multiple class="form-control">
                                        <option>1</option>
                                        <option>2</option>
                                        <option>3</option>
                                        <option>4</option>
                                        <option>5</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-default">Submit Button</button>
                                <button type="reset" class="btn btn-default">Reset Button</button>
                            </form>
                        </div> -->







<!-- DISABLE STATE -->
                        <!-- /.col-lg-6 (nested) -->
                        <!-- <div class="col-lg-6">
                            <h1>Disabled Form States</h1>
                            <form role="form">
                                <fieldset disabled>
                                    <div class="form-group">
                                        <label for="disabledSelect">Disabled input</label>
                                        <input class="form-control" id="disabledInput" type="text" placeholder="Disabled input" disabled>
                                    </div>
                                    <div class="form-group">
                                        <label for="disabledSelect">Disabled select menu</label>
                                        <select id="disabledSelect" class="form-control">
                                            <option>Disabled select</option>
                                        </select>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox">Disabled Checkbox
                                        </label>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Disabled Button</button>
                                </fieldset>
                            </form> -->







<!-- Form Validation  -->
                            <!-- <h1>Form Validation States</h1>
                            <form role="form">
                                <div class="form-group has-success">
                                    <label class="control-label" for="inputSuccess">Input with success</label>
                                    <input type="text" class="form-control" id="inputSuccess">
                                </div>
                                <div class="form-group has-warning">
                                    <label class="control-label" for="inputWarning">Input with warning</label>
                                    <input type="text" class="form-control" id="inputWarning">
                                </div>
                                <div class="form-group has-error">
                                    <label class="control-label" for="inputError">Input with error</label>
                                    <input type="text" class="form-control" id="inputError">
                                </div>
                            </form> -->





<!--INPUT GROUPS-->
                          <!--  <h1>Input Groups</h1>
                            <form role="form">
                                <div class="form-group input-group">
                                    <span class="input-group-addon">@</span>
                                    <input type="text" class="form-control" placeholder="Username">
                                </div>
                                <div class="form-group input-group">
                                    <input type="text" class="form-control">
                                    <span class="input-group-addon">.00</span>
                                </div>
                                <div class="form-group input-group">
                                    <span class="input-group-addon"><i class="fa fa-eur"></i>
                                    </span>
                                    <input type="text" class="form-control" placeholder="Font Awesome Icon">
                                </div>
                                <div class="form-group input-group">
                                    <span class="input-group-addon">$</span>
                                    <input type="text" class="form-control">
                                    <span class="input-group-addon">.00</span>
                                </div>
                                <div class="form-group input-group">
                                    <input type="text" class="form-control">
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                                        </button>
                                    </span>
                                </div>

                              -->
                            </form>
                        </div>
                        <!-- /.col-lg-6 (nested) -->
                    </div>
                    <!-- /.row (nested) -->
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
</div>
<!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- jQuery -->
<script src="../vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../vendor/metisMenu/metisMenu.min.js"></script>

<!-- Custom Theme JavaScript -->
<script src="../dist/js/sb-admin-2.js"></script>

</body>

</html>

<?php require_once "../layouts/sb_admin_2/footer.php"; ?>
