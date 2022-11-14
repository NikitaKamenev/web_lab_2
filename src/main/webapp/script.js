$(document).ready(function () {

    var x, y, r;


    $('select[name="r"]').change(function () {
        $('.r2p').html(+$(this).val()/2);
        $('.r2n').html(-($(this).val()/2));
        $('.rp').html(+$(this).val());
        $('.rn').html(-$(this).val());
    });

    $('.buttons_wrapper button').click(function (e) {
        e.preventDefault();
        if($(this).hasClass('active')){
            $(this).removeClass('active');
        } else {
            $('.buttons_wrapper button').removeClass('active');
            $(this).addClass('active');
        }
    });

    $('input, select, button').on('focus change click', function () {
        $('#error').html("");
    })

    function isFloat(n) {
        return !isNaN(parseFloat(n)) && isFinite(n);
    }

    function inRange(n, start, stop) {
        return parseFloat(n) >= parseFloat(start) && parseFloat(n) <= parseFloat(stop);
    }

    function checkX() {
        x = $('button.active').text();
        return isFloat(x) ? inRange(x, -4, 4) : false;
    }

    function checkY() {
        y = $('input[name="y"]').val().replace(",", ".");
        return isFloat(y) ? inRange(y, -3, 5) : false;
    }

    function checkR() {
        r = $('select[name="r"] option:selected').val()
        return isFloat(r) ? inRange(r, 1, 3) : false;
    }


    function checkInput() {
        return checkX() && checkY() && checkR();
    }


    function appendRow(data) {
        $('#result_table tbody').prepend(`
			<tr class="${data.hit ? "hit" : "lose"}">
			<td>${data.id}</td>
			<td>${data.x}</td>
			<td>${data.y}</td>
			<td>${(new Number(data.r)).toPrecision(2)}</td>
			<td>${data.hit ? "Да" : "Нет"}</td>
			<td>${data.executionTimeMS+ " ms"}</td>
			<td>${data.currentTime}</td>
			</tr>
			`);

        appendPoint(data);
    }

    function makeSVG(tag, attrs) {
        var el= document.createElementNS('http://www.w3.org/2000/svg', tag);
        for (var k in attrs)
            el.setAttribute(k, attrs[k]);
        return el;
    }


    function appendPoint(data) {
        var circle= makeSVG('circle', {cx: data.x*$('#chart').attr('width')*0.4/r + $('#chart').attr('width') / 2, cy: -data.y*$('#chart').attr('height')*0.4/r + $('#chart').attr('height') / 2, r:3, fill: data.hit ? "green" : "red"});
        $('#chart').append(circle);
    }

    $("#check_form").on('submit', function (e) {
        e.preventDefault();
        if (checkInput()) {
            sendAjax();
        } else {
            $("#check_form").trigger('reset');
            $('#error').html("Проверьте корректное заполнение всех полей формы");
        }
    });


    $('#chart').click(function (e) {
        const rect = this.getBoundingClientRect();
        const X = (e.clientX - rect.left) - $('#chart').width() / 2;
        const Y = $('#chart').height() / 2 - (e.clientY - rect.top);
        if(!checkR()){
            $('#error').html("Укажите радиус");
            return;
        }
        x = (r * X / ($('#chart').width() * 0.4)).toPrecision(6);
        y = (r * Y / ($('#chart').height() * 0.4)).toPrecision(6);
        sendAjax();
    });

    function sendAjax() {
        $.ajax({
            type: "POST",
            url: "controller",
            data: {
                "x": x,
                "y": y,
                "r": r,
            },
            success: appendRow,
            dataType: "json"
        });
    }


    $("#button_reset").on('click', function (e) {
        $.ajax({
            type: "GET",
            url: "clear",
            success: function () {
                $('#result_table tbody').html("");
                $('#chart>circle').remove()
            }
        });
    });




});