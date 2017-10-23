var correctly_page_for = function (role_id) {
    $.ajax({
        url: '/users/get_divs_for_hiding_and_showing',
        type: 'GET',
        data: {"role_id": role_id},
        success: function (data) {
            var show_div_id = data.show_div_id;
            var hide_div_id = data.hide_div_id;

            $.each(hide_div_id, function (i, val) {
                $('#' + val).hide();
            });
            $.each(show_div_id, function (i, val) {
                $('#' + val).show();
            });

            if (data.multiply_divisions_select == true) {
                $("#user_division_ids").attr("multiple", "multiple");
                get_division_select($('#organizations_check_boxes input[type=checkbox]'));
            }
            else {
                $("#user_division_ids").removeAttr("multiple")
                get_division_select($('#organizations_radio_buttons input[type=radio]'));
            }
        }
    });
}

var insert_in_division_select = function (checkValues) {
    $.ajax({
        url: '/users/get_divisions',
        type: 'GET',
        data: {"organizations": checkValues},
        success: function (data) {
            $(data["organizations"]).each(function () {
                options = []
                $(this[2]).each(function () {
                    options.push('<option value="' + $(this)[0] + '">' + $(this)[1] + '</option>')
                });

                $('#user_division_ids').append(
                    '<optgroup id="organizations_optgroup_' + $(this)[0] + '" label="' + $(this)[1] + '"></optgroup>'
                );
                $("#organizations_optgroup_" + $(this)[0]).append(options)
            });
        }
    });
}

var get_division_select = function (inputs) {
    $("#user_division_ids").empty();
    var checkValues = [];
    inputs.each(function () {
        if ($(this).is(":checked")) {
            checkValues.push($(this).val());
        }
    });
    insert_in_division_select(checkValues);
}

$(document).ready(function () {
    // со старта отображаем только то, что необходимо
    var role_id = $("#user_role_id").val();
    correctly_page_for(role_id)

    // при изменении роли отображаем только то, что необходимо
    $("#user_role_id").change(function () {
        var role_id = $(this).val();
        correctly_page_for(role_id)
    });

    // при изменении организаций чекбоксами отображаем только необходимые подразделения
    $('#organizations_check_boxes').change(function () {
        get_division_select($('#organizations_check_boxes input[type=checkbox]'));
    });

    // при изменении организаций радио кнопками отображаем только необходимые подразделения
    $('#organizations_radio_buttons').change(function () {
        get_division_select($('#organizations_radio_buttons input[type=radio]'));
    });

    // при сабмите уничтожаем скрытые формы
    $('input[type="submit"]').click(function () {
        $('#organizations_radio_buttons').remove(":hidden");
        $('#organizations_check_boxes').remove(":hidden");
        $('#divisions_select').remove(":hidden");
    })
})


// $(document).ready(function () {
//     var selected = document.getElementById("user_role_id").options.selectedIndex;
//     var default_option = document.getElementById("user_role_id").options[selected];
//     Selected(default_option);
//
//     $('input[type="submit"]').click(function () {
//         $('#organizations_radio_buttons').remove(":hidden")
//         $('#organizations_check_boxes').remove(":hidden")
//         $('#divisions_select').remove(":hidden")
//     })
// });
//
// function Selected(option) {
//     var label = option.value;
//
//     if (label == 1) {
//         $("#organizations_check_boxes").hide('slow')
//         $("#organizations_radio_buttons").hide('slow')
//         $("#divisions_select").hide('slow')
//     } else if (label == 4) {
//         $("#organizations_radio_buttons").hide('slow')
//         $("#organizations_check_boxes").show('slow')
//         $("#divisions_select").show('slow')
//         $("#user_division_ids").attr("multiple","multiple")
//     } else if (label == 6) {
//         $("#organizations_radio_buttons").show('slow')
//         $("#organizations_check_boxes").hide('slow')
//         $("#divisions_select").show('slow')
//         $("#user_division_ids").removeAttr("multiple")
//     }
// }
//
// var correctly_page = function () {
//     $("#organizations_check_boxes").hide()
//     $("#organizations_radio_buttons").hide()
// }
