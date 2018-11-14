

<!-- jQuery -->
<script src="../includes/vendor/jquery/jquery.min.js"></script>

<!-- DataTables JavaScript -->
<script src="../includes/vendor/datatables/js/jquery.dataTables.min.js"></script>
<script src="../includes/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
<script src="../includes/vendor/datatables-responsive/dataTables.responsive.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="../includes/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Metis Menu Plugin JavaScript -->
<script src="../includes/vendor/metisMenu/metisMenu.min.js"></script>



<!-- Custom Theme JavaScript -->
<script src="../includes/dist/js/sb-admin-2.js"></script>

<!-- Page-Level Demo Scripts - Tables - Use for reference -->
<script>
$(document).ready(function() {
    $('#dataTables-example').DataTable({
        responsive: true
    });
});
</script>

<script>
$(document).ready(function(){
    $('table tr').click(function(){
        window.location = $(this).data('href');
        return false;
    });
});
</script>
</body>

</html>
