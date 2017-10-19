$(document).ready(function () {
    var selected = document.getElementById("user_role_id").options.selectedIndex;
    var default_option = document.getElementById("user_role_id").options[selected];
    Selected(default_option);

    $('input[type="submit"]').click(function () {
        $('#organizations_radio_buttons').remove(":hidden")
        $('#organizations_check_boxes').remove(":hidden")
        $('#divisions_select').remove(":hidden")
    })
});

function Selected(option) {
    var label = option.value;

    if (label == 1) {
        $("#organizations_check_boxes").hide('slow')
        $("#organizations_radio_buttons").hide('slow')
        $("#divisions_select").hide('slow')
    } else if (label == 4) {
        $("#organizations_radio_buttons").hide('slow')
        $("#organizations_check_boxes").show('slow')
        $("#divisions_select").show('slow')
        $("#user_division_ids").attr("multiple","multiple")
    } else if (label == 6) {
        $("#organizations_radio_buttons").show('slow')
        $("#organizations_check_boxes").hide('slow')
        $("#divisions_select").show('slow')
        $("#user_division_ids").removeAttr("multiple")
    }
}