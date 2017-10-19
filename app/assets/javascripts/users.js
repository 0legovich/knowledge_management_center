$(document).ready(function () {
    var selected = document.getElementById("user_role_id").options.selectedIndex;
    var default_option = document.getElementById("user_role_id").options[selected];
    Selected(default_option);

    $('input[type="submit"]').click(function () {
        $('#organizations_select').remove(":hidden")
        $('#organizations_check_boxes').remove(":hidden")
    })
});

function Selected(option) {
    var label = option.value;

    if (label == 1) {
        $("#organizations_check_boxes").hide('slow')
        $("#organizations_select").hide('slow')
    } else if (label == 4) {
        $("#organizations_select").hide('slow')
        $("#organizations_check_boxes").show('slow')
    } else if (label == 6) {
        $("#organizations_select").show('slow')
        $("#organizations_check_boxes").hide('slow')
    }
}