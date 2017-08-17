 $(document).ready(function() {
        $("#myform").submit(function(e) {
            e.preventDefault();
            $("#first").hide();
            $("#second").show();
        });
});
